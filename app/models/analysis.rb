# frozen_string_literal: true

class Analysis < ApplicationRecord
  belongs_to :project, inverse_of: :analyses

  enumerize :status, in: %i[queued running completed failed], default: :queued, scope: true

  class << self
    def queued
      with_status :queued
    end
  end
end
