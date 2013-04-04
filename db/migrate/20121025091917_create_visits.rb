class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
    	# properties
    	t.string :user_agent
    	t.string :operative_system
    	t.string :os_version
    	t.string :ip_address

      t.timestamps
    end
    # indexes
    add_index :visits, :user_agent
    add_index :visits, :operative_system
    add_index :visits, :os_version
    add_index :visits, :ip_address
  end
end
