class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = current_user.notes
  end

  def show
  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      redirect_to note_path(@note.id), success: "Votre note a été créée avec succès."
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def note_params
    params.require(:note).permit(:title, :game_name, :game_type, :content)
  end

  def set_note
    @note = Note.find(params[:id])
  end

end
