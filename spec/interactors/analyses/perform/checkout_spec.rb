# frozen_string_literal: true

RSpec.describe Analyses::Perform::Checkout do
  subject(:context) { described_class.call(analysis: analysis) }

  let(:analysis) { build_stubbed(:analysis) }

  let(:octokit) { instance_double('Octokit::Client') }
  let(:git) { instance_double('Git::Base') }

  before do
    allow(FileUtils).to receive(:mkpath)

    allow(Git).to receive(:clone)
      .and_return(git)

    allow(analysis.project).to receive(:base_path)
      .and_return('test_base_path')

    allow(analysis.project).to receive(:octokit)
      .and_return(octokit)

    allow(octokit).to receive(:login)
      .and_return('jdoe')

    allow(git).to receive(:checkout)
  end

  it 'sets up the base project path' do
    expect(FileUtils).to receive(:mkpath)
      .with(analysis.project.base_path)
      .once

    context
  end

  it 'clones the repo in the project path' do
    expect(Git).to receive(:clone)
      .with(an_instance_of(String), analysis.commit, path: analysis.project.base_path)
      .once
      .and_return(git)

    context
  end

  it 'checks out the commit' do
    expect(git).to receive(:checkout)
      .with(analysis.commit)
      .once

    context
  end
end
