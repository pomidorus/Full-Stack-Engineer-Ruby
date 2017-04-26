require 'rails_helper'

describe MarvelGrabber do
  let(:client) { MarvelClient.new }
  let(:data_saver) { MarvelDataSaver.new }
  let(:grabber) { MarvelGrabber.new(client, data_saver) }

  describe '#collect_data' do
    before do
      client.client.class.send(:define_method, :ts, lambda { 55555 })
      Comic.send(:define_method, :id, lambda { 111 })
    end

    it 'collects and saves data from Marvel API' do
      VCR.use_cassette("marvel") do
        grabber.collect_data
      end
      expect(Comic.count).to eq(10)
    end
  end
end
