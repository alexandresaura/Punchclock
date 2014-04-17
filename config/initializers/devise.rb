require 'openid/store/filesystem'

Devise.setup do |config|
  config.mailer_sender = 'do-not-reply@cm42.io'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.invite_for = 3.days
  config.allow_unconfirmed_access_for = 2.days
  config.confirm_within = 3.days
  config.reconfirmable = false
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.scoped_views = true
  config.sign_out_via = :delete
  config.omniauth :google_apps,
                  store: OpenID::Store::Filesystem.new('/tmp'),
                  domain: Settings.google_apps.domain
end
