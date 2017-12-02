# frozen_string_literal: true

require 'fakefs/spec_helpers'

RSpec.describe Analyses::Perform::ParseConfig do
  include FakeFS::SpecHelpers

  subject(:context) { described_class.call(analysis: analysis) }

  let(:analysis) { build_stubbed(:analysis) }

  before do
    allow(analysis).to receive(:config_path)
      .and_return('spotlight.json')
  end

  around do |example|
    FakeFS.with_fresh(&example)
  end

  context 'when a configuration file exists' do
    before do
      File.write(analysis.config_path, JSON.dump(oas_url: 'https://example.com/api.json'))
    end

    it 'parses the configuration' do
      expect(context.config).to eq('oas_url' => 'https://example.com/api.json')
    end
  end

  context 'when a configuration file does not exist' do
    let(:octokit) { instance_double('Octokit::Client') }

    before do
      allow(analysis.project).to receive(:octokit)
        .and_return(octokit)

      allow(analysis).to receive(:update!)

      allow(octokit).to receive(:create_status)
    end

    it 'fails the context' do
      expect(context).to be_failure
    end

    it 'marks the analysis as failed' do
      expect(analysis).to receive(:update!)
        .with(status: :failed)
        .once

      context
    end

    it 'reports the error to GitHub' do
      expect(octokit).to receive(:create_status)
        .with(
          analysis.project.repo_uri,
          analysis.commit,
          'error',
          a_hash_including(context: ENV.fetch('GITHUB_CONTEXT'))
        )
        .once

      context
    end
  end
end
