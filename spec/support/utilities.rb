include ApplicationHelper

def sign_in(user)
            visit signin_path

            fill_in "Email",        with: user.email
            fill_in "Password",     with: user.password
            click_button "Sign in"
            
            cookies[:remember_token] = user.remember_token
end

def create_list_under_user(param)
    @list = List.new(param[:title])
    param[:user].relationships.create!(list_id: list_id)
    return @list
end
