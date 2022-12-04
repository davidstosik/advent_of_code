# frozen_string_literal: true

require "thor"
require "ferrum"

module AdventOfCode
  class CLI < Thor
    include Thor::Actions

    desc "today", "Solve today's puzzles"
    def today
      Today.run
    end

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
  end
end
