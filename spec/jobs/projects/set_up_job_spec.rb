# frozen_string_literal: true

RSpec.describe Projects::SetUpJob do
  subject { -> { described_class.perform_now(project) } }

  let(:project) { build_stubbed(:project) }

  it 'calls the Setup interactor' do
    expect(Projects::SetUp).to receive(:call!)
      .with(project: project)
      .once

    subject.call
  end
end
