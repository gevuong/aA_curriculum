class Visit < ApplicationRecord
  validates :visitor_id, presence: true
  validates :visited_url, presence: true

  belongs_to :visited_url,  # belongs_to because has_one should be avoided
    primary_key: :id,
    foreign_key: :visited_url,
    class_name: :ShortenedUrl

  has_many :visitor_id,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: :User

  def self.record_visit!(id, shortened_url)
    Visit.create(
    visitor_id: id,
    visited_url: shortened_url.id
    )

  end
end
