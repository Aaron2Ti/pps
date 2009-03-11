# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def clear
    content_tag :div,nil,
      :style => 'clear: both; border: none; background: transparent; height: 0px; width: 0px;'
  end

  def account_link
    if current_user
      link_to('账户信息/', edit_account_path) + link_to('注销', logout_path, :method => :delete)
    else
      link_to('注册', signup_path) + link_to(' -> 登陆', login_path)
    end
  end
end
