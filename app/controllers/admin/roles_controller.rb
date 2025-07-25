class Admin::RolesController < Admin::BaseController
  before_action :set_role, only: %i[show edit update destroy]

  def index
    @roles = Role.order(created_at: :desc)
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to admin_role_path(@role), notice: "Role was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @role.update(role_params)
      redirect_to admin_role_path(@role), notice: "Role was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @role.destroy!
    redirect_to admin_roles_url, notice: "Role was successfully destroyed."
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    permitted_attributes = Role.column_names - [ "id", "created_at", "updated_at" ]
    params.require(:role).permit(*permitted_attributes)
  end
end
