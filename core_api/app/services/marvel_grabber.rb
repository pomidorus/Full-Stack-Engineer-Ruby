class MarvelGrabber
  LIMIT = 10
  PAGES = 2
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
    end
  end
end
