class Document < ApplicationRecord
  acts_as_paranoid

  belongs_to :documentable, polymorphic: true

  mount_uploader :document, DocumentUploader

  enum doc_type: { others: 0, aadhar: 1, voter_id: 2, passport: 3, driving_license: 1 }

end

