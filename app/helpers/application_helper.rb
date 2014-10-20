module ApplicationHelper
  def full_title(title)
    base_title = "Demo Application"
    if title.blank?
      base_title
    else
      "#{base_title} | #{title}"
    end
  end
  
  def gravatar_for(user)
    hash = Digest::MD5.hexdigest user.email
    image_tag "http://www.gravatar.com/avatar/#{hash}", alt: user.name
  end
end
