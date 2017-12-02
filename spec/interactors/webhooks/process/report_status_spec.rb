# frozen_string_literal: true

RSpec.describe Webhooks::Process::ReportStatus do
  subject(:context) { described_class.call(project: project, commit: commit) }

  let(:project) { build_stubbed(:project) }
  let(:commit) { 'testsha1' }

  let(:octokit) { instance_double('Octokit::Client') }

  before do
    allow(project).to receive(:octokit)
      .and_return(octokit)
  end

  it 'reports the analysis has been enqueued' do
    expect(octokit).to receive(:create_status)
      .with(
        project.repo_uri,
        commit,
        'pending',
        a_hash_including(context: ENV.fetch('GITHUB_CONTEXT'))
      )
      .once

    context
  end
end
