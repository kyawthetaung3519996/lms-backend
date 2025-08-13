class Api::V1::Admin::UsersController < ApplicationController
  skip_before_action :authenticate
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.includes(:role).order(created_at: :desc)
    render json: users.as_json(include: { role: { only: [:id, :name] } })
  end
  
  def show
    render json: @user.as_json(include: { role: { only: [:id, :name] } })
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {
        message: "User created successfully.",
        user: user
      }, status: :created
    else
      render json: { errors: user.errors.to_hash(true) }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: {
        message: "User updated successfully.",
        user: @user
      }
    else
      render json: { errors: @user.errors.to_hash(true) }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { message: "User deleted successfully." }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :role_id)
  end
end
