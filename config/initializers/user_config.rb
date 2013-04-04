module UserConfig

  APP_TITLE = "FlexibleForm"
  FALLBACK_USERNAME = "Visitor"

  DASHBOARD_LOGIN = {
    :username => "user",
    :password => "password"
  }

  module MailerSettings
    FROM_ADDRESS = "john.doe@gmail.com"

    #default settings for Gmail
    SMTP_SETTINGS = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "gmail.com",
      authentication: "plain",
      user_name: FROM_ADDRESS,
      password: "qwerty",
      enable_starttls_auto: true
    }
  end
  
end