class TitleValidator < ActiveModel::Validator
  def validate(record)
    current_note = User.current.notes.where(id: record.id).first
    if !current_note.nil?
      note_title = current_note.title
    end
    User.current.notes.each do |note|
      if note_title != record.title
        if note.title == record.title and note.persisted?
          record.errors[:title] << "existe déjà"
        end
      end
    end
  end
end