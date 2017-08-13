class Event < ApplicationRecord
  has_many :registrations, dependent: :destroy

  validates :name, :location, presence: true

  validates :description, length: {minimum: 25, maximum: 150}

  validates :price, numericality: {greater_than_or_equal_to: 0}

  validates :capacity, numericality: {only_integer: true, greater_than: 0}

  validates :image_file_name, allow_blank: true, format: {
    with: /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }

  def free?
    price.nil? || price.zero?
  end

  def self.upcoming
    where("starts_at >= ?", Time.now).order("starts_at")
  end

  def spots_left
    capacity - registrations.size
  end

  def sold_out?
    spots_left + 1 == 0
  end




end
