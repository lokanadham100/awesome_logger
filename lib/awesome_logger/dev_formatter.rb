class DevFormatter < ::Logger::Formatter
	      # This method is invoked when a log event occurs
	      def call(severity, timestamp, progname, msg)
	        "#{severity} #{timestamp} #{progname} #{String === msg ? msg : msg.inspect}\n"
	      end
    end