require "rexml/document"
require "open-uri"
require "cgi"
require "net/http"
include SearchesHelper

class SearchesController < ApplicationController
  before_filter :get_search, :only => [:show, :result, :create, :update ]
  before_filter :save_search, :only => [:show, :create, :result, :update]

  def get_search
     @search = Search.new(params[:search])
  end
  
  def save_search
    begin
       @search.save
    rescue    
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
    end
  end
  
  helper_method :call_flickr_api
  helper_method :construct_urls
  

  
  
  def result
        @urls=get_urls_from_searchtext(@search.searchtext)
        @searches = Search.order("id DESC").limit(10)
        render :action => 'result'
  end
  
  # GET /searches
  # GET /searches.json
  def index
    result
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    result
  end

  # GET /searches/new
  # GET /searches/new.json
  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searches/1/edit
  def edit
    result
  end

  # POST /searches
  # POST /searches.json
  def create
    result
  end

  # PUT /searches/1
  # PUT /searches/1.json
  def update
      result
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :ok }
    end
  end
end
