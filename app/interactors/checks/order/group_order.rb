# frozen_string_literal: true

module Checks
  module Order
    class GroupOrder < Checks::Order::Base
      ERROR = "Group '%<group>s' should come before '%<previous_group>s'"

      def call
        context.errors = []

        groups.inject([]) do |accumulator, group|
          group_name = group['name']

          accumulator.each do |accumulator_entry|
            next unless group_name.casecmp(accumulator_entry) == -1
            context.errors << context.errors << format(
              ERROR,
              group: group_name,
              previous_group: accumulator_entry
            )

            break
          end

          accumulator << group_name
        end
      end

      private

      def groups
        context.swagger['x-stoplight']['version']['groups']['docs']
      end
    end
  end
end
