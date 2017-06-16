include 'singleton'

class VisitsDBConnection < Postgesql::Database


end




class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visitor_id,  # belongs_to because has_one should be avoided
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: :ShortenedUrl

  has_many :visitors,
    Proc.new { distinct }, #<<< Scope block to removve dups
    through: :visits,
    source: :visitor

  def self.random_code
    str = SecureRandom::urlsafe_base64
    while ShortenedUrl.exists?(str)
      str = SecureRandom::urlsafe_base64
    end
    str
  end


  def self.create_from_long_url(long_url, id)
    ShortenedUrl.create(
     long_url: long_url,
     user_id: id,
     short_url: self.random_code
     )
  end

  def num_clicks
    visits.count

  end

  def num_uniques
  end

  def num_recent_uniques
  end
end
