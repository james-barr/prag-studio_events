class Registration < ApplicationRecord
  belongs_to :event

  How_heard_options = [
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]

  validates :name, :location, presence: true

  validates :email, format: { with: /(\S+)@(\S+)/}

  validates :how_heard, inclusion: {in: How_heard_options}


end
