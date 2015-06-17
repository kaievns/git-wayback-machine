module GitWaybackMachine

  class History < Array
    SIZE = 200

    def initialize
      super raw_entries.map { |entry| Entry.new *entry }
    end

    class Entry < Struct.new(:sha, :name, :time, :comment)
      def to_s
        "\e[33m#{sha}\e[37m | \e[35m#{name} \e[36m(#{time})\e[37m - #{comment}\e[0m"
      end
    end

  private

    def raw_entries
      `git log --pretty=format:'%h|%an|%cr|%s'  -#{SIZE}`.split("\n").map do |entry|
        entry.sub(/\A\s*\*\s*/, "").split("|")
      end
    end

  end

end
