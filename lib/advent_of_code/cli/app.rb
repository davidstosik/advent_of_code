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

        say "Downloading inputs for #{year}..."

        1.upto(latest_day) do |day|
          Input.new(year, day).read
        end

        say "Done!"
      end
    end
  end
end
