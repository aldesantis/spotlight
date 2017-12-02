# frozen_string_literal: true

RSpec.describe Analyses::Perform::MarkCompleted do
  subject(:context) { described_class.call(analysis: analysis) }

  let(:analysis) { build_stubbed(:analysis) }

  let(:octokit) { instance_double('Octokit::Client') }

  before do
    allow(analysis.project).to receive(:octokit)
      .and_return(octokit)

    allow(analysis.project.octokit).to receive(:create_status)

    allow(analysis).to receive(:update!)
  end

  it 'marks the analysis as completed' do
    expect(analysis).to receive(:update!)
      .with(status: :completed)
      .once

    context
  end

  it 'creates the GitHub commit status' do
    expect(analysis.project.octokit).to receive(:create_status)
      .with(
        analysis.project.repo_uri,
        analysis.commit,
        'success',
        a_hash_including(context: ENV.fetch('GITHUB_CONTEXT'))
      )
      .once

    context
  end
end
