class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
    	# properties
    	t.string :email
    	t.string :name

        t.string :location, default: "village"
        t.string :token

    	# associations
    	t.integer :visit_id

      t.timestamps
    end
    # indexes
    add_index :submissions, :email, unique: true
    add_index :submissions, :name
    add_index :submissions, :location
    add_index :submissions, :token, unique: true
  end
end
