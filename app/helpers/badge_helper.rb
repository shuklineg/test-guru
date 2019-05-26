module BadgeHelper
  def badge_tag(badge, options = {})
    content_tag :span, options do
      tag = ''
      tag << image_tag(badge.image)
      tag << content_tag(:span, "x#{current_user.badges.where(id: badge.id).count}")
      tag << content_tag(:p, badge.caption, style: 'widht: 100%')
      tag.html_safe
    end
  end
end
