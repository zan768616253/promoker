# coding: utf-8
class User
  module OmniauthCallbacks
    ["weibo", "google_oauth2", "facebook", "twitter"].each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|
        # assume that we've got a legal authorization from the remote user
        uid = response.uid.to_s
        data = response.info
        extra = response.extra.raw_info
        user = nil

        authorization = Authorization.where(:provider => provider, :uid => uid).first
        if authorization
          # remote user already authorized our website and registered as a user
          # just login the user
          user = authorization.user
        else
          # remote user authorized our website
          # but seems that the authorization is not stored in our website

          # find whether the user did registred with the same email in our website
          user = User.find_by_email(data.email || "#{provider + uid.to_s}@example.com" )
          if user
            # if the user is found, just login the user
            # and bind the authorization to that user
            user.bind_service(response)
          else
            # response has nothing to identify the user
            # could be a brand new user, logging in with 3rd party account
            user = User.new_from_provider_data(provider,uid,data, extra)

            if user.save(:validate => false)
              user.authorizations << Authorization.new(:provider => provider, :uid => uid )
            else
              Rails.logger.warn("3rd-party authentication failed #{user.errors.inspect}")
            end
          end
        end
        return user
      end
    end
    def new_from_provider_data(provider, uid, data, extra) 
      user = User.new
      user.email = data.email || "#{provider + uid.to_s}@example.com"

      user.nickname = data.name

      if provider == "facebook"
        data.image = data.image.gsub('http://','https://')
      end
      if provider == "weibo"
        data.image = data.image + '.jpg'
      end
      user.remote_avatar_url = data.image unless user.avatar?
      user.password = Devise.friendly_token[0,20]
      user.location = data.location
      if provider.in? ['weibo','facebook']
        user.gender = extra.gender
      end
      user.skip_confirmation!
      user
    end
  end
end