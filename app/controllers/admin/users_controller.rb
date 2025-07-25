class Admin::UsersController < Admin::BaseController
  layout "admin"
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.includes(:roles).order(created_at: :desc)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      handle_superadmin_role
      redirect_to admin_user_path(@user), notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      handle_superadmin_role
      redirect_to admin_user_path(@user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_url, notice: "User was successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    permitted_attributes = User.column_names - [ "id", "created_at", "updated_at" ]
    params.require(:user).permit(*permitted_attributes)
  end

  def handle_superadmin_role
    return unless params[:user][:is_superadmin].present?

    if params[:user][:is_superadmin] == "1"
      @user.make_superadmin!
    else
      @user.remove_superadmin!
    end
  end
end
