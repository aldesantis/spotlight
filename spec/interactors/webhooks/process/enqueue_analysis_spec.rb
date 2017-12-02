# frozen_string_literal: true

RSpec.describe Webhooks::Process::EnqueueAnalysis do
  subject(:context) { described_class.call(project: project, commit: commit) }

  let(:project) { build_stubbed(:project) }
  let(:commit) { 'testsha1' }

  let(:analysis) { build_stubbed(:analysis) }

  before do
    allow(Analysis).to receive(:create!)
      .and_return(analysis)

    allow(Analyses::PerformJob).to receive(:perform_later)
  end

  it 'creates a new analysis' do
    expect(Analysis).to receive(:create!)
      .with(project: project, commit: commit)
      .once

    context
  end

  it 'enqueues the analysis' do
    expect(Analyses::PerformJob).to receive(:perform_later)
      .with(analysis)
      .once

    context
  end
end
