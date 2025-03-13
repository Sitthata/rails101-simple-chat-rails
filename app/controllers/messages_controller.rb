class MessagesController < ApplicationController
  before_action :set_room, only: %i[ index new create ]
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    @messages = @room.messages
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new(room: @room)
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params.merge(room: @room))

    respond_to do |format|
      if @message.save
        @message.broadcast_append_to @message.room, partial: @message,
          locals: { message: @message }, target: "room-messages"
        format.turbo_stream
        format.html { redirect_to [ @room, @message ], notice: "Message was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      @message.broadcast_remove_to @message.room, target: @message
      format.turbo_stream
      format.html { redirect_to message_path, status: :see_other, notice: "Message was successfully destroyed." }
    end
  end

  private
    def set_room
      @room = Room.find(params[:room_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content, :room_id)
    end
end
