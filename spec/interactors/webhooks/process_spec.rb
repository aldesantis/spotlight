# frozen_string_literal: true

RSpec.describe Webhooks::Process do
  subject(:context) { described_class.call(payload: payload) }

  let(:payload) do
    { 'foo' => 'bar' }
  end

  it 'does not raise an error' do
    expect { context }.not_to raise_error
  end
end
