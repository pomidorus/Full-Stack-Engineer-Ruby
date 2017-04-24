require 'rails_helper'

describe Marvel::API, type: :request do
  let!(:comic_2) { create :comic }

  describe 'GET /comics' do
    it '' do
      get '/comics'
      hash_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(hash_response['comics'].count).to eq(1)
    end
  end
end
