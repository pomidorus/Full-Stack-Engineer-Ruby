namespace :marvel do
  desc 'grab data from Marvel API to app DB'
  task grab_data: :environment do
    marvel_client = MarvelClient.new
    marvel_data_saver = MarvelDataSaver.new

    marvel_grabber = MarvelGrabber.new(marvel_client, marvel_data_saver)

    puts 'Starting collect data...'
    marvel_grabber.collect_data
    puts '...completed'
  end

  desc 'clear comic data in the app DB'
  task remove_data: :environment do
    puts 'Starting deleting comic data...'
    Comic.delete_all
    puts '...completed'
  end
end
