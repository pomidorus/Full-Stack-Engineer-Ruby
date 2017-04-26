require 'rails_helper'

describe MarvelDataSaver do
  let(:data_saver) { MarvelDataSaver.new }
  let(:data) do
    {
      code: 200,
      status: "Ok",
      copyright: "© 2017 MARVEL",
      attributionText: "Data provided by Marvel. © 2017 MARVEL",
      attributionHTML: "<a href=\"http://marvel.com\">Data provided by Marvel. © 2017 MARVEL</a>",
      etag: "842610fb3a366df40505a6c49730b2c5ccf6c5c6",
      data: {
        offset: 0,
        limit: 3,
        total: 32469,
        count: 3,
        results: [
                    {
                      id: 22735,
                      digitalId: 29248,
                      title: "Generation X (1994) #1",
                      issueNumber: 1,
                      modified: "2016-11-04T17:51:52-0400",
                      thumbnail: {
                        path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/57e031231d84f",
                        extension: "jpg"
                      },
                      characters: {
                        available: 2,
                        collectionURI: "http://gateway.marvel.com/v1/public/comics/22735/characters",
                        items: [
                                 {
                                   resourceURI: "http://gateway.marvel.com/v1/public/characters/1011285",
                                   name: "Generation X"
                                 },
                                 {
                                     resourceURI: "http://gateway.marvel.com/v1/public/characters/1011285",
                                     name: "Hulk"
                                 }
                               ],
                        returned: 2
                      },
                    },
                    {
                      id: 18071,
                      digitalId: 7510,
                      title: "Weapon X (2002) #1",
                      issueNumber: 1,
                      modified: "2017-04-25T18:32:26-0400",
                      thumbnail: {
                        path: "http://i.annihil.us/u/prod/marvel/i/mg/6/70/4bb7d1177c268",
                        extension: "jpg"
                      },
                      characters: {
                        available: 0,
                        collectionURI: "http://gateway.marvel.com/v1/public/comics/18071/characters",
                        items: [],
                        returned: 0
                      },
                    },
                    {
                      id: 57833,
                      digitalId: 41276,
                      title: "Avengers Standoff: Assault On Pleasant Hill Alpha (2016) #1",
                      issueNumber: 1,
                      modified: "2017-04-25T18:32:13-0400",
                      thumbnail: {
                        path: "http://i.annihil.us/u/prod/marvel/i/mg/a/90/56d099e9de8b6",
                        extension: "jpg"
                      },
                      characters: {
                        available: 0,
                        collectionURI: "http://gateway.marvel.com/v1/public/comics/57833/characters",
                        items: [],
                        returned: 0
                      },
                    }
                  ]
      }
    }
  end

  describe '#save' do
    it 'parse and saves comics' do
      data_saver.save(data)

      expect(Comic.count).to eq(3)
    end

    it 'saves correct data' do
      data_saver.save(data)

      expect(Comic.first.comic_id).to eq(22735)
      expect(Comic.first.title).to eq('Generation X')
      expect(Comic.first.year).to eq(1994)
      expect(Comic.first.issue_number).to eq(1)
      expect(Comic.first.thumbnail_url).to eq('http://i.annihil.us/u/prod/marvel/i/mg/3/20/57e031231d84f.jpg')
      expect(Comic.first.characters).to eq('Generation X, Hulk')
    end
  end
end
