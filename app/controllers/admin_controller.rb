class AdminController < ApplicationController
	http_basic_authenticate_with name: UserConfig::DASHBOARD_LOGIN[:username], password: UserConfig::DASHBOARD_LOGIN[:password]

	include AdminHelper

	# GET /dashboard - dashboard_path
	def dashboard
		@visits = extract_visits(params[:order])
		@order = params[:order]
		
		@submission_count = Submission.count
	end

	# GET /dashboard/download_export - download_export_path
	def export
		@submissions = Submission.order(:created_at)
		respond_to do |format|
			format.csv { render text: @submissions.to_csv }
			format.xls
		end
	end



	# DELETE /delete/:visit_id - delete_visit_path
	def destroy_visit
		if @visit = Visit.find_by_id(params[:visit_id])
			@visit.destroy
	    flash[:success] = "record eliminato"  
	  else
	  	flash[:error] = "impossibile eliminare record. controllare i logs"
		end
		redirect_to action: 'dashboard', order: params[:order]
	end
	




	# GET /dashboard/edit_texts/:page - text_edit_path(:page)
	def text_edit
		@texts = get_texts(params[:page])
		@page_name_in_heading = page_name(params[:page])
	end

	# PUT /dashboard/update_texts - update_text_path
	def update_texts
		@texts = get_texts(params[:page_text][:page])
		if @texts.update_attributes(params[:page_text])
			flash[:success] = "Testi Modificati"
			redirect_to dashboard_path
		else
			@title = @texts.site_title
			render 'text_edit'
		end
	end
	



	# GET /dashboard/edit_email_template - email_edit_path
	def email_edit
		@template = mail_template
		@title = get_texts("end").title.html_safe
	end

	# PUT /dashboard/update_email_template - update_email_path
	def update_email
		@template = mail_template

		if @template.update_attributes(params[:email_template])
			flash[:success] = "Template email Modificato"
			redirect_to dashboard_path
		else
			@title = texts.site_title
			render 'email_edit'
		end
	end



	
	private

		def extract_visits(filter)
			case filter
			when nil, "date"
				visits = Visit.order("created_at")
			when "os"
				visits = Visit.order("operative_system")
			when "email", "location"
				visits = organize_visits(filter.to_sym)
			when "feedback", "delta"
				visits = organize_visits(filter.to_sym, true)
			end


			return visits
		end



		def organize_visits(filter, fb = false)
			visits_base = Visit.order("created_at")

			bounce_backs = visits_base.reject { |v| v.submission }
			visits_with_submission = visits_base - bounce_backs

			if fb # se sto sortando per il feedback o per il Delta_t
				visits_with_sub_without_feedback = visits_with_submission.reject { |v| v.submission.feedback }
				visits_with_sub_and_feedback = visits_with_submission - visits_with_sub_without_feedback

				fb_property = case filter
					when :feedback then :created_at
					when :delta then :delta
				end

				visits_with_sub_and_feedback.sort! do |a,b|
					a.submission.feedback.send(fb_property) <=> b.submission.feedback.send(fb_property)
				end
				visits = visits_with_sub_and_feedback + visits_with_sub_without_feedback + bounce_backs
			else
				visits_with_submission.sort! do |a,b|
					a.submission[filter] <=> b.submission[filter]
				end
				visits = visits_with_submission + bounce_backs
			end

			return visits
		end


		

		
end
