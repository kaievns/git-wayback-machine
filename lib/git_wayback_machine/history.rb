module GitWaybackMachine

  class History < Array
    SIZE = 200

    def initialize
      super raw_entries.map { |entry| Entry.new *entry }
    end

    class Entry < Struct.new(:sha, :name, :time, :comment)
      def to_s
        meta           = "\e[33m#{sha}\e[37m | \e[35m#{name.ljust(17)} \e[36m(#{time})\e[37m - "
        size_so_far    = meta.gsub(/\e\[\d+m/, "").size
        terminal_width = `tput cols`.to_i
        cut_comment    = comment.slice(0, terminal_width - size_so_far - 3)
        cut_comment << "…" if comment.size > cut_comment.size

        "#{meta}#{cut_comment}\e[0m"
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
