class MarvelClient
  def initialize
    @client = Marvelite::API::Client.new(
      public_key: ENV['MARVEL_PUBLIC_KEY'],
      private_key: ENV['MARVEL_SECRET_KEY']
    )
  end

  def comics
    @client.comics(format: 'graphic novel', limit: 10, offset: 20)
  end
end
