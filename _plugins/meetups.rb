require 'rest-client'
require 'json'

module Jekyll

  class MeetupsPage < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir = dir
      @name = 'community.html'

      puts "\tGenerating meetups page..."
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'community.html')
      meetups = []
      site.data['meetups'].each do |group|
        url = "https://api.meetup.com/#{group}/events"
        response = RestClient.get(url)
        data = JSON.parse(response)
        meetups << data.first if data.length > 0
      end
      meetups.sort! { |x,y| x['time'] <=> y['time'] }
      self.data['meetups'] = meetups
    end
  end

  class MeetupsPageGenerator < Generator
    safe true
    priority :lowest
    def generate(site)
      site.pages << MeetupsPage.new(site, site.source, '/')
    end
  end

end