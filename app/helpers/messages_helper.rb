module MessagesHelper

  # TODO: Move to form object or presenter?
  def size_check_box(size_id, active)
    check_box_tag "sizes[#{size_id}]", true, active
  end

  def message_icon(size, active)
    if active
      fa_icon "#{size.icon} 3x", title: size.display, id: size.id
    else
      fa_icon "#{size.icon} 3x", title: size.display, id: size.id, class: 'disabled'
    end
  end
end
