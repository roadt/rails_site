class ProfilesController < ApplicationController

  before_filter :authenticate_user!

  respond_to :json, :xml

  doorkeeper_for :show, :if => lambda {|c| c.params[:format] == 'json'}

  # GET /profiles.json
  def show
    @profile = current_user #Profile.find(params[:id])
    respond_with @profile do |format|
      format.html # show.html.erb
#      format.json { render json: @profile }
    end
  end

  # GET /profiles/edit
  def edit
    @profile = current_user
  end

  # PUT /profiles
  # PUT /profiles
  def update
    @profile = current_user

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def doorkeeper_unauthorized_render_options
    {:template => "errors/error_401"}
  end

end
