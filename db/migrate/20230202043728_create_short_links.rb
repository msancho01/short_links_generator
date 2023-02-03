class CreateShortLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :short_links do |t|
      t.string :token, null: false, index: { unique: true }
      t.string :long_url, null: false
      t.string :title
      t.integer :clicks_count

      t.timestamps
    end
  end
end
