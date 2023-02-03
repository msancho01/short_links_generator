class ShortLinksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    @shortlink = ShortLink.new(create_params)

    if @shortlink.save
      render json: @shortlink, status: :created
      UpdateShortLinkTitle.perform_in(10.seconds, @shortlink.id)
    else
      render json: @shortlink.errors, status: :unprocessable_entity
    end
  end

  def redirect
    shortlink = ShortLink.find_by(token: redirect_params[:token])
    if shortlink.present?
      clicks_count = shortlink.clicks_count.to_i + 1
      shortlink.update(clicks_count: clicks_count)
      redirect_to shortlink.long_url, allow_other_host: true
    else
      render 'unknown'
    end
  end

  def index
    @shortlinks = ShortLink.order(clicks_count: :desc).limit(100)
  end

  private
    def create_params
      params.require(:short_link).permit(:long_url)
    end

    def redirect_params
      params.permit(:token)
    end

    def update_params
      params.require(:short_link).permit(:long_url, :title, :clicks_count)
    end
end
