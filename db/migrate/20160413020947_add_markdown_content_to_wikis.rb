class AddMarkdownContentToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :markdown_content, :text
  end
end
