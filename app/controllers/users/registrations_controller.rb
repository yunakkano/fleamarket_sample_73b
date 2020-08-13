# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_parents, only: [:edit, :update]
  before_action :minimum_pass_len, only: [:new, :edit]
  def new
    @user = User.new
    @profile = Profile.new
  end

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      puts "pass = #{pass}"
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end

    puts sign_up_params
    @user = User.new(sign_up_params)
    @profile = Profile.new(profile_params)
    unless @user.valid? && @profile.valid?
      flash.now[:alert] = @user.errors.full_messages.concat @profile.errors.full_messages
      render :new and return
    end

    @user.build_profile(@profile.attributes)
    session["devise.regist_data"] = {user: @user.attributes, profile: @profile.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_sending_destination
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = SendingDestination.new(address_params)

    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end

    @user.build_profile(session["devise.regist_data"]["profile"])
    @user.build_sending_destination(@address.attributes)
    if @user.save
      session["devise.regist_data"]["user"].clear
      sign_in(:user, @user)
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new_address and return
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_with_password(userinfo_update_params)
      bypass_sign_in(@user)
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit and return
    end
  end

  protected

  def profile_params
    params.require(:user).require(:profile).permit(
      :first_name, :family_name, 
      :first_name_kana, :family_name_kana, :birthday
    )
  end

  def address_params
    params.require(:sending_destination).permit(
      :dest_first_name,       :dest_family_name,
      :dest_first_name_kana,  :dest_family_name_kana,
      :building_name,         :post_code,
      :prefecture_code,       :city,
      :street_number,         :phone_number
    )
  end

  def userinfo_update_params
    params.require(:user).permit(
      :email, :current_password, :password, :password_confirmation
    )
  end

  def minimum_pass_len
    @minimum_password_length = User.password_length.min
  end
end
