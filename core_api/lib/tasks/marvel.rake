namespace :marvel do
  desc 'grab data'
  task grab_data: :environment do
    marvel_client = MarvelClient.new
    marvel_data_saver = MarvelDataSaver.new

    marvel_grabber = MarvelGrabber.new(marvel_client, marvel_data_saver)
    marvel_grabber.collect_data
  end
end
