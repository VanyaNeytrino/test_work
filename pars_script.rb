require 'mechanize'
require 'sqlite3'
require 'open-uri'
require 'active_record'
require_relative './environment'

class Parser

  attr_reader :body

  def initialize(mechanize_obj)
    @body = mechanize_obj
  end

  def query_content(css_path)
    body.at_css(css_path).content
  rescue NoMethodError
    nil
  end

end

class Rating < Parser
  def query_content
     super('.rating')
   end
end

class Number < Parser
  def query_content
   super('.id')
 end
end

class DateS < Parser
  def query_content
   super('.date')
 end
end

class Text < Parser
  def query_content
   super('.text')
 end
end



class Quotation < ActiveRecord::Base

  def create_from_hash(hash)
  self.rating = hash.dig(:rating)
  self.number = hash.dig(:number)
  self.text   = hash.dig(:text)
  self.date   = hash.dig(:date)
  self.save
    rescue NoMethodError
      nil
  end
end

class DatabaseAgregator < Parser

  def initialize(mechanize_obj)

  end

  def scan_stories
    page = Mechanize.new.get('https://bash.im')

    page.css('.quote').each do |s|
      hash = {}
      hash[:rating] = Rating.new(s).query_content
      hash[:number] = Number.new(s).query_content
      hash[:data]   = DateS.new(s).query_content
      hash[:text]   = Text.new(s).query_content
      Quotation.new.create_from_hash(hash)
  end
 end
end
DatabaseAgregator.new(Mechanize.new.get('https://bash.im')).scan_stories
