module ApplicationHelper
  # Returns the css class for the given flash level.
  def custom_flash_class(level)
    case level
    when :notice then 'success'
    when :alert then 'danger'
    else level.to_s
    end
  end
end
