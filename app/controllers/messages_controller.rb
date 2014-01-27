class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  # TODO: Move off 'index' to its own route
  def index
    if params[:email]
      @messages = Message.where(:email, params[:email]) 
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new

    Size.common.each do |size|
      @message.screenshots.build(size_id: size.id)
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.queued = true
    build_screenshots

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    # Remove all previous screenshots so we have a fresh slate
    @message.screenshots.destroy_all
    build_screenshots

    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def deliver
    respond_to do |format|
      if MessageDeliverer.deliver(params[:message_id])
        format.html { redirect_to @message, notice: 'Message was queued for delivery.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id] || params[:message_id])
    end

    def sizes
      # Sizes come as a hash {'1'=>true, '2'=>true}, so we need to parse to [1,2]
      params[:sizes] && params[:sizes].keys || []
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:description, :email, :url)
    end

    # TODO: Extract to form object?
    def build_screenshots
      sizes.each do |size|
        @message.screenshots.new(size_id: size) if Size.exists?(size)
      end
    end
end
