require 'uri'

class Movie < ActiveRecord::Base
  validates :title, :place, :description, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: false, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :detail_url, :format => URI::regexp(%w(http https)), presence: true
end
