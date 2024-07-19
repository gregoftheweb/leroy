module ApplicationHelper
  def flash_class(key)
    case key.to_sym
    when :notice then "success" # Bootstrap classes for success
    when :alert then "danger" # Bootstrap classes for danger/error
    else key.to_s
    end
  end
end
