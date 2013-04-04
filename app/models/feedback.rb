# == Schema Information
#
# Table name: feedbacks
#
#  id            :integer          not null, primary key
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Feedback < ActiveRecord::Base
  # attr_accessible :title, :body

  # associations
  belongs_to :submission


  # in seconds, float
  def delta
  	t_0 = self.submission.created_at
  	t_1 = self.created_at
  	delta = t_1 - t_0
  end


  def humanized_delta
  	seconds = self.delta.to_int
  	minutes = hours = days = 0

  	if seconds >= 60
	  	minutes = seconds/60
	  	seconds = seconds%60

	  	if minutes >= 60
	  		hours = minutes/60
	  		minutes = minutes%60

	  		if hours >= 24
	  			days = hours/24
	  			hours = hours%24
	  		end
	  	end
	  end

  	elapsed = "#{days}g-#{hours}h-#{minutes}m-#{seconds}s"
  end

end
