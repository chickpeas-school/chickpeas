class HomeController < ApplicationController
  def show
    @announcements = Announcement.paginate(page: params[:page])
  end
end
