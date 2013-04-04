class FeedbacksController < ApplicationController

	# GET /fb/:token - feedback_path(:token)
	def land
		if params[:token] && @submission = Submission.find_by_token(params[:token])
			@feedback = @submission.feedback || @submission.create_feedback
			
			texts = get_texts("land")
			@title = texts.title.html_safe
			@heading = texts.heading.html_safe
			@text = texts.body.html_safe
		else
			texts = get_texts("fb_error")
			@title = texts.title.html_safe
			@heading = texts.heading.html_safe
			@text = texts.body.html_safe
			render 'fb_error'
		end
	end
	
end
