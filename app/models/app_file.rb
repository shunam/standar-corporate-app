class AppFile < ActiveRecord::Base
  has_attachment  :storage => :db_file,
                  :max_size => 4.megabytes

  validates_as_attachment

  # ATTRIBUTES =========================================================================================

  attr_accessible :uploaded_data, :content_type, :filename, :temp_path
end
