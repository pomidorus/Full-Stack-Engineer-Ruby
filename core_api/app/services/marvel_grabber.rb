class MarvelGrabber
  LIMIT = 10
  PAGES = 2
  FORMAT = 'comic'
  FORMAT_TYPE = 'comic'

  def initialize(marvel_client)
    @marvel_client = marvel_client
  end

  def collect_data
    (1..PAGES).each do |page|
      params = {
        format: FORMAT,
        formatType: FORMAT_TYPE,
        limit: LIMIT,
        offset: (page - 1) * LIMIT
      }

      data = @marvel_client.comics(params)
      puts data.inspect
    end
  end
end
