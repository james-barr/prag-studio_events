class Event < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :likers, -> { order(created_at: :desc)}, through: :likes, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_attached_file :image

  validates :name, :location, presence: true

  validates :description, length: {minimum: 25, maximum: 150}

  validates :price, numericality: {greater_than_or_equal_to: 0}

  validates :capacity, numericality: {only_integer: true, greater_than: 0}

  validates_attachment :image,
    :content_type => { :content_type => ['image/jpeg', 'image/png'] },
    :size => { :less_than => 1.megabyte }

  scope :past, -> {where("starts_at < ?", Time.now).order("starts_at")}
  scope :upcoming, -> {where("starts_at >= ?", Time.now).order("starts_at")}
  scope :free, -> { upcoming.where(price: 0).order(:name)}
  scope :recent, ->(max=3) { past.limit(max)}
  scope :past_n_days, -> (n=10) { where('created_at >= ?', n.days.ago) }
  scope :costs_less_than, -> (dollars) { where "price < ?", dollars }
  scope :costs_more_than, -> (dollars) { where 'price > ?', dollars}

  def free?
    price.nil? || price.zero?
  end

  def spots_left
    capacity - registrations.size
  end

  def sold_out?
    spots_left + 1 == 0
  end




end
