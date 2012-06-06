class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :number
      t.text :body
      t.text :status

      t.timestamps
    end
  end
end
