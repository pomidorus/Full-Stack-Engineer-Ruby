module Marvel
  class API < Grape::API
    format :json

    desc 'List all comics from Marvell'
    get '/comics' do
      marvel_client = MarvelClient.new
      marvel_client.comics
    end
  end
end
