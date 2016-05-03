class BooksController < ApplicationController
  def index
  end

  def selected
    # debugger
      url = 'https://www.googleapis.com/books/v1/volumes?filter=partial&maxResults=1&langRestrict=en&printType=books&q=' + session[:type].to_s + '+subject%20:' + session[:genre].to_s + '+subject%20:' + session[:topic] + '&startIndex=' + rand(50).to_s
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
