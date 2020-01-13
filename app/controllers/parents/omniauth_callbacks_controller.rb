class Parents::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env["omniauth.auth"]
    @parent = Parent.from_omniauth(auth)

    if !@parent.nil? && @parent.persisted?
      @parent.provider = auth.provider, 
      @parent.uid = auth.uid
      @parent.save
      sign_in_and_redirect @parent, event: :authentication #this will throw if @parent is not activated
      set_flash_message(:notice, :success, kind: "Google Login") if is_navigational_format?
    else
      flash.alert = 'Google Auth Failed. Email provided does not match any existing Chickpeas parent emails'
      redirect_to new_parent_session_path
    end
  end

  def failure
    redirect_to root_path
  end
end