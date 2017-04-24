class ComicPaginator
  def self.paginate(array, page)
    Kaminari.paginate_array(array).page(page)
  end
end
