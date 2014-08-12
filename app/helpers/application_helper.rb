module ApplicationHelper

  def fix_url(str)
    str.starts_with?("http://")? str : "http://#{str}"
  end
  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z") # format: #03/28/2014 10:25am
  end
end
