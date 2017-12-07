# frozen_string_literal: true

module Checks
  module Order
    class CustomEndpointOrder < Checks::Order::Base
      CRUD_ENTRIES = %w[List Get Create Update Delete].freeze
      ERROR = "Endpoint '%<endpoint>s' should come before '%<previous_endpoint>s'"

      def call
        context.errors = []

        swagger['x-stoplight']['version']['groups']['docs'].each do |group|
          endpoint_names = endpoints_in_group(group).reject do |item|
            item.split(' ').first.in?(CRUD_ENTRIES)
          end

          endpoint_names.inject([]) do |accumulator, endpoint_name|
            accumulator.each do |accumulator_entry|
              next unless endpoint_name.casecmp(accumulator_entry) == -1

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
