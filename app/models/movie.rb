require 'uri'

class Movie < ActiveRecord::Base
  validates :title, :description, :image_url, :detail_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :detail_url, :format => URI::regexp(%w(http https)), presence: true
end
