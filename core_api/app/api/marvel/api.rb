module Marvel
  class API < Grape::API
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    helpers do
      def cache_key
        "comics/#{params[:page]}/ordered_comics"
      end

      def search_cache_key
        q_key = params[:q].gsub(/[^0-9A-Za-z]/, '').strip
        "comics/#{q_key}/ordered_comics"
      end

      def comics
        ComicPaginator.paginate(Comic.all_ordered_by_date, params[:page])
      end

      def search_comics
        Comic.search_ordered_by_date(params[:q])
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
    end
    get '/comics', each_serializer: ComicSerializer, root: 'comics' do
      Rails.cache.fetch(cache_key, expires_in: 12.hours) do
        comics
      end
    end

    desc 'Search comic by query'
    params do
      requires :q, type: String, desc: 'Search query'
    end
    get '/comics/search', each_serializer: ComicSerializer, root: 'comics' do
      Rails.cache.fetch(search_cache_key, expires_in: 12.hours) do
        search_comics
      end
    end

    desc 'Upvote comic'
    params do
      requires :id, type: Integer, desc: 'Comic ID from Marvel DB'
      requires :page, type: Integer, desc: 'Number of the page'
    end
    post '/comics/:id/upvote' do
      return comic_not_found if comic.nil?

      Rails.cache.delete(cache_key)

      comic.update_attributes(upvoted: !comic.upvoted)
      { upvoted: comic.upvoted }
    end
  end
end
