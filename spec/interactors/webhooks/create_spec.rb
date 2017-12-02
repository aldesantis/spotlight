# frozen_string_literal: true

RSpec.describe Webhooks::Create do
  subject(:context) { described_class.call(project: project) }

  let(:project) { build_stubbed(:project) }

  let(:octokit) { instance_double('Octokit::Client') }

  before do
    allow(project).to receive(:octokit)
      .and_return(octokit)

    allow(octokit).to receive(:create_hook)
      .with(
        project.repo_uri,
        'web',
        an_instance_of(Hash)
      )
      .once
      .and_return(OpenStruct.new(id: 1))
  end

  it 'sets webhook ID for the repo' do
    expect(project).to receive(:update!)
      .with(webhook_id: 1)
      .once

    context
  end
end
