#encoding: UTF-8

class DocumentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog

  def initialize(*)
    super

    # self.fog_directory = "prod-flo-invoice"
    # self.fog_directory = "dev-flo-invoice" if Rails.env.development?
    # self.fog_public = true
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def size_range
    1..10.megabytes
  end

  process :resize_to_fit_by_percentage => 0.7

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(pdf jpg jpeg png tiff)
  end

  def resize_to_fit_by_percentage(percentage)

    return if file.content_type == "application/pdf" || file.content_type == "application/csv" || file.content_type ==  "text/csv" || file.content_type == "invalid/invalid"

  end

  def resize_to_fit_by_percentage(percentage)

    return if file.content_type == "application/pdf"
    return if file.content_type == "invalid/invalid"
    return if file.content_type == "application/vnd.ms-excel"
    return if file.content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

    if file.size > 3000000
      width, height = ::MiniMagick::Image.open(file.file)[:dimensions]
      width = width * percentage
      height = height * percentage
      resize_to_fit width, height
    else
      width, height = ::MiniMagick::Image.open(file.file)[:dimensions]
      resize_to_fit width, height
    end

  end

end
