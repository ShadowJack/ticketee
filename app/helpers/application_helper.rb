module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title, (parts << 'Ticketee').join(" - ")
    end
  end
end
