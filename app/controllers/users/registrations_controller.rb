# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
    @profile = Profile.new
  end

  def create
    @user = User.new(sign_up_params)
    @profile = Profile.new(profile_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end

    unless @profile.valid?
      flash.now[:alert] = @profile.errors.full_messages
      render :new and return
    end

    @user.build_profile(@profile.attributes)
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    
    # @profile = @user.build_profile
    @address = @user.build_sending_destination
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    # @profile = Profile.new(profile_params)
    @address = SendingDestination.new(address_params)

    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end

    @user.build_sending_destination(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end

  protected

  def profile_params
    params.require(:profile).permit(
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

end
