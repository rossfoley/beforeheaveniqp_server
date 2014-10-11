class Api::BaseController < BaseController
  acts_as_token_authentication_handler_for User, except: :cors_preflight_check, fallback_to_devise: false
end
