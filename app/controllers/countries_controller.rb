class CountriesController < ApplicationController

  before_filter :require_user

  respond_to :html, :xml, :json

  # GET /countries
  # GET /countries.xml
  def index
    @countries = Country.all(:order => "created_at ASC")
    google_chart

    respond_to do |format|
      format.html
      format.xml  { render :xml => @countries }
      format.js
    end
  end

  def mark_as_visited
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

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  def new
    @country = Country.new
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])

    if @country.save
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => "countries/show", :locals => { :country => @country }, :layout => false, :status => :created
          else
            redirect_to @country
          end
        end
      end
    else
      respond_with do |format|
        format.html do
          if request.xhr?
            render :json => @country.errors, :status => :unprocessable_entity
          else
            render :action => :new, :status => :unprocessable_entity
          end
        end
      end
    end


#    respond_to do |format|
#      if @country.save
#        format.html { redirect_to(@country, :notice => 'Country was successfully created.') }
#        format.xml  { render :xml => @country, :status => :created, :location => @country }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to(@country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end
end
