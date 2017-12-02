# frozen_string_literal: true

module Analyses
  class PerformJob < ApplicationJob
    queue_as :default

    def perform(analysis)
      Analyses::Perform.call analysis: analysis
    end
  end
end
