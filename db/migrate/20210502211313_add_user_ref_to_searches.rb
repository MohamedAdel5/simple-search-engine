class AddUserRefToSearches < ActiveRecord::Migration[6.1]
  def change
    add_reference :searches, :user, null: false, foreign_key: true
  end
end
