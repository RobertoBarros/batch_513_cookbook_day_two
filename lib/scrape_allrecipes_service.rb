class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.allrecipes.com/search/results/?wt=#{@keyword}"

    doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    results = []

    doc.search('.fixed-recipe-card').first(5).each do |card|
      name = card.search('h3').text.strip
      url = card.search('h3 a').attribute('href').value

      results << { name: name, url: url }
    end

    results.each_with_index do |result, index|
      puts "#{index + 1} #{result[:name]}"
    end

    puts "Enter index"
    index = gets.chomp.to_i - 1

    url_detail = results[index][:url]

    doc = Nokogiri::HTML(open(url_detail), nil, 'utf-8')

    name = results[index][:name]
    description = doc.search('.recipe-summary').text.strip
    rating = doc.search('.review-star-text').first.text.strip.match(/\d\.\d{2}/)[0].to_f.round
    prep_time = doc.search('.recipe-meta-item-body')[3].text.strip

    Recipe.new(name, description, rating, prep_time)
  end
end
