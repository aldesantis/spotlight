# frozen_string_literal: true

module Checks
  module Order
    class Base < Checks::Base
      protected

      def endpoints_map
        return @endpoints_map if @endpoints_map

        @endpoints_map = {}

        swagger['paths'].each_value do |path|
          path.except('parameters').each_value do |endpoint|
            @endpoints_map[endpoint['endpointId']] = endpoint['summary']
          end
        end

        @endpoints_map
      end

      def endpoints_in_group(group)
        endpoint_names = group['items'].select do |item|
          item['type'] == 'endpoints'
        end

        endpoint_names = endpoint_names.map do |item|
          endpoints_map[item['_id']]
        end

        endpoint_names.compact
      end
    end
  end
end
