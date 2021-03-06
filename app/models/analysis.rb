# frozen_string_literal: true

class Analysis < ApplicationRecord
  belongs_to :project, inverse_of: :analyses

  enumerize :status, in: %i[queued running completed failed], default: :queued, scope: true

  class << self
    def queued
      with_status :queued
    end

    def queued_ordered
      queued.order(created_at: :asc)
    end
  end

  def base_path
    "#{project.base_path}/#{commit}"
  end

  def config_path
    "#{project.base_path}/#{commit}/spotlight.json"
  end
end
