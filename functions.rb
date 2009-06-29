require 'nokogiri'

module Diakonos
  module Functions

    def selector_grep
      doc = current_buffer_doc
      return  if doc.nil?

      @rlh_selector ||= []
      get_user_input( 'Selector: ', history: @rlh_selector ) do |input|
        next  if input.empty?

        results_file = File.join( @diakonos_home, 'selector.xml' )
        File.open( results_file, 'w' ) do |f|
          results = doc.search( input )
          if results.empty?
            f.puts "(nothing matches '#{input}')"
          else
            results.each do |match|
              f.puts match
              f.puts
            end
          end
        end
        open_file results_file
      end
    end

    def selector_highlight

    end

  end
end