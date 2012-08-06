module ApplicationHelper
  def format_date(time)
    time.strftime("%b %d, %Y")
  end

  def render_flash
    ret = ""
    unless flash[:error].blank?
      ret << "<div id='flash_error'>#{flash[:error]}</div>"
    end
    unless flash[:notice].blank?
      ret << "<div id='flash_notice'>#{flash[:notice]}</div>"
    end
    raw(ret)
  end

  def render_errors(obj)
    ret = ""
    if obj.errors.any?
      ret << "<div id='errors' style='color:red'>"
      ret << "<strong>#{obj.class.name} was not saved because of the following errors</strong>"
      ret << "<ul>"
      obj.errors.full_messages.each do |message|%>
        ret << "<li>#{message}</li>"
      end
      ret << "</ul>"
      ret << "</div>"
     end
     return raw(ret)
  end

end
