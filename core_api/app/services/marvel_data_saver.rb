class MarvelDataSaver
  YEAR_REG = /[(](\d+)[)]/
  NUMBER_REG = /#\d+/
  NEGATIVE_NUMBER_REG = /#-\d+/
  YEAR_NUMBER_REG = /[(]\d+[)]\s+#\d+/

  def save(data)
    data[:data][:results].map &method(:create_comic)
  end

  private

  def create_comic(hash)
    Comic.find_or_create_by!(comic_params(hash))
  end

  def comic_params(hash)
    {
      comic_id: hash[:id].to_i,
      title: clear_title(hash[:title]),
      year: year_from_title(hash[:title]),
      issue_number: hash[:issueNumber].to_i,
      thumbnail_url: "#{hash[:thumbnail][:path]}.#{hash[:thumbnail][:extension]}",
      characters:  hash[:characters][:items].map{|e| e[:name]}.join(', ')
    }
  end

  def year_from_title(string)
    string.match(YEAR_REG)[1].to_i unless string.match(YEAR_REG).nil?
  end

  def clear_title(string)
    string.gsub(YEAR_REG, '').gsub(NUMBER_REG, '').gsub(NEGATIVE_NUMBER_REG, '').strip
  end
end
