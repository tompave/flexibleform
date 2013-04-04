class HomeController < ApplicationController
	include Rack::Recaptcha::Helpers

	# GET / - home_path
	def home
		texts = get_texts("home")
		@title = texts.title.html_safe
		@heading = texts.heading.html_safe
		@text = texts.body.html_safe
		@text_2 = texts.body2.html_safe
		@eula_text = texts.eula_text.html_safe

		@visit = Visit.new.fill_properties(request)
		@visit.save
		@submission = @visit.build_submission
	
		respond_to do |format|
			format.html
			# format.xml { render :xml => @foobar } #.to_xml }
			# format.json { render :json => @foobar } #.to_json }
		end
	end




	# POST /save - helper_path
	def create_submission
		@submission = Submission.new(params[:submission])

		recaptcha_ok = true
		if !recaptcha_valid?
			recaptcha_ok = false
			@submission.errors.add(:recaptcha, ": input errato nel controllo reCAPTCHA.")
		end

		if !params[:eula]
			@submission.errors.add(:eula, ": devi accettare i termini e condizioni.")
		end

		#if verify_recaptcha(model: @submission, message: "Input errato nel controllo reCAPTCHA.") && @submission.save
		if recaptcha_ok && params[:eula] && @submission.save
			flash[:success] = 'Iscrizione completata.'
			ConfirmationMailer.confirmation_email(@submission).deliver
			redirect_to end_path
		else
			flash.now[:error] = 'Iscrizione fallita.'
			@visit = @submission.visit
			texts = get_texts("home")
			@title = texts.title.html_safe
			@heading = texts.heading.html_safe
			@text = texts.body.html_safe
			@eula_text = texts.eula_text.html_safe
			render 'home'
		end
	
	# rescue Recaptcha::RecaptchaError => e
	# 	puts e.message.colorize(:red)
	# 	@the_error = e
	# 	render :recaptcha_error
	end


	# def recaptcha_error
	# end


	# GET /end - end_path
	def end
		texts = get_texts("end")
		@title = texts.title.html_safe
		@heading = texts.heading.html_safe
		@text = texts.body.html_safe
	
		respond_to do |format|
			format.html
			# format.xml { render :xml => @foobar } #.to_xml }
			# format.json { render :json => @foobar } #.to_json }
		end
	end
	
	
	
	
end
