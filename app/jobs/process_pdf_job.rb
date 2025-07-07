class ProcessPdfJob < ApplicationJob
  queue_as :default

  def perform(pdf_upload_id)
    pdf_upload = PdfUpload.find(pdf_upload_id)
    pdf_upload.process_pdf
  end
end