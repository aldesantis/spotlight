# frozen_string_literal: true

RSpec.describe Projects::SetUp do
  subject(:context) { described_class.call(project: project) }

  let(:project) { build_stubbed(:project) }

  before do
    allow(Webhooks::Create).to receive(:call!)
    allow(project).to receive(:update!)
  end

  it 'creates the webhook' do
    expect(Webhooks::Create).to receive(:call!)
      .with(project: project)
      .once

    context
  end

  it 'marks the project as set up' do
    expect(project).to receive(:update!)
      .with(set_up_at: an_instance_of(ActiveSupport::TimeWithZone))
      .once

    context
  end
end
