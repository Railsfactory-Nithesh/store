
Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, '195991807214508', 'de726ca087972e54358a7d46b69434f0',{:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
 
  # If you want to also configure for additional login services, they would be configured here.
end