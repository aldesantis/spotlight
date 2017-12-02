# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class MarkRunning < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, :commit, to: :analysis

      def call
        analysis.update! status: :running

        project.octokit.create_status(
          project.repo_uri,
          commit,
          'pending',
          context: ENV.fetch('GITHUB_CONTEXT'),
          description: 'Your API documentation is being analyzed...'
        )
      end
    end
  end
end
