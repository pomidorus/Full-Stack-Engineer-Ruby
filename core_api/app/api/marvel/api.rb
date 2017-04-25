module Marvel
  class API < Grape::API
    format :json
    helpers do
      def comics_paginated
        ComicPaginator.paginate(Comic.all_ordered_by_date, params[:page])
      end

      def comics_paginated_search
        ComicPaginator.paginate(Comic.search_ordered_by_date(params[:search]), params[:page])
      end

      def paginated_cache_name
        "comics/#{Comic.count}-#{params[:page]}/ordered_comics"
      end

      def paginated_search_cache_name
        "comics/#{Comic.count}-#{params[:page]}/#{params[:search]}/ordered_comics"
      end

      def comic
        @comic ||= Comic.find_by_comic_id(params[:id])
      end

      def comic_not_found
        status 404
        { error: 'Comic with this ID do not exists'}
      end
    end

    desc 'List all comics from Marvell'
    params do
      requires :page, type: Integer, desc: 'Number of the page'
      optional :search, type: String, desc: 'Search comics by characters'
    end
    get '/comics' do
      if params[:search].nil?
        Rails.cache.fetch(paginated_cache_name, expires_in: 12.hours) do
          { comics: comics_paginated }
        end
      else
        Rails.cache.fetch(paginated_search_cache_name, expires_in: 12.hours) do
          { comics: comics_paginated_search }
        end
      end
    end

    desc 'Upvote comic'
    params do
      requires :id, type: Integer, desc: 'Comic ID from Marvel DB'
    end
    post '/comics/:id/upvote' do
      return comic_not_found if comic.nil?
      comic.update_attributes(upvoted: !comic.upvoted)
      { upvoted: comic.upvoted }
    end
  end
end
