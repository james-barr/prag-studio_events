class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :user

  How_heard_options = [
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]
  validates :location, presence: true
  validates :how_heard, inclusion: {in: How_heard_options}

end
