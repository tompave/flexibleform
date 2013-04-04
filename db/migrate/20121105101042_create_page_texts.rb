class CreatePageTexts < ActiveRecord::Migration
  def change
    create_table :page_texts do |t|
      t.string :page
    	t.string :title

    	t.string :heading
    	t.text :body
      t.text :body2

      t.text :eula_text

      t.timestamps
    end

    add_index :page_texts, :page, unique: true
  end
end
