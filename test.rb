# coding: utf-8
require 'rubygems'
require 'open-uri'
require 'selenium-webdriver'
require 'nokogiri'
require 'uri'

# 検索条件設定
search_word = "ワールドカップ"

# selenium設定
driver = Selenium::WebDriver.for :firefox
driver.navigate.to "http://google.com"

# 検索結果取得
begin
  element = driver.find_element(:name, 'q')
  element.send_keys search_word
  element.submit
  #ここでスリープしないと結果がうまくとれなかった。
  sleep 5
rescue
  #なんか失敗したらとりあえずfirefox修了
  driver.quit
end

# 解析
html = driver.page_source
kaiseki_html = Nokogiri::HTML(html)
ranking_data =  kaiseki_html.css("div.rc").css("h3")

ranking_data.each do |site|
  pp site.css("a").attribute("href").value
end

driver.quit
