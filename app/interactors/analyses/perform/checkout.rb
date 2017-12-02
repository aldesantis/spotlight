# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class Checkout < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, to: :analysis

      def call
        FileUtils.mkpath project.base_path
        FileUtils.remove_dir(analysis.base_path) if File.directory?(analysis.base_path)

        git = Git.clone repository_url, analysis.commit, path: project.base_path
        git.checkout analysis.commit
      end

      private

      def repository_url
        # rubocop:disable Metrics/LineLength
        case project.repo_provider.to_sym
        when :github
          "https://#{project.octokit.login}:#{project.oauth_access_token}@github.com/#{project.repo_uri}.git"
        else
          fail "Cannot construct repo URI for provider #{project.repo_provider}"
        end
        # rubocop:enable Metrics/LineLength
      end
    end
  end
end
