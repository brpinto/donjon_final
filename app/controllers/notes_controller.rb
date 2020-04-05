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
      redirect_to note_path(@note.slug), success: "Votre note a été créée avec succès."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to note_path(@note.slug), success: "Votre note a bien été mise à jour."
    else
      render 'edit'
    end
  end

  def destroy
    @note.destroy
    redirect_to root_path, success: "Votre note a bien été supprimée."
  end

  private

  def note_params
    params.require(:note).permit(:title, :game_name, :game_type, :content, :all_tags)
  end

  def set_note
    @note = current_user.notes.find_by_slug params[:slug]
  end

end
