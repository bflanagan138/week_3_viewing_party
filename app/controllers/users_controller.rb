class UsersController <ApplicationController 
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
            flash[:success] = "Welcome #{user.name}!"
            redirect_to user_path(user)
        else
            flash[:error] = "Incorrect credentials, try again"
            render :login_form
        end
    end

    private 

    def user_params 
        params[:user][:email].downcase!
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 