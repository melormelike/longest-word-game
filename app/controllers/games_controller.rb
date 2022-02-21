require "nokogiri"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a
    @alp = @letters.sample(10)
  end

  def score
    # raise
    result = params[:letter].upcase.split('').all? do |element|
      params[:grid].split.include?(element)
    end
    # # if result == true
    #   @score = "Congratulations! #{params[:letter]} can be built #{params[:grid]}"
    # else
    #   @score = "Sorry but #{params[:letter]} can not be built out of #{params[:grid]}.."
    # end
    search = "#{params[:letter]}"
    url = "https://wagon-dictionary.herokuapp.com/#{search}"
    query = URI.open(url).read
    english_word = JSON.parse(query)
    # raise
    if english_word["found"] == true && result
      @english = "Congratulations! #{search} is a valid English word"
    elsif english_word["found"] == false
      @english = "Sorry but #{search} is not a valid English word"
    else
      @english = "Sorry but #{search} can not be built out of #{params[:grid]}.."
    end
  end
end

# html_doc.search(".standard-card-new__article-title").each do |element|
#   puts element.text.strip
#   puts element.attribute("href").value
# end
