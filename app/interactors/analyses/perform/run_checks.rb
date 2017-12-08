# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class RunChecks < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, :commit, to: :analysis

      CHECKS = [
        Checks::EndpointTraits,
        Checks::Naming::DefinitionTitle,
        Checks::Naming::GroupTitle,
        Checks::Naming::EndpointTitle,
        Checks::Order::DefinitionOrder,
        Checks::Order::GroupOrder,
        Checks::Order::DefaultEndpointOrder,
        Checks::Order::CustomEndpointOrder,
        Checks::Visibility::DefinitionVisibility,
        Checks::Visibility::EndpointVisibility
      ].freeze

      def call
        context.errors = []

        CHECKS.each do |check|
          result = check.call! swagger: context.swagger
          context.errors += result.errors
        end
      end
    end
  end
end
