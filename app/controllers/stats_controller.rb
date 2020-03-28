class StatsController < ApplicationController

  def index
    current_time = Time.now
    current_year = current_time.year
    current_month = current_time.month

    @users_count = User.count
    @notes_count = Note.count
    @confirmed_count = User.where('confirmed = 1').count
    @notes_per_user = @notes_count / @users_count

    if @stat = Stat.where('YEAR(created_at) = :year AND MONTH(created_at) = :month', year: current_year, month: current_month).first
      @stat.update(users_total: @users_count, notes_total: @notes_count, users_confirmed: @confirmed_count, notes_per_user: @notes_per_user)
    else
      @stat = Stat.new
      @stat.update(users_total: @users_count, notes_total: @notes_count, users_confirmed: @confirmed_count, notes_per_user: @notes_per_user)
    end

    render_json
  end

  def show
  end

  private

  def render_json
    render json: {
        months_name: ["Janv", "Fév", "Mars", "Avr", "Mai", "Juin", "Juil", "Août", "Sept", "Oct", "Nov", "Déc"],
        months_data: Stat.all.order('created_at ASC')
    }
  end
end
