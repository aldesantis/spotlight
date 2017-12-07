# frozen_string_literal: true

RSpec.describe Analyses::Perform::GetSwagger do
  subject(:context) { described_class.call(analysis: analysis, config: config) }

  let(:analysis) { build_stubbed(:analysis) }
  let(:config) do
    {
      'swagger_url' => 'https://example.com/api.json'
    }
  end

  context 'when the Swagger schema can be retrieved and parsed' do
    let(:swagger) { JSON.dump(swagger: '2.0') }

    before do
      allow(Faraday).to receive(:get)
        .with(config['swagger_url'])
        .and_return(instance_double('Faraday::Response', body: swagger))
    end

    it 'parses the schema' do
      expect(context.swagger).to eq('swagger' => '2.0')
    end
  end

  context 'when the Swagger schema cannot be retrieved' do
    before do
      allow(Faraday).to receive(:get)
        .with(config['swagger_url'])
        .and_raise(Faraday::Error)
    end

    it 'fails the analysis' do
      expect(Analyses::MarkFailure).to receive(:call!)
        .with(a_hash_including(analysis: analysis))
        .once

      context
    end
  end

  context 'when the Swagger schema cannot be parsed' do
    let(:swagger) { 'error' }

    before do
      allow(Faraday).to receive(:get)
        .with(config['swagger_url'])
        .and_return(instance_double('Faraday::Response', body: swagger))
    end

    it 'fails the analysis' do
      expect(Analyses::MarkFailure).to receive(:call!)
        .with(a_hash_including(analysis: analysis))
        .once

      context
    end
  end
end
