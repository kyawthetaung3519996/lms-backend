class Api::V1::Admin::RolesController < ApplicationController
  before_action :set_role, only: [:show, :update, :destroy]

  def index
    roles = Role.order(created_at: :desc)
    render json: roles
  end

  def show
    render json: @role
  end

  def create
    role = Role.new(role_params)
    if role.save
      render json: {
        message: "Role created successfully.",
        role: role
      }, status: :created
    else
      render json: { errors: role.errors.to_hash(true) }, status: :unprocessable_entity
    end
  end

  def update
    if @role.update(role_params)
      render json: {
        message: "Role updated successfully.",
        role: @role
      }
    else
      render json: { errors: @role.errors.to_hash(true) }, status: :unprocessable_entity
    end
  end

  def destroy
    if @role.destroy
      render json: { message: "Role deleted successfully." }, status: :ok
    else
      render json: { errors: @role.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :is_default_admin)
  end
end
