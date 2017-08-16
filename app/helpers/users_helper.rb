module UsersHelper

  def created_at_present(object)
    object.created_at.strftime("%B %d, %Y")
  end
end
