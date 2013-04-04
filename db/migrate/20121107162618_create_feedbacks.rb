class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|

    	t.integer :submission_id

      t.timestamps
    end

    #indexes
    add_index :feedbacks, :submission_id, unique: true
  end
end
