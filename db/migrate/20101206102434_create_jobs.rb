class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.date :date
      t.string :job_title
      t.string :location
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
