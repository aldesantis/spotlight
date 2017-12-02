# frozen_string_literal: true

RSpec.describe Webhooks::Process::Parse do
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

    it 'extracts the project from the payload' do
      expect(context.project).to eq(project)
    end

    it 'extracts the commit SHA1 from the payload' do
      expect(context.commit).to eq('testsha1')
    end
  end

  context 'when it cannot find the related project' do
    let(:project) { nil }

    it 'fails the context' do
      expect(context).to be_failure
    end
  end
end
