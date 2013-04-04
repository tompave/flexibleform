# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FlexibleForm::Application.initialize!


# mail settings
FlexibleForm::Application.configure do
	config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = UserConfig::MailerSettings::SMTP_SETTINGS
end