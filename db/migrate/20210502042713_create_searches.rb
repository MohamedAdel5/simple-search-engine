class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :word
      t.string :start_url

      t.timestamps
    end
  end
end
