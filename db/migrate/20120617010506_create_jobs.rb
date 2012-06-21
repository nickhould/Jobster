class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :business
      t.string :url
      t.datetime :posted_at

      t.timestamps
    end
  end
end
