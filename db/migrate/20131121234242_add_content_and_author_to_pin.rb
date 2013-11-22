class AddContentAndAuthorToPin < ActiveRecord::Migration
  def change
  	add_column :pins, :content, :text
    add_column :pins, :author, :string
    add_column :pins, :category, :string
  end
end
