module Filispin
  module Format

    def invert(str)
      "\e[7m#{str}\e[27m"
    end

    def bold(str)
      "\e[1m#{str}\e[0m"
    end

    def underline(str)
      "\e[4m#{str}\e[24m"
    end

    def red(str)
      "\e[31m#{str}\e[39m"
    end

    def yellow(str)
      "\e[33m#{str}\e[39m"
    end

    def green(str)
      "\e[32m#{str}\e[39m"
    end
  end
end