require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'selenium-webdriver'
require 'chromedriver-helper'

class Bot
  def self.insta_bot(job)
    like_counter = 0
    # # photo_liked = []
    # user_liked = []
    # user_hashtags = []
    # hashtag = "cat"

    # Open Browser, Navigate to Login page
    browser = Watir::Browser.new(:chrome, options: { headless: ['--incognito'], args: ['no-sandbox'] })
    # , binary: ENV['GOOGLE_CHROME_PATH']
    # sleep(3)
    browser.goto "instagram.com/accounts/login/"
    sleep(3)
    puts "Logging in..."
    browser.text_field(name: "username").set "#{job.instagram_username}"
    browser.text_field(name: "password").set "#{job.instagram_password}"
    sleep(3)
    browser.button(class: ['sqdOP', 'L3NKy', 'y3zKF']).click
    sleep(3)
    if browser.button(class: ['aOOlW', 'HoLwm']).exists?
      sleep(3)
      browser.button(class: ['aOOlW', 'HoLwm']).click
    end

    puts "----Get the post----"

    browser.goto "https://www.instagram.com/#{job.instagram_username}"
    # goes our post the picture
    browser.div(class: ['_9AhH0']).click
    sleep(3)
    job.image_url = browser.url
    job.save

    puts "--------- #{Time.now} Starting liking----------"
    # sleep(1)
    # goes on the hashtag
    browser.goto "https://www.instagram.com/explore/tags/#{job.hashtag}"
    sleep(3)
    # goes on the picture
    browser.divs(class: ['_9AhH0'])[9].click
    sleep(3)

    # given_likes.ig_media_id = browser.url
    # sleep(1)
    # user_liked << browser.h2(class: ['_6lAjh']).text
    # sleep(3.09)
    # user_hashtags << browser.div(class: ['C4VMK']).span.text.match(/#.+/).to_s.split(" ")

    # checked if liked
    if browser.span(class: ['glyphsSpriteHeart__outline__24__grey_9', 'u-__7']).exists?
      # likes
      browser.span(class: ['fr66n']).click
      GivenLike.create(ig_media_id: browser.url, job_id: job.id)
      puts like_counter += 1
      sleep(3)
    end
    # close the page
    browser.button(class: ['ckWGn']).click
    puts "--------- #{Time.now} Stop Liking----------"
  end
end
