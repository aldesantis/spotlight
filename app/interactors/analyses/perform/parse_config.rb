# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class ParseConfig < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, :commit, to: :analysis

      def call
        unless File.exist?(analysis.config_path)
          analysis.update! status: :failed

          error_message = 'Spotlight could not find a configuration file.'

          project.octokit.create_status(
            project.repo_uri,
            commit,
            'error',
            context: ENV.fetch('GITHUB_CONTEXT'),
            description: error_message
          )

          fail! :no_configuration, error_message
        end

        context.config = JSON.parse(File.read(analysis.config_path))
      end
    end
  end
end
