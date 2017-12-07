# frozen_string_literal: true

RSpec.describe Analyses::Perform::ParseConfig do
  subject(:context) { described_class.call(analysis: analysis) }

  let(:analysis) { build_stubbed(:analysis) }

  before do
    allow(analysis).to receive(:config_path)
      .and_return('spotlight.json')
  end

  context 'when a configuration file exists' do
    before do
      File.write(analysis.config_path, JSON.dump(swagger_url: 'https://example.com/api.json'))
    end

    after { File.unlink(analysis.config_path) }

    it 'parses the configuration' do
      expect(context.config).to eq('swagger_url' => 'https://example.com/api.json')
    end
  end

  context 'when a configuration file does not exist' do
    it 'fails the analysis' do
      expect(Analyses::MarkFailure).to receive(:call!)
        .with(a_hash_including(analysis: analysis))
        .once

      context
    end
  end
end
