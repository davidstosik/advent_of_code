# frozen_string_literal: true

require "net/http"
require "uri"

module AdventOfCode
  class Input
    def initialize(year, day)
      @year = year
      @day = day
    end

    def read
      if File.exist?(local_path)
        File.read(local_path)
      else
        puts "Input for #{year}, day #{day} not found locally."
        download
      end
    end

    private

    attr_reader :year, :day

    def local_path
      File.join(year_dir, "day#{day}.txt")
    end

    def download
      raise "Unable to download input without session cookie." unless session_cookie

      ensure_year_dir
      puts "Downloading input for #{year}, day #{day}..."
      uri = URI("https://adventofcode.com/#{year}/day/#{day}/input")
      req = Net::HTTP::Get.new(uri)
      req["Cookie"] = "session=#{session_cookie}"
      req["User-Agent"] = "github.com/davidstosik/advent_of_code" # FIXME make configurable?
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
      # FIXME handle errors (eg 404)
      File.write(local_path, res.body)
      res.body
    end

    def ensure_year_dir
      Dir.mkdir(year_dir) unless Dir.exist?(year_dir)
    end

    def year_dir
      @_year_dir ||= File.join(cache_dir, year.to_s)
    end

    def session_cookie
      @_session_cookie ||= File.open(File.join(cache_dir, "session"), &:readline).strip
    end

    def cache_dir
      @_cache_dir ||= File.join(__dir__, "..", "..", "cache")
    end
  end
end
