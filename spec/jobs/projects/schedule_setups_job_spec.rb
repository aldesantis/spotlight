# frozen_string_literal: true

RSpec.describe Projects::ScheduleSetupsJob do
  subject { -> { described_class.perform_now } }

  let(:project) { build_stubbed(:project) }

  before do
    relation = instance_double('Project::ActiveRecord_Relation')

    allow(Project).to receive(:pending_setup)
      .and_return(relation)

    allow(relation).to receive(:find_each)
      .and_yield(project)
  end

  it 'schedules the setup of each project pending setup' do
    expect(Projects::SetUpJob).to receive(:perform_later)
      .with(project)
      .once

    subject.call
  end
end
