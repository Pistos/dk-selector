module Diakonos

  class Diakonos

    def current_buffer_doc
      text = @current_buffer.to_a.join( "\n" )
      case @current_buffer.original_language
        when 'html'
          Nokogiri::HTML( text )
        when 'xml'
          Nokogiri::XML( text )
      end
    end

  end


end