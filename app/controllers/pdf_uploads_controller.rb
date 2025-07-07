class PdfUploadsController < ApplicationController
  before_action :set_pdf_upload, only: [:show, :destroy]

  def index
    @pdf_uploads = current_user.pdf_uploads.order(created_at: :desc)
  end

  def show
  end

  def new
    @pdf_upload = current_user.pdf_uploads.build
  end

  def create
    @pdf_upload = current_user.pdf_uploads.build(pdf_upload_params)

    if @pdf_upload.save
      # Process the PDF in the background
      ProcessPdfJob.perform_later(@pdf_upload.id)
      redirect_to @pdf_upload, notice: 'PDF uploaded successfully. Processing...'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @pdf_upload.destroy
    redirect_to pdf_uploads_url, notice: 'PDF upload was successfully deleted.'
  end

  private

  def set_pdf_upload
    @pdf_upload = current_user.pdf_uploads.find(params[:id])
  end

  def pdf_upload_params
    params.require(:pdf_upload).permit(:file)
  end
end