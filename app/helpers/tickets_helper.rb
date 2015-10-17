module TicketsHelper
  def state_for(comment)
    content_tag(:div, class: 'states') do
      if comment.state
        previous_state = comment.previous_state
        if previous_state && comment.state != previous_state
          "#{previous_state} &rarr; #{comment.state}".html_safe
        else
          render comment.state
        end
      end
    end
  end
end
