require 'rails_helper'

describe Marvel::API, type: :request do
  describe 'GET /comics?page=' do
    before do
      20.times do
        create(:comic)
      end
      create(:comic, characters:'Hulk Panthera')
    end

    it 'returns paginated response' do
      get '/comics', params: { page: 1 }
      hash_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(hash_response['comics'].count).to eq(12)
    end
  end

  describe 'POST /comics/:id/upvote' do
    let(:comic_id) { 111 }
    let!(:comic) {create(:comic, upvoted: false, comic_id: 111)}

    it 'returns upvote comic' do
      post "/comics/#{comic_id}/upvote"
      hash_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(hash_response['upvoted']).to eq(true)
    end
  end

  # TODO: Do not find a quick way to test elastic search with rspec
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
