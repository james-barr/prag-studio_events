class Event < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :image

  validates :name, :location, presence: true

  validates :description, length: {minimum: 25, maximum: 150}

  validates :price, numericality: {greater_than_or_equal_to: 0}

  validates :capacity, numericality: {only_integer: true, greater_than: 0}

  validates_attachment :image,
    :content_type => { :content_type => ['image/jpeg', 'image/png'] },
    :size => { :less_than => 1.megabyte }

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
