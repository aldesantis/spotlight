# frozen_string_literal: true

module Checks
  module Visibility
    class EndpointVisibility < Checks::Visibility::Base
      ERROR = "Endpoint '%<endpoint>s' should be public"

      def call
        context.errors = []

        swagger['paths'].each_value do |path|
          path.except('parameters').each_value do |endpoint|
            next if endpoint['x-stoplight']['public']
            context.errors << format(ERROR, endpoint: endpoint['summary'])
          end
        end
      end
    end
  end
end
