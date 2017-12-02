# frozen_string_literal: true

module Webhooks
  class Process < ApplicationOrganizer
    class EnqueueAnalysis < ApplicationInteractor
      accept :project, :commit
      required :project, :commit

      def call
        analysis = Analysis.create!(
          project: project,
          commit: commit
        )

        Analyses::PerformJob.perform_later analysis
      end
    end
  end
end
