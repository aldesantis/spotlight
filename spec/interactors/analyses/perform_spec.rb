# frozen_string_literal: true

RSpec.describe Analyses::Perform do
  subject(:context) { described_class.call(analysis: analysis) }

  let(:analysis) { build_stubbed(:analysis) }

  let(:octokit) { instance_double('Octokit::Client') }

  before do
    allow(analysis.project).to receive(:octokit)
      .and_return(octokit)

    allow(analysis).to receive(:update!)
  end

  it 'creates two statuses' do
    expect(analysis.project.octokit).to receive(:create_status)
      .with(analysis.project.repo_uri, analysis.commit, any_args)
      .twice

    context
  end
end
