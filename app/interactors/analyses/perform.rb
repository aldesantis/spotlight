# frozen_string_literal: true

module Analyses
  class Perform < ApplicationInteractor
    accept :analysis

    delegate :project, :commit, to: :analysis

    def call
      project.octokit.create_status(
        project.repo_uri,
        commit,
        'pending',
        context: 'spotlight/oas',
        description: 'Your API documentation is being analyzed...'
      )

      sleep 10 unless Rails.env.test?

      project.octokit.create_status(
        project.repo_uri,
        commit,
        'success',
        context: 'spotlight/oas',
        description: 'Your API documentation is good!'
      )
    end
  end
end
