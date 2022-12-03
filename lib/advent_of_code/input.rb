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
      File.join(directory, "day#{day}.txt")
    end

    def directory
      File.join(__dir__, "..", "..", "cache", year)
    end

    def download
      raise "Unable to download input without session cookie." unless session_cookie

      ensure_directory
      puts "Downloading input for #{year}, day #{day}..."
      uri = URI("https://adventofcode.com/#{year}/day/#{day}/input")
      req = Net::HTTP::Get.new(uri)
      req["Cookie"] = "session=#{session_cookie}"
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
      # FIXME handle errors
      File.write(local_path, res.body)
      res.body
    end

    def ensure_directory
      Dir.mkdir(directory) unless Dir.exist?(directory)
    end

    def session_cookie
      ENV["AOC_SESSION"]
    end
  end
end
