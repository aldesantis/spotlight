# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class ParseConfig < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, :commit, to: :analysis

      def call
        unless File.exist?(analysis.config_path)
          message = 'Spotlight could not find a configuration file.'
          MarkFailure.call! analysis: analysis, message: message
          fail! :no_configuration, message
        end

        context.config = JSON.parse(File.read(analysis.config_path))

        if context.config['swagger_url'].blank?
          message = 'Your configuration file is invalid.'
          MarkFailure.call! analysis: analysis, message: message
          fail! :invalid_configuration, message
        end
      end
    end
  end
end
