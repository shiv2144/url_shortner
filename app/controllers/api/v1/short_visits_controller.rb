class ShortVisitsController < ApplicationController

  def index
    @short_visits = ShortVisit.all
  end

  def show
  end

  def new
    @short_visit = ShortVisit.new
  end

  def edit
  end

  def create
    @short_visit = ShortVisit.new(short_visit_params)

    respond_to do |format|
      if @short_visit.save
        format.json { render :show, status: :created, location: @short_visit }
      else
        format.json { render json: @short_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @short_visit.update(short_visit_params)
        format.json { render :show, status: :ok, location: @short_visit }
      else
        format.json { render json: @short_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @short_visit.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_visit
      @short_visit = ShortVisit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_visit_params
      params.require(:short_visit).permit(:short_url_id, :visitor_ip, :visitor_city, :visitor_state, :visitor_country, :created_at)
    end
end
