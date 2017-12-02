# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class Checkout < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, to: :analysis

      def call
        FileUtils.mkpath project.base_path
        Git.clone project.full_repo_url, analysis.commit, path: project.base_path
      end
    end
  end
end
