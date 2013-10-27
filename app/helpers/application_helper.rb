module ApplicationHelper
  def avatar_url(user)
    default_url = "https://dl.dropboxusercontent.com/u/11223982/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
  end
  
  def avatar_big_url(user)
    default_url = "https://dl.dropboxusercontent.com/u/11223982/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=80&d=#{CGI.escape(default_url)}"
  end
end
