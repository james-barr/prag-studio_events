module RegistrationsHelper

  def time_since(regis)
    time_ago_in_words regis.created_at
  end

  def register_link(event)
    if event.sold_out?
      content_tag(:p, "This event is full!")
    else
      link_to "Register for event", new_event_registration_path(event)
      render "register_event"
    end
  end
end
