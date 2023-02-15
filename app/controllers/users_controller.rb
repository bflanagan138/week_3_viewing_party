class UsersController <ApplicationController 
    before_action :validate_user, only: :show

    def new 
        @user = User.new()
    end 

    def show 
        @user = User.find(params[:id])
    end 

    def create 
        user = User.create(user_params)
        user_email = user[:email].downcase
        if user.save
            session[:user_id] = user.id
            redirect_to user_path(user)
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end 

    def login_form; end

    def login
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Welcome #{user.name}!"
            redirect_to user_path(user)
        else
            flash[:error] = "Incorrect credentials, try again"
            render :login_form
        end
    end

    def logout
        session.destroy
        redirect_to root_path
    end

    private 

    def user_params 
        params[:user][:email].downcase!
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 