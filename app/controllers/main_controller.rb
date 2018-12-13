class MainController < ApplicationController

  def home
    service = Services::PlayBusiness.new([10000 , 40000, 25000])
    service.getPromotion()

    render json: { service: 'Play business :) ', status: 200 }

  end

end
