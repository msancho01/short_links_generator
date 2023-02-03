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

  private
    def create_params
      params.require(:short_link).permit(:long_url)
    end

    def update_params
      params.require(:short_link).permit(:long_url, :title, :clicks_count)
    end
end
