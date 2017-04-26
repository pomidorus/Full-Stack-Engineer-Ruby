class MarvelGrabber
  LIMIT = ENV['GRABBER_LIMIT'].to_i
  PAGES = ENV['GRABBER_PAGES'].to_i
  FORMAT = 'comic'
  FORMAT_TYPE = 'comic'
  ORDER_BY = '-modified'

  def initialize(marvel_client, marvel_data_saver)
    @marvel_client = marvel_client
    @data_saver = marvel_data_saver
  end

  def collect_data
    (1..PAGES).each do |page|
      params = {
        format: FORMAT,
        formatType: FORMAT_TYPE,
        limit: LIMIT,
        offset: (page - 1) * LIMIT,
        orderBy: ORDER_BY
      }

      data = @marvel_client.comics(params)
      @data_saver.save(data)
      puts "Complete #{page} page"
    end
  end
end
