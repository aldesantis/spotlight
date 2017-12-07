# frozen_string_literal: true

module Checks
  class EndpointTraits < Checks::Order::Base
    EXPECTED_TRAITS = {
      'List' => ['listResource'],
      'Get' => ['getResource'],
      'Create' => ['createResource'],
      'Update' => ['updateResource'],
      'Delete' => ['deleteResource']
    }.freeze

    MESSAGE = "Endpoint '%<endpoint>s' should have trait '%<trait>s'"

    def call
      context.errors = []

      swagger['paths'].each_value do |path|
        path.except('parameters').each_value do |endpoint|
          endpoint_type = endpoint['summary'].split(' ').first
          next unless EXPECTED_TRAITS.key?(endpoint_type)

          EXPECTED_TRAITS[endpoint_type].each do |trait|
            next if trait_in_endpoint?(endpoint, trait)
            context.errors << format(MESSAGE, endpoint: endpoint['summary'], trait: trait)
          end
        end
      end
    end

    private

    def trait_in_endpoint?(endpoint, trait)
      trait_in_parameters = (endpoint['parameters'] || []).any? do |parameter|
        parameter['$ref'].to_s.start_with?("#/parameters/trait:#{trait}:")
      end

      trait_in_responses = (endpoint['responses'] || {}).values.any? do |response|
        response['$ref'].to_s.start_with?("#/responses/trait:#{trait}:")
      end

      trait_in_parameters || trait_in_responses
    end
  end
end
