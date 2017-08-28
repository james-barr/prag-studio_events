class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
  
end
