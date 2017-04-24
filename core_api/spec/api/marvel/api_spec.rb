require 'rails_helper'

describe Marvel::API, type: :request do
  before do
    10.times do
      create(:comic)
    end
  end

  describe 'GET /comics' do
    it 'returns paginated response' do
      get '/comics', params: { page: 1 }
      hash_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(hash_response['comics'].count).to eq(5)
    end
  end
end
