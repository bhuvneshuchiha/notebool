class CreateContents < ActiveRecord::Migration[8.1]
  def change
    create_table :contents do |t|
      t.string :content_type
      t.string :title
      t.text:body
      t.string :url

      t.timestamps
    end
  end
end
