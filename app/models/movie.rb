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

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  mount_uploader :image, ImageUploader

  def review_average
    (reviews.sum(:rating_out_of_ten)/reviews.size) unless (reviews.size == 0)
  end

  def self.search(query)
    Movie.where("title like ? OR director like ? OR description like ?", "%#{query}%","%#{query}%", "%#{query}%" )
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
