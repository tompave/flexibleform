# rack-recaptcha configuration
# https://github.com/achiu/rack-recaptcha

PUBL_KEY = 'dummy_token'
PRIV_KEY = 'dummy_token'

FlexibleForm::Application.config.gem 'rack-recaptcha', :lib => 'rack/recaptcha'
FlexibleForm::Application.config.middleware.use Rack::Recaptcha, :public_key => PUBL_KEY, :private_key => PRIV_KEY
