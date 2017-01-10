module Formtastic
  module Inputs

    class Select2Input < Formtastic::Inputs::StringInput
      def input_html_options
        {
            class: 'select2-input',
            type: 'hidden',
            data: {select2: options[:collection]}
        }.merge(super)
      end
    end

  end
end
