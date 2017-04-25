require 'rails_helper'

describe Marvel::API, type: :request do
  before do
    20.times do
      create(:comic)
    end
    create(:comic, characters:'Hulk Panthera')
  end

  describe 'GET /comics?page=' do
    it 'returns paginated response' do
      get '/comics', params: { page: 1 }
      hash_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(hash_response['comics'].count).to eq(12)
    end
  end

  # describe 'GET /comics?page=&search=' do
  #   it 'returns paginated response' do
  #     get '/comics', params: { page: 1, search: 'Hulk' }
  #     hash_response = JSON.parse(response.body)
  #
  #     expect(response.status).to eq(200)
  #     expect(hash_response['comics'].count).to eq(1)
  #   end
  # end
end
