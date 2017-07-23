module Formtastic
  module Inputs

    class Select2MultipleInput < Formtastic::Inputs::StringInput
      def input_html_options
        {
            class: 'select2-input',
            type: 'text',
            data: {select2: options[:collection]},
            multiple: true,
            name: "#{object_name}[#{association_primary_key}]"
        }.merge(super)
      end
    end

  end
end
