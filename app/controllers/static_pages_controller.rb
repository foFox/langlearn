class StaticPagesController < ApplicationController
  skip_before_filter :api_session_token_authenticate!

  def home
    render file: "#{Rails.root}/app/views/static_pages/index.html"
  end
  def page
    case params[:format]
    when "js"
      send_file "#{Rails.root}/app/views/static_pages/js/#{params[:file_name]}.#{params[:format]}",:disposition =>'inline',:type => StaticPage::Formats[params[:format]]
    when "css"
      send_file "#{Rails.root}/app/views/static_pages/css/#{params[:file_name]}.#{params[:format]}",:disposition =>'inline',:type => StaticPage::Formats[params[:format]]
    else
      send_file "#{Rails.root}/app/views/static_pages/#{params[:file_name]}.#{params[:format]}",:disposition =>'inline',:type => StaticPage::Formats[params[:format]]
    end
  end
end
