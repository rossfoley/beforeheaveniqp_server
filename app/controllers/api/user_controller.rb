class Api::UserController < BaseController
  def login
    if params[:email] and params[:password]
      user = User.where(email: params[:email]).first
      if user
        if user.valid_password? params[:password]
          success user
        else
          failure :not_acceptable, 'Incorrect password'
        end
      else
        failure :not_found, 'Could not find the specified user'
      end
    else
      failure :bad_request, 'Email and password must be provided'
    end
  end

  def search
    success User.full_text_search(params[:search_term]).to_a
  end

end
