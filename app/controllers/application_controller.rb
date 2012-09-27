class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page!"
      redirect_to new_user_session_url
      return false
    end
  end

  def google_chart
    @visited_countries = MyCollection.find_all_by_user_id(current_user.id, :order => "created_at ASC")
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('datetime', 'Date')
    data_table.new_column('number', 'Visited/Collected')
    data_table.add_rows(@visited_countries.count)

    @i = 0
    @visited = 1
    for mycollection in @visited_countries
      data_table.set_cell(@i, 0, mycollection.created_at)
      data_table.set_cell(@i, 1, @visited)
      @i += 1
      @visited += 1
    end
    opts   = { :width => 400, :height => 240, :title => 'Countries Visited & Currencies Collected', :legend => 'bottom' }
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, opts)
  end
end
