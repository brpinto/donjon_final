class TitleValidator < ActiveModel::Validator
  def validate(record)
    current_title = User.current.notes.where(id: record.id).first.title
    User.current.notes.each do |note|
      if current_title != record.title
        if note.title == record.title and note.persisted?
          record.errors[:title] << "existe déjà"
        end
      end
    end
  end
end