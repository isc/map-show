class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :state
      t.jsonb :discovered_countries

      t.timestamps
    end
  end
end
