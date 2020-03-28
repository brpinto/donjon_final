class MonthsController < ApplicationController

  def index
    current_month = Date.today.mon
    @month = Month.find(current_month)
    @users_count = User.count
    @notes_count = Note.count
    @confirmed_count = User.where('confirmed = 1').count
    @notes_per_user = @notes_count / @users_count

    @month.update(users_total: @users_count, notes_total: @notes_count, users_confirmed: @confirmed_count, notes_per_user: @notes_per_user)
    
    render_json
  end

  def show
  end

  private

  def render_json
    render json: {
        months_name: ["Janv", "Fév", "Mars", "Avr", "Mai", "Juin", "Juil", "Août", "Sept", "Oct", "Nov", "Déc"],
        months_data: Month.all
    }
  end
end
