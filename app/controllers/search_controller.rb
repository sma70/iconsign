class SearchController < ApplicationController
  def index
    search_input = params[:SearchInput]
    @search_results = Item.tagged_with(search_input)
    @tags=[]
    Item.all.each do |item|
      @tags = @tags + item.tag_list
    end
           
  end

  def search
    @tags=[]
    Item.all.each do |item|
      @tags = @tags + item.tag_list
    end
    search_input = params[:SearchInput]
    @search_results = Item.tagged_with(search_input)
  end

end
