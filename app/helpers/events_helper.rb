module EventsHelper

    def format_price(event)
      event.free? ? content_tag(:strong, "Free") : number_to_currency(event.price)
    end

    def image_for(event)
      if event.image.exists?
        image_tag event.image.url, width: "80", height: "50"
      else
        image_tag "placeholder.png", alt: "Placeholder", width: "80", height: "50"
      end
    end

end
