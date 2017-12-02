# frozen_string_literal: true

module Webhooks
  class Process < ApplicationOrganizer
    class Parse < ApplicationInteractor
      accept :payload
      required :payload

      def call
        repo_uri = payload['repository']['full_name']

        context.project = Project.find_by(
          repo_provider: :github,
          repo_uri: repo_uri
        )

        fail! :no_project, "Could not find project '#{repo_uri}'" unless context.project

        context.commit = payload['after']
      end
    end
  end
end
