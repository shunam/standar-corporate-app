Technoweenie::AttachmentFu::Backends::DbFileBackend.module_eval do
  def image_data(size= nil)
    if size and the_thumb = thumbnails.detect{ |t| t.thumbnail.to_s == size.to_s}
      the_thumb.current_data
    else
      current_data
    end
  end
end