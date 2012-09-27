class CurrenciesController < ApplicationController

  before_filter :require_user

  # GET /currencies
  # GET /currencies.xml
  def index
    @currencies = Currency.all
    google_chart
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @currencies }
    end
  end

  def mark_as_collected
    #grab checked countries
    marked = params[:country_id]
    for id in marked
      country = Country.find(id)
      mine = MyCollection.new
      mine.user_id = current_user.id
      mine.country_id = country.code
      mine.currency_id = Currency.find_by_country_id(country.code).code
      mine.save
    end

    respond_to do |format|
      format.html { redirect_to :back, :remote => true }
      format.js
    end
  end

  # GET /currencies/1
  # GET /currencies/1.xml
  def show
    @currency = Currency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @currency }
    end
  end
end
