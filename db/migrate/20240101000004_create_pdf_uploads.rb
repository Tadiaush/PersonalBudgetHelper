class CreatePdfUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :pdf_uploads do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file, null: false
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end