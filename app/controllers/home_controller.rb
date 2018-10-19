class HomeController < ApplicationController
  def show
    @announcements = Announcement.all
  end
end
