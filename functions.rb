require 'nokogiri'

module Diakonos
  module Functions

    def selector_grep
      text = @current_buffer.to_a.join( "\n" )
      doc = case @current_buffer.original_language
        when 'html'
          Nokogiri::HTML( text )
        when 'xml'
          Nokogiri::XML( text )
      end

      if doc
        @rlh_selector ||= []
        selector = get_user_input( 'Selector: ', history: @rlh_selector )
        results = doc.search( selector )
        if results.any?
          results_file = File.join( @diakonos_home, 'selector.xml' )
          File.open( results_file, 'w' ) do |f|
            results.each do |match|
              f.puts match
              f.puts "<!-- ------------------------------------ -->"
            end
          end
          open_file results_file
        else
          set_iline "(no matches)"
        end
      end
    end

  end
end