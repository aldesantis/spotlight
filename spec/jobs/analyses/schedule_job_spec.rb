# frozen_string_literal: true

RSpec.describe Analyses::ScheduleJob do
  subject { -> { described_class.perform_now } }

  let(:analysis) { build_stubbed(:analysis) }

  before do
    relation = instance_double('Analysis::ActiveRecord_Relation')

    allow(Analysis).to receive(:queued_ordered)
      .and_return(relation)

    allow(relation).to receive(:find_each)
      .and_yield(analysis)
  end

  it 'schedules the setup of each queued analysis' do
    expect(Analyses::PerformJob).to receive(:perform_later)
      .with(analysis)
      .once

    subject.call
  end
end
