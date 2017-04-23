class MarvelDataSaver
  def initialize

  end

  def save(data)
    data[:data][:results].map &method(:create_comic)
  end

  private

  def create_comic(hash)
    Comic.create!(comic_params(hash))
  end

  def comic_params(hash)
    {
      comic_id: hash[:id].to_i,
      title: hash[:title],
      year: year_from_title(hash[:title]),
      issue_number: hash[:issueNumber].to_i,
      thumbnail_url: "#{hash[:thumbnail][:path]}.#{hash[:thumbnail][:extension]}",
      characters:  hash[:characters][:items].map{|e| e[:name]}.join(', ')
    }
  end

  def year_from_title(string)
    string.match(/[(](\d+)[)]/)[1].to_i unless string.match(/[(](\d+)[)]/).nil?
  end
end
