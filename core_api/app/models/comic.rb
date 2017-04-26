require 'elasticsearch'
require 'elasticsearch/model'

class Comic < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :comic_id, presence: true
  validates :title, presence: true
  validates :year, presence: true, allow_nil: false
  validates :issue_number, presence: true
  validates :thumbnail_url, presence: true
  validates :characters, presence: true, allow_blank: true

  scope :all_with_images, -> { where.not("thumbnail_url ILIKE '%image_not_available.jpg%'") }

  def self.all_ordered_by_date
    all_with_images.sort_by{|c| [c.year, c.issue_number]}.reverse
  end

  def self.search_ordered_by_date(string)
    search(string).page(1).records.all_with_images.sort_by{|c| [c.year, c.issue_number]}.reverse
  end
end
