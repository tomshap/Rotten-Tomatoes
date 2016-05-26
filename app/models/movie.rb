class Movie < ActiveRecord::Base

  scope :under90, -> { where(:duration < 90)}

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  mount_uploader :poster_image_url, AvatarUploader

  def review_average
    (reviews.sum(:rating_out_of_ten)/reviews.size) unless (reviews.size == 0)
  end

end
