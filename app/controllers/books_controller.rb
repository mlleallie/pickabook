class BooksController < ApplicationController
  def index
  end

  def selected
      url = 'https://www.googleapis.com/books/v1/volumes?filter=partial&maxResults=1&langRestrict=en&printType=books&projection=lite&q=' + params[:selected].to_s + '+subject%20:' + params[:option].to_s + '&startIndex=' + rand(50).to_s
      response = HTTParty.get(url)
      @recommendation = response.parsed_response

  end

  def show
    @book = Book.find(params[:id])

    options_hash = {1 =>["fiction", "non-fiction", "biography"], 2 => ["humor", "drama", "satire", "crime", "fantasty", "sci-fi", "tragedy", "horror", "mystery"], 3 => ["cats", "feminism", "pants", "aliens", "weather"]}

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

      redirect_to controller: 'books', action: 'show',  id: @next_id, option: params[:option], selected: params[:selected]

    # if params[:id] = '2'
    #   @selected_option = @option1
    # elsif params[:id] = '3'
    #   @selected_option = @option2
    # elsif params[:id] = '1'
    #   @selected_option = @option3
    # end
      # book_path(params.merge(option: @selected_option))

  end

end
