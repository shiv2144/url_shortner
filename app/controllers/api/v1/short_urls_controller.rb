class ShortUrlsController < ApplicationController
  before_action :set_short_url, only: [:show, :edit, :update, :destroy]

  def index
    @short_urls = ShortUrl.all
  end

  def show
  end

  def new
    @short_url = ShortUrl.new
  end

  def edit
  end

  def create
    @short_url = ShortUrl.new(short_url_params)

    respond_to do |format|
      if @short_url.save
        format.json { render :show, status: :created, location: @short_url }
      else
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @short_url.update(short_url_params)
        format.json { render :show, status: :ok, location: @short_url }
      else
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @short_url.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_url
      @short_url = ShortUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_url_params
      params.require(:short_url).permit(:original_url, :shorty, :user_id, :created_at, :visits_count)
    end
end
