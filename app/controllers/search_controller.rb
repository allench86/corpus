class SearchController < ApplicationController
  include SearchHelper

  def index
  end

  def search
    if params[:search].present?
      @results = do_search(params[:search], params[:page] || 1)
    else
      render 'index'
    end
  end
end
