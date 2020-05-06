# frozen_string_literal: true

module ApplicationHelper

  def formatted_date(date)
    return date.strftime("%m/%d/%y %I:%M %p %Z")
  end

end
