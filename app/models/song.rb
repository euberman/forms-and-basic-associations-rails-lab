class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(artist_name)
    artist = Artist.find_or_create_by(name: artist_name)
    if artist
      self.artist = artist
    else 
      raise "#artist_name=(artist_name) artist record not found"
    end
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(contents)
    contents.each do |content|
      if content.strip != ""
         self.notes.build(content: content)
      end
    end
  end

  def note_contents
    self.notes.map(&:content)
  end
end
