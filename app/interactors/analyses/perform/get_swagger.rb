# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class GetSwagger < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, :commit, to: :analysis

      def call
        context.swagger = JSON.parse(Faraday.get(context.config['swagger_url']).body)
      rescue Faraday::Error
        MarkFailure.call!(
          analysis: analysis,
          message: 'Spotlight could not retrieve your Swagger schema.'
        )
      rescue JSON::ParserError
        MarkFailure.call!(
          analysis: analysis,
          message: 'Spotlight could not parse your Swagger schema.'
        )
      end
    end
  end
end
