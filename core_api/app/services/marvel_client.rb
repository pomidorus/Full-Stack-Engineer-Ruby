class MarvelClient
  def initialize
    @client = Marvelite::API::Client.new(
      public_key: ENV['MARVEL_PUBLIC_KEY'],
      private_key: ENV['MARVEL_SECRET_KEY']
    )
  end

  def comics(params)
    @client.comics(params)
  end
end
