class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

    has_many :visitor_id,
      primary_key: :id,
      foreign_key: :visitor_id,
      class_name: :User

    has_many :visited_urls,
      through: :visited_url,
      source: :shortened_url
end
