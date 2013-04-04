class ConfirmationMailer < ActionMailer::Base
  default from: UserConfig::MailerSettings::FROM_ADDRESS


  # views:
  ## app/views/confirmation_mailer/confirmation_email.html.erb
  ## app/views/confirmation_mailer/confirmation_email.txt.erb
  def confirmation_email(submission)
    @name = submission.name
    @email_address = submission.email

    @style = template.style.html_safe
    @body = template.body
    replace_tags!(@body)

    the_mail = mail( :to => submission.email,
    			           :subject => template.subject )
  end




  private
    def template
      template ||= EmailTemplate.first
    end

    def replace_tags!(string)

      string.gsub!(/\[+[(name)(email)]+\]/) do |match|
        case match
        when "[name]" then @name
        when "[email]" then @email_address
        end
      end
    end
end
