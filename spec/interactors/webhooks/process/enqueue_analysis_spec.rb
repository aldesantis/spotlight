# frozen_string_literal: true

RSpec.describe Webhooks::Process::EnqueueAnalysis do
  subject(:context) { described_class.call(project: project, commit: commit) }

  let(:project) { build_stubbed(:project) }
  let(:commit) { 'testsha1' }

  it 'enqueues an analysis' do
    expect(Analysis).to receive(:create!)
      .with(project: project, commit: commit)
      .once

    context
  end
end
