# frozen_string_literal: true

RSpec.describe Webhooks::Process do
  subject(:context) { described_class.call(payload: payload) }

  let(:payload) do
    {
      'repository' => {
        'full_name' => 'org/test'
      },
      'after' => 'testsha1'
    }
  end

  before do
    allow(Project).to receive(:find_by)
      .with(repo_provider: :github, repo_uri: payload['repository']['full_name'])
      .and_return(project)
  end

  context 'when it finds the related project' do
    let(:project) { build_stubbed(:project) }

    it 'enqueues an analysis' do
      expect(Analysis).to receive(:create!)
        .with(project: project, commit: payload['after'])
        .once

      context
    end
  end

  context 'when it cannot find the related project' do
    let(:project) { nil }

    it 'fails' do
      expect(context).to be_failure
    end
  end
end
