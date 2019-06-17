class Parents::EmailConfigsController < ApplicationController
  before_action :set_parent, only: [:edit, :update]
  before_action :set_email_config, only: [:edit, :update]

  # GET /parents/1/email_configs/44/edit
  def edit
  end

  # PATCH/PUT /parents/1/email_configs/44
  def update
    respond_to do |format|
      if @email_config.update(email_config_params)
        format.html { redirect_to @parent, notice: "Email Config Successfully Updated." }
        format.json { render :show, status: :ok, location: @parent }
      else
        format.html { render :edit }
        format.json { render json: @email_config.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_parent
    @parent = Parent.find(params[:parent_id])
  end

  def set_email_config
    @email_config = EmailConfig.find(params[:id])
  end

  def email_config_params
    params.require(:email_config).permit(:description, :active, :email)
  end
end
