module Web
  module Helpers
    module Share
      private

      def row_color_by_value(value) # FIXME! ROMAN! THE SAME CODE HAS BEEN WRITTEN FOR FAYE GEM IMPLEMENTATION!
        stylesheet_class_name = ''

        if value > 0.0
          stylesheet_class_name = 'up'
        elsif value < 0.0
          stylesheet_class_name = 'down'
        end

        stylesheet_class_name
      end
    end
  end
end