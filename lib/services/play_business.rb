module Services
  class PlayBusiness

    def initialize(investments)

      #@payments = investments.select{|item| item.amount + item.wallet_amount } #get total amount
      @payments = investments

      @average = @payments.inject(0, :+)/ @payments.size #sum all the payments (average)
      @standard_deviation = standard_deviation(@payments) #standard_deviation
      @cv = @standard_deviation/@average #CV

      #puts "average #{average}"
      #puts "standard_deviation #{standard_deviation}"
      #puts "cv #{cv}"
      @done = false
    end

    def variance(x)
      m = x.inject{ |sum, el| sum + el }.to_f / x.size
      sum = 0.0
      x.each {|v| sum += (v-m)**2 }
      sum/x.size
    end

    def standard_deviation(x)
      Math.sqrt(variance(x))
    end

    #which promtion
    def getPromotion()

      #small promotion
      if @cv >= 0 and @cv < 3
        prom =  SmallPromotion.which_promotion(@average)
        generate_table(prom)
      end
      #middle promotion
      if @cv >= 3 and @cv < 1.3
      end

      #big promotion
      if @cv >= 1.3
      end
    end

    def generate_table(prom)
      table = []
      prom.each do |key,val|
        res = @standard_deviation * key
        table << [res , val]
      end

      puts "limite inferior: #{table[0][0]} - limite superior: #{table[1][0] - 0.1} - bonificacion: #{table[0][1]}"
      puts "limite inferior: #{table[1][0]} - limite superior: #{table[2][0] - 0.1} - bonificacion: #{table[1][1]}"
      puts "limite inferior: #{table[2][0]} -  bonificacion: #{table[2][1]}"

      @done = true
    end

  end

  #0.14> CV <0.3
  class SmallPromotion
    @more50 = {1.3 => "25%" , 3.9 => "30%" , 11.7 => "40%"}
    @less10 = {0.8 => "20%" , 2.4 => "30%" , 7.2 => "35%"}
    @more10less25 = {0.8 => "20%" , 2.4 => "30%" , 7.2 => "35%"}
    @more25less50 = {0.8 => "20%" , 2.4 => "30%" , 7.2 => "35%"}

    def self.which_promotion(average)

      if average > 50000
        return @more50
      elsif average < 10000
        return @less10
      elsif average >= 10000 and average < 250000
        return @more10less25
      elsif average >= 25000 and average <= 50000
        return @more25less50
      end

    end

  end


  #CV > =0.3 < 1.3
  class MediumPromotion

    @more50 = {0.5 => "25%" , 1 => "30%" , 4 => "35%"}
    @less10 = {0.35 => "30%" , 0.7 => "35%" , 3.5 => "40%"}
    @more10less25 = {0.25 => "20%" , 0.5 => "30%" , 2.5 => "35%"}
    @more25less50 = {0.2 => "20%" , 0.4 => "30%" , 1.6 => "40%"}

    def self.which_promotion(average)

      if average > 50000
        return @more50
      elsif average < 10000
        return @less10
      elsif average >= 10000 and average < 250000
        return @more10less25
      elsif average >= 25000 and average <= 50000
        return @more25less50
      end

    end

  end

  #CV>=1.3
  class BigPromotion

    @more40 = {0.6 => "25%" , 0.9 => "32%" , 1.3 => "40%"}
    @less40 = {0.1 => "17%" , 0.16 => "35%" , 0.2 => "40%"}

    def self.which_promotion(average)

      if average > 40000
        return @more40
      elsif average <= 40000
        return @less40
      end

    end

  end


end
