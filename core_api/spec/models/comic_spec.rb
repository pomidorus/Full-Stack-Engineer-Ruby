require 'rails_helper'

describe Comic do
  let!(:comic_1) { create(:comic, year: 2016) }
  let!(:comic_2) { create(:comic, year: 2017) }
  let!(:comic_3) { create(:comic, thumbnail_url: 'http://i.annihil.us/u/image_not_available.jpg') }
  let!(:comic_4) { create(:comic, year: 2016, issue_number: 4) }

  describe '#all_with_images' do
    it 'returns correct values' do
      expect(Comic.all_with_images.count).to eq(3)
      expect(Comic.all_with_images).not_to include(comic_3)
    end
  end

  describe '#all_ordered_by_date' do
    it 'returns correct values' do
      expect(Comic.all_ordered_by_date.count).to eq(3)
      expect(Comic.all_ordered_by_date.first).to eq(comic_2)
      expect(Comic.all_ordered_by_date.last).to eq(comic_1)
    end
  end
end
