module ApplicationHelper
  def full_title(title)
    base_title = "Demo Application"
    if title.blank?
      base_title
    else
      "#{base_title} | #{title}"
    end
  end
  
  def gravatar_for(user, size=nil)
    hash = Digest::MD5.hexdigest user.email
    image_tag "http://www.gravatar.com/avatar/#{hash}?s=#{size}", alt: user.name
  end
end
