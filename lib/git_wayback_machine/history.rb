module GitWaybackMachine

  class History < Array
    class Entry < Struct.new(:sha, :name, :time, :comment); end

    SIZE = 200

    def initialize
      super raw_entries.map { |entry| Entry.new *entry }
    end

  private

    def raw_entries
      `git log --pretty=format:'%h|%an|%cr|%s' --graph -#{SIZE}`.split("\n").map do |entry|
        entry.sub(/\A\s*\*\s*/, "").split("|")
      end
    end

  end

end
