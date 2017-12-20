require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "movie attributes must not be empty" do
    movie = Movie.new
    assert movie.invalid?
    assert movie.errors[:title].any?
    assert movie.errors[:place].any?
    assert movie.errors[:description].any?
    assert movie.errors[:detail_url].any?
    assert movie.errors[:image_url].any?
  end
 
  def new_movie(image_url)
    Movie.new(title:       "My Movie Title",
                place:       "China",
                description: "yyy",
                detail_url:  "https://movie.douban.com",
                image_url:   image_url)
  end
 
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |name|
      assert new_movie(name).valid?, "#{name} shouldn't be invalid"
    end
 
    bad.each do |name|
      assert new_movie(name).invalid?, "#{name} shouldn't be valid"
    end
  end
 
  test "movie is not valid without a unique title" do
    movie = Movie.new(title:       movies(:ruby).title,
                          place:       "China",
                          description: "yyy", 
                          detail_url:  "https://movie.douban.com",
                          image_url:   "fred.gif")
 
    assert movie.invalid?
    assert_equal ["has already been taken"], movie.errors[:title]
  end
 
  test "movie is not valid without a unique title - i18n" do
    movie = Movie.new(title:       movies(:ruby).title,
                          place:       "China",
                          description: "yyy", 
                          detail_url:  "https://movie.douban.com",
                          image_url:   "fred.gif")
 
    assert movie.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 movie.errors[:title]
  end
end
