module Marvel
  class API < Grape::API
    format :json

    desc 'List all comics from Marvell'
    get '/comics' do
      Rails.cache.fetch("comics/#{Comic.count}/ordered_comics", expires_in: 12.hours) do
        Comic.all.sort_by{|c| [c.year, c.issue_number]}.reverse
      end
    end
  end
end
