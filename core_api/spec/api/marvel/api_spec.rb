require 'rails_helper'

describe Marvel::API, type: :request do
  describe 'GET /comics?page=' do
    before do
      20.times do
        create(:comic)
      end
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
    let!(:comic) {create(:comic, upvoted: upvoted, comic_id: comic_id)}

    context 'when upvoted true' do
      let(:upvoted) { false }
      it 'returns upvote comic' do
        post "/comics/#{comic_id}/upvote"
        hash_response = JSON.parse(response.body)

        expect(response.status).to eq(201)
        expect(hash_response['upvoted']).to eq(true)
      end
    end

    context 'when upvoted false' do
      let(:upvoted) { true }
      it 'returns upvote comic' do
        post "/comics/#{comic_id}/upvote"
        hash_response = JSON.parse(response.body)

        expect(response.status).to eq(201)
        expect(hash_response['upvoted']).to eq(false)
      end
    end

    context 'when comic id do not exists' do
      let(:upvoted) { true }

      it 'returns error' do
        post "/comics/2222/upvote"
        hash_response = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(hash_response['error']).to eq('Comic with this ID do not exists')
      end
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
