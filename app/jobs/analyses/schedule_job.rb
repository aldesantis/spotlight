# frozen_string_literal: true

module Analyses
  class ScheduleJob < ApplicationJob
    queue_as :default

    def perform
      Analysis.queued.find_each do |analysis|
        PerformJob.perform_later analysis
      end
    end
  end
end
