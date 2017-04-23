class Comic < ApplicationRecord
  validates :comic_id, presence: true
  validates :title, presence: true
  validates :year, presence: true, allow_nil: false
  validates :issue_number, presence: true
  validates :thumbnail_url, presence: true
  validates :characters, presence: true, allow_blank: true
end
