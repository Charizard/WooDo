module UsersHelper

    def gravatar_for(user, res)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{res[:size]}"
        image_tag(gravatar_url, alt: user.name, class:"gravatar")
    end
end
