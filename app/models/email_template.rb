# == Schema Information
#
# Table name: email_templates
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  style      :text
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EmailTemplate < ActiveRecord::Base
  attr_accessible :subject, :style, :body
end
