module AdminHelper

	def caret_tag(column)
		link_to controller: 'admin', action: 'dashboard', order: column.to_s do
			'<div class="caret-container">
				<span class="caret"></span>
			</div>'.html_safe
		end
	end

	def page_name(page)
			page_name = case page
				when "home" then "Home/Form"
				when "end" then "Form Submission"
				when "land" then "Feedback"
				when "fb_error" then "Errore Feedback"
				else "No-name"
			end
		end


end
