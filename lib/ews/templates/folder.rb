module Viewpoint::EWS
  module Template
  # Template for creating Folder
  # @see http://msdn.microsoft.com/en-us/library/office/aa581334(v=exchg.150).aspx
  class Folder < OpenStruct

      # Available parameters with the required ordering
      PARAMETERS = %w{folder_id parent_folder_id folder_class display_name total_count child_folder_count extended_property
        managed_folder_information unread_count permission_set effective_rights
      }.map(&:to_sym).freeze

      # Returns a new Folder template
      def initialize(opts = {})
        super opts.dup
      end

      # EWS Item hash
      #
      # Puts all known parameters in the required ordering and structure
      # @return [Hash]
      def to_ews_item
        item_parameters = {}
        PARAMETERS.each do |key|
          if !(value = self.send(key)).nil?

            # Convert non duplicable values to String
            case value
              when NilClass, FalseClass, TrueClass, Symbol, Numeric
                value = value.to_s
            end

            item_parameters[key] = value
          end
        end

        item_parameters
      end

    end
  end
end
