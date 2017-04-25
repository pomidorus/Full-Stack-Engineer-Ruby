class Comic < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :comic_id, presence: true
  validates :title, presence: true
  validates :year, presence: true, allow_nil: false
  validates :issue_number, presence: true
  validates :thumbnail_url, presence: true
  validates :characters, presence: true, allow_blank: true

  def self.all_ordered_by_date
    all.sort_by{|c| [c.year, c.issue_number]}.reverse
  end

  def self.search_ordered_by_date(string)
    search(string).records.sort_by{|c| [c.year, c.issue_number]}.reverse
  end
end
