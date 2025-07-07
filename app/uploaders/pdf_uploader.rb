class PdfUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(pdf)
  end

  def content_type_allowlist
    ['application/pdf']
  end

  def size_range
    1..10.megabytes
  end
end