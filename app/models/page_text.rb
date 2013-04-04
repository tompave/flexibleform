# == Schema Information
#
# Table name: page_texts
#
#  id         :integer          not null, primary key
#  page       :string(255)
#  title      :string(255)
#  heading    :string(255)
#  body       :text
#  body2      :text
#  eula_text  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PageText < ActiveRecord::Base
  attr_accessible :page, :title, :heading, :body, :body2, :eula_text

  		
  # heroku ha smesso di riconoscere quello fornito da ActiveRecord...	
  def PageText.find_by_page(page)
  	PageText.where(page: page).first
  end
end
