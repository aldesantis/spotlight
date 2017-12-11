RSpec.describe Analyses::MarkFailure do
  subject(:context) { described_class.call(analysis: analysis, message: message) }

  let(:message) { 'test error message' }
  let(:analysis) { build_stubbed(:analysis) }

  let(:octokit) { instance_double('Octokit::Client') }

  before do
    allow(analysis).to receive(:update!)

    allow(analysis.project).to receive(:octokit)
      .and_return(octokit)

    allow(octokit).to receive(:create_status)
  end

  it 'marks the analysis as a failure' do
    expect(analysis).to receive(:update!)
      .with(status: :failed)
      .once

    context
  end

  it 'updates the commit status' do
    expect(octokit).to receive(:create_status)
      .with(
        analysis.project.repo_uri,
        analysis.commit,
        'error',
        a_hash_including(context: ENV.fetch('GITHUB_CONTEXT'), description: message),
      )
      .once

    context
  end
end
