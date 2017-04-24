module Marvel
  class API < Grape::API
    format :json

    desc 'List all comics from Marvell'
    params do
      requires :page, type: Integer, desc: 'Number of the page'
    end
    get '/comics' do
      Rails.cache.fetch("comics/#{Comic.count}-#{params[:page]}/ordered_comics", expires_in: 12.hours) do
        { comics: ComicPaginator.paginate(Comic.all_ordered_by_date, params[:page]) }
      end
    end
  end
end
