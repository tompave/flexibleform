module ApplicationHelper

	def get_texts(page)
		@texts ||= PageText.find_by_page(page)
	end

	def mail_template
    template ||= EmailTemplate.first
  end

end
