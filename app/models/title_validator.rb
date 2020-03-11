class TitleValidator < ActiveModel::Validator
  def validate(record)
    User.current.notes.each do |note|
      if note.title == record.title and note.persisted?
        record.errors[:title] << "existe déjà"
      end
    end
  end
end