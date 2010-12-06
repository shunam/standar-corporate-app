class CreateAppFiles < ActiveRecord::Migration
  def self.up
    create_table :app_files do |t|
      t.string    :filename
      t.string    :type
      t.string    :content_type
      t.integer   :size
      t.integer   :width
      t.integer   :height
      t.integer   :candidate_profile_id
      t.string    :thumbnail
      t.integer   :db_file_id

      t.timestamps
    end
  end

  def self.down
    drop_table :app_files
  end
end
