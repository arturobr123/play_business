require 'spec_helper'

require 'play_business'


RSpec.describe PlayBusiness, "#TEST CASES" do

  context "Caso 1: Usuario con 3 inversiones a considerar" do
    it "Caso 1" do

      #create user and his/her investments
      user = User.new(:name => "Arturo", :email => "arturo@playbusiness.com" , :id => 1)
      startup = Startup.new(:name => "Thumbtack" , :id => 3)
      round = Round.new(:startup_id => 3 , :amount_to_raise => 50000, :amount_open_to_wallet => 10000 , :id => 1)

      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 10000 , :wallet_amount => 0, :id => 1)
      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 50000 , :wallet_amount => 10000, :id => 2)
      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 30000 , :wallet_amount => 5000, :id => 3)
      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 2500 , :wallet_amount => 2500, :id => 4)

      service = PlayBusiness.new(user.investments)
      service.getPromotion()

      #EXPECTATIONS
      #limit 1
      expect(service.lower_limits[0]).to be >= 3061.85
      expect(service.lower_limits[0]).to be <= 3061.87

      #limit 2
      expect(service.lower_limits[1]).to be >= 6123.71
      expect(service.lower_limits[1]).to be <= 6123.73

      #limit 3
      expect(service.lower_limits[2]).to be >= 30618.61
      expect(service.lower_limits[2]).to be <= 30618.63
    end
  end


  context "Caso 2: Usuario con 2 inversiones a considerar y bajo coeficiente de variación" do
    it "Caso 2" do

      #create user and his/her investments
      user = User.new(:name => "Arturo", :email => "arturo@playbusiness.com" , :id => 1)
      startup = Startup.new(:name => "Thumbtack" , :id => 3)
      round = Round.new(:startup_id => 3 , :amount_to_raise => 1000000, :amount_open_to_wallet => 10000 , :id => 1)

      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 100000 , :wallet_amount => 0, :id => 1)
      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 90000 , :wallet_amount => 10000, :id => 2)

      service = PlayBusiness.new(user.investments)
      service.getPromotion()

      #EXPECTATIONS
      #limit 1
      expect(service.lower_limits[0]).to be >= 9633.09
      expect(service.lower_limits[0]).to be <= 9633.11

      #limit 2
      expect(service.lower_limits[1]).to be >= 19266.20
      expect(service.lower_limits[1]).to be <= 19266.22

      #limit 3
      expect(service.lower_limits[2]).to be >= 77044.80
      expect(service.lower_limits[2]).to be <= 77064.83
    end
  end


  context "Caso 3: Usuario con 2 inversiones a considerar y coeficiente de variación por arriba del mínimo" do
    it "Caso 3" do

      #create user and his/her investments
      user = User.new(:name => "Arturo", :email => "arturo@playbusiness.com" , :id => 1)
      startup = Startup.new(:name => "Thumbtack" , :id => 3)
      round = Round.new(:startup_id => 3 , :amount_to_raise => 1000000, :amount_open_to_wallet => 10000 , :id => 1)

      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 100000 , :wallet_amount => 0, :id => 1)
      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 80000 , :wallet_amount => 10000, :id => 2)

      service = PlayBusiness.new(user.investments)
      service.getPromotion()

      #EXPECTATIONS
      #limit 1
      expect(service.lower_limits[0]).to be >= 19499
      expect(service.lower_limits[0]).to be <= 19501

      #limit 2
      expect(service.lower_limits[1]).to be >= 58499
      expect(service.lower_limits[1]).to be <= 58501

      #limit 3
      expect(service.lower_limits[2]).to be >= 175499
      expect(service.lower_limits[2]).to be <= 175501
    end
  end


  context "Caso 4: Usuario con 1 inversión a considerar" do
    it "Caso 4" do

      #create user and his/her investments
      user = User.new(:name => "Arturo", :email => "arturo@playbusiness.com" , :id => 1)
      startup = Startup.new(:name => "Thumbtack" , :id => 3)
      round = Round.new(:startup_id => 3 , :amount_to_raise => 1000000, :amount_open_to_wallet => 10000 , :id => 1)

      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 100000 , :wallet_amount => 0, :id => 1)

      service = PlayBusiness.new(user.investments)
      service.getPromotion()

      #EXPECTATIONS
      #limit 1
      expect(service.lower_limits[0]).to be >= 9633.0
      expect(service.lower_limits[0]).to be <= 9633.2

      #limit 2
      expect(service.lower_limits[1]).to be >= 19266.1
      expect(service.lower_limits[1]).to be <= 19266.3

      #limit 3
      expect(service.lower_limits[2]).to be >= 77064.7
      expect(service.lower_limits[2]).to be <= 77064.9
    end
  end


  context "Caso 5:  Usuario con 0 inversiones" do
    it "Caso 5" do

      #create user and his/her investments
      user = User.new(:name => "Arturo", :email => "arturo@playbusiness.com" , :id => 1)
      startup = Startup.new(:name => "Thumbtack" , :id => 3)
      round = Round.new(:startup_id => 3 , :amount_to_raise => 1000000, :amount_open_to_wallet => 10000 , :id => 1)

      user.investments.new(:user_id => 1 , :round_id => 1 , :amount => 5000 , :wallet_amount => 0, :id => 1)

      service = PlayBusiness.new(user.investments)
      service.getPromotion()

      #EXPECTATIONS
      #limit 1
      expect(service.lower_limits[0]).to be >= 463.0
      expect(service.lower_limits[0]).to be <= 463.2

      #limit 2
      expect(service.lower_limits[1]).to be >= 926.26
      expect(service.lower_limits[1]).to be <= 926.29

      #limit 3
      expect(service.lower_limits[2]).to be >= 4631.40
      expect(service.lower_limits[2]).to be <= 4631.44
    end
  end


end
