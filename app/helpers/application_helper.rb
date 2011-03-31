module ApplicationHelper
  def gravatar_for(email, size="16")
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=#{size.to_i}"
  end
end
