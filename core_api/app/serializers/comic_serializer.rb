class ComicSerializer < ActiveModel::Serializer
  attributes :comic_id, :year, :title, :issue_number, :thumbnail_url, :upvoted
end
