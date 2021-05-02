class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, force: :cascade do |t|
			t.string :name,  null: false
			t.string :username,  null: false, index: {unique: true}
      t.string :password_digest,  null: false

      t.timestamps
    end
  end
end
