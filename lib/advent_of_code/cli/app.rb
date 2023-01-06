# frozen_string_literal: true

require "thor"
require "ferrum"

module AdventOfCode
  module CLI
    class App < Thor
      include Thor::Actions

      Solve.register_in(self)
      Generate.register_in(self)

      desc "login", "Open a browser window to log in to Advent of Code"
      def login
        say "Opening browser, please log in."

        browser = Ferrum::Browser.new(headless: false)
        browser.goto("https://adventofcode.com/auth/login")

        say "Waiting for log in to complete...", nil, false

        session_cookie = nil

        loop do
          session_cookie = browser.cookies["session"]
          break if session_cookie&.domain == ".adventofcode.com"

          say ".", nil, false
          sleep 1
        end
        say

        create_file("cache/session", "session_cookie.value")
      end

      desc "download [YEAR]", "Download all available inputs for a given year (defaults to the latest)"
      def download(year = nil)
        year, latest_day = year_day(year)

        say "Downloading inputs for #{year}..."

        1.upto(latest_day) do |day|
          Input.new(year, day).read
        end

        say "Done!"
      end

      desc "problems [YEAR]", "Download all available problems for a given year"
      def problems(year = nil)
        year, latest_day = year_day(year)

        say "Downloading problems for #{year}..."

        root = File.join(__dir__, "..", "..", "..")
        problems_dir = File.join(root, "problems", year.to_s)
        FileUtils.mkdir_p(problems_dir)

        session_cookie = File.open(File.join(root, "cache", "session"), &:readline).strip

        1.upto(latest_day) do |day|
          # FIXME could we avoid redownloading? (problem: the second part might be available later)
          say "Downloading problem for #{year}, day #{day}..."

          # FIXME factorize "logged-in downloader"
          uri = URI("https://adventofcode.com/#{year}/day/#{day}")
          req = Net::HTTP::Get.new(uri)
          req["Cookie"] = "session=#{session_cookie}"
          req["User-Agent"] = "github.com/davidstosik/advent_of_code" # FIXME make configurable?
          res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(req)
          end
          # FIXME handle errors (eg 404)
          local_path = File.join(problems_dir, "#{day}.html")
          File.write(local_path, res.body)
        end

        say "Done!"
      end

      private

      def year_day(year)
        latest_year = Time.now.year
        latest_year -= 1 unless Time.now.month == 12

        year = year&.to_i || latest_year

        unless (2015..latest_year).cover?(year)
          raise ArgumentError, "Year must be between 2015 and #{latest_year}"
        end

        if year == Time.now.year
          # FIXME: because of timezones, this might need to be yesterday
          latest_day = Time.now.day
        else
          latest_day = 25
        end

        [year, latest_day]
      end
    end
  end
end
