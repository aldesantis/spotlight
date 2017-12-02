# frozen_string_literal: true

RSpec.describe Analyses::Perform::RunChecks do
  subject(:context) { described_class.call(analysis: analysis) }

  let(:analysis) { build_stubbed(:analysis) }

  it 'runs successfully' do
    expect(context).to be_success
  end
end
