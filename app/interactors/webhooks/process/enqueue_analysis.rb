# frozen_string_literal: true

module Webhooks
  class Process < ApplicationOrganizer
    class EnqueueAnalysis < ApplicationInteractor
      accept :project, :commit
      required :project, :commit

      def call
        Analysis.create!(
          project: project,
          commit: commit
        )
      end
    end
  end
end
