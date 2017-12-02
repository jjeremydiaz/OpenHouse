class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :request, index: true
      t.references :user, index: true
    end
  end
end
