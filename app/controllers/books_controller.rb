class BooksController < ApplicationController
  def index
  end

  def selected
    #google books JSON api request
      url = 'https://www.googleapis.com/books/v1/volumes?filter=partial&maxResults=1&langRestrict=en&printType=books&q=' + session[:type].to_s + '+subject%20:' + session[:genre].to_s + '+subject%20:' + session[:topic] + '&startIndex=' + rand(20).to_s
      response = HTTParty.get(url)

      #variables to be used from google books api
        begin
          @title = response['items'][0]['volumeInfo']['title']
        rescue
          @title = ' '
        end

        begin
          @author = response['items'][0]['volumeInfo']['authors'][0]
        rescue
          @author = ' '
        end

        begin
          @description = response['items'][0]['volumeInfo']['description']
        rescue
          @description = nil
        end

        begin
          @imageURL = response['items'][0]['volumeInfo']['imageLinks']['thumbnail']
        rescue
          @imageURL = nil
        end

        begin
          @id = response['items'][0]['id']
        rescue
          @id = nil
        end

        @recommendation = response.parsed_response

      #goodreads API request
        response1 = HTTParty.get('https://www.goodreads.com/book/title.xml?author=' + @author + '&key=' + DB_CONN_GOODREADS_KEY + '&title=' + @title)
        data = response1.parsed_response
        # @data = data
        @averageRating = data['GoodreadsResponse']['book']['average_rating']
        @url = data['GoodreadsResponse']['book']['url']
        @isbn = data['GoodreadsResponse']['book']['isbn']
  end

  def show
    @book = Book.find(params[:id])

    options_hash = {1 =>["fiction", "non-fiction", "biography"], 2 => ["humor", "drama", "satire", "crime", "tragedy", "horror", "mystery", "romance"], 3 => ["history", "feminism", "cats", "outerspace", "time travel", "simplicity", "faith", "coming of age", "travel", "exercise", "love", "serial killer", "war", "adventure", "pirates"]}

    @options = options_hash[params[:id].to_i]

    if params[:id].to_i < 3
      @next_id = params[:id].to_i + 1
    else
      @next_id = '/selected'
    end

  end

  def update
    if params[:id].to_i < 3
      @next_id = params[:id].to_i + 1
    else
      @next_id = 'selected'
    end

    @book = Book.find(params[:id])
    @selected_option = params[:option]

    if params[:id] == "1"
      session[:type] = params[:option]
    elsif params[:id] == "2"
      session[:genre] = params[:option]
    elsif params[:id] =="3"
      session[:topic] = params[:option]
    end

    redirect_to controller: 'books', action: 'show',  id: @next_id

    # if params[:id] == "2"
    #   @option1 = params[:option]
    # elsif params[:id] == "3"
    #   @option2 = params[:option]
    # end

      # redirect_to controller: 'books', action: 'show',  id: @next_id, option: params[:option], selected1: @option1, selected2: @option2
      # book_path(params.merge(option: @selected_option))
  end

end
