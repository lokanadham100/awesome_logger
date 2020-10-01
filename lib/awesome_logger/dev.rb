require "logger"
require "dev_formatter"

class Logger
	def initialize(*)
		super
		set_formatter
		@caller_position = 0
		@old_position = nil
		@position_set = false
	end

	def set_formatter
		formatter=DevFormatter.new() if formatter.nil?
	end

	  %w{debug info warn error fatal}.each do |method|
	    eval(<<-eomethod)
	      def #{method}(msg)
	        super(position) {msg}
	      end
	    eomethod
	  end

	  private
	  def position
	    pos = caller.at(@caller_position).sub(%r{.*/},'').sub(%r{:in\s.*},'')
	    return pos if @position_set
	    if @old_position == pos
	    	@caller_position = @caller_position + 1 
	    else
	    	@position_set = true	    	
	    end
	    @old_position = pos if @old_position == nil
	    return pos
	  end	
end