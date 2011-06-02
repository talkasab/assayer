#
# ActiveSupport patches
#
require 'term/ansicolor'

class Color
  extend Term::ANSIColor
end

module ActiveSupport

  # Format the buffered logger with timestamp/severity info.
  class BufferedLogger
    NUMBER_TO_NAME_MAP  = {0=>'DEBUG', 1=>'INFO', 2=>'WARN', 3=>'ERROR', 4=>'FATAL', 5=>'UNKNOWN'}
    NUMBER_TO_COLOR_MAP = {0=> Color.white, 1=>Color.green, 2=>Color.yellow, 3=>Color.magenta, 4=>Color.red, 5=>Color.white}

    def add(severity, message = nil, progname = nil, &block)
      return if @level > severity
      sevstring = NUMBER_TO_NAME_MAP[severity]
      color     = NUMBER_TO_COLOR_MAP[severity]

      message = (message || (block && block.call) || progname).to_s
      # message = "\\033[0;37m#{Time.now.to_s(:db)}\\033[0m [\\033[#{color}m" + sprintf("%-5s","#{sevstring}") + "\\033[0m] #{message.strip} (pid:#{$$})\\n" unless message[-1] == ?\\n
      timestamp = "#{Color.clear}#{Time.now.to_s(:db)}"
      severity = "#{Color.white}[#{color}" + sprintf("%-5s", sevstring) + "#{Color.white}]"
      pid = "(pid:#{$$})"
      message = "#{timestamp} #{severity} #{message.strip}\n" unless message[-1] == "\n"
      buffer << message
      auto_flush
      message
    end
  end
end

