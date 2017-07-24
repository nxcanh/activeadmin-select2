module Formtastic
  module Inputs

    class Select2Input < Formtastic::Inputs::StringInput
      def input_html_options
        {
            class: 'select2-input',
            type: 'hidden',
            data: {select2: options[:collection], lock_collection: options[:lock_collection]},
            multiple: options[:multiple],
            name: "#{object_name}[#{association_primary_key}]"
        }.merge(super)
      end
    end

  end
end
