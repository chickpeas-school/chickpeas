class MassMessagesController < ApplicationController

  def show
    @mass_message = MassMessage.find(params[:id])
  end

  def new
    @parents = Year.current_parents
    @mass_message = MassMessage.new
  end

  def create
    parents = Parent.find(parent_ids)
    @mass_message = MassMessage.new(mass_message_params)
    @mass_message.parents = parents

    respond_to do |format|
      if @mass_message.send_sms
        format.html { redirect_to root_path, notice: 'Message successfully sent' }
        format.json { render :show, status: :created, location: @mass_message }
      else
        format.html { render :new }
        format.json { render json: @mass_message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def parent_ids
    params[:mass_message][:parent_ids]
  end

  def mass_message_params
    params.require(:mass_message).permit(:message)
  end
end
