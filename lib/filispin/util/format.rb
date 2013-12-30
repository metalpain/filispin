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
  end
end