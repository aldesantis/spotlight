# frozen_string_literal: true

RSpec.describe Analyses::PerformJob do
  subject { -> { described_class.perform_now(analysis) } }

  let(:analysis) { build_stubbed(:analysis) }

  it 'calls the Perform interactor' do
    expect(Analyses::Perform).to receive(:call!)
      .with(analysis: analysis)
      .once

    subject.call
  end
end
