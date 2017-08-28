module UsersHelper

  def created_at_present(user)
    user.created_at.strftime("%B %d, %Y")
  end

  def profile_image_for(user, options={})
    size = options[:size] || 80
    url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(url, alt: user.name)
  end
end
