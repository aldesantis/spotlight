# frozen_string_literal: true

module Checks
  module Order
    class DefaultEndpointOrder < Checks::Order::Base
      EXPECTED_ORDER = %w[List Get Create Update Delete].freeze
      ERROR = "Endpoint '%<endpoint>s' should come before '%<previous_endpoint>s'"

      def call
        context.errors = []

        swagger['x-stoplight']['version']['groups']['docs'].each do |group|
          endpoint_names = endpoints_in_group(group).select do |item|
            item.split(' ').first.in?(EXPECTED_ORDER)
          end

          endpoint_names.inject([]) do |accumulator, endpoint_name|
            accumulator.each do |accumulator_entry|
              endpoint_position = EXPECTED_ORDER.index(endpoint_name.split(' ').first)
              accumulator_entry_position = EXPECTED_ORDER.index(accumulator_entry.split(' ').first)

              next unless (endpoint_position <=> accumulator_entry_position) == -1
              context.errors << format(
                ERROR,
                endpoint: endpoint_name,
                previous_endpoint: accumulator_entry
              )

              break
            end

            accumulator << endpoint_name
          end
        end
      end
    end
  end
end
