# frozen_string_literal: true

RSpec.describe '/webooks' do
  describe 'POST /push' do
    subject { -> { post push_webhook_path, data.to_json } }

    let(:data) { { message: Time.zone.now.to_i } }

    before do
      allow(Webhooks::Process).to receive(:call)
        .and_return(OpenStruct.new(success?: true, failure?: false))
    end

    it 'responds with 204 No Content' do
      subject.call
      expect(last_response.status).to eq(204)
    end
  end
end
