module Piano
  module Helpers
    # Helpers for HTML
    module HTML
      # Formats a javascript <script></script> tag with the input
      # @return [String] the script tag pointing to the argument
      def script src, extra = ''
        if extra.empty?
          "<script type='text/javascript' src='#{src}'></script>"
        else
          "<script type='text/javascript' src='#{src}' #{extra}></script>"
        end          
      end

      # Formats a css stylesheet <link /> tag with the input
      # @return [String] the stylesheet link tag pointing to the argument
      def style href, extra = ''
        if extra.empty?
          "<link rel='stylesheet' type='text/css' href='#{href}' />"
        else
          "<link rel='stylesheet' type='text/css' href='#{href}' #{extra} />"
        end
      end
    end
  end
end