class BaggagesController < ApplicationController

  def initialize
    @mean_num = Float::NAN
    @mean_weight = Float::NAN
    @baggages = nil
  end

  def index
    @baggages = Baggage.all
  end

  def new
    @baggage = Baggage.new
  end

  def show
    @baggage = Baggage.find(params[:id])
  end

  def create
    @baggage = Baggage.new(baggage_params)

    if @baggage.save
      redirect_to @baggage
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @baggage = Baggage.find(params[:id])
  end

  def update
    @baggage = Baggage.find(params[:id])

    if @baggage.update(baggage_params)
      redirect_to @baggage
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @baggage = Baggage.find(params[:id])
    @baggage.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def baggage_params
    params.require(:baggage).permit(:num, :weight)
  end

  def mean_weight
    if @mean_num.nan?
      sum = @baggages.reduce(0) {|acc, baggage| acc + baggage.weight}
      @mean_num = sum .fdiv @baggages.length
    end
    @mean_num
  end

  def mean_num
    if @mean_weight.nan?
      sum = @baggages.reduce(0) {|acc, baggage| acc + baggage.num}
      sum .fdiv @baggages.length
    end
    @mean_weight
  end

  def baggage_mean_weight(baggage)
    @weight .fdiv @num
  end

  public

  def c_task
    delta = 0.5
    result = (not @baggages.find {|baggage| @baggages.select{|second_baggage| baggage.num == second_baggage.num and
      not (baggage.weight - second_baggage.weight).abs > delta}.length > 0}.nil?)
    flash.now[:notice] = "True" ? result : "False"
  end

  def a_task
    delta = 0.3
    #res_baggage = @baggages.find {|baggage| not (baggage_mean_weight(baggage) - mean).abs > delta}
    @baggage = Baggage.where("ABS(weight - :mean) > :delta", {mean: Baggage.average(:weight), delta: delta}).first
  end
end
