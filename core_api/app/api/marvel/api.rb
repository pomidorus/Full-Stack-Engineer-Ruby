module Marvel
  class API < Grape::API
    format :json

    desc 'List all comics from Marvell'
    get '/comics' do
      {hello: 'hello'}
    end
  end
end
