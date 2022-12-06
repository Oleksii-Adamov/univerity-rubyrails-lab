class BaggagesController < ApplicationController
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

  private
    def baggage_params
      params.require(:baggage).permit(:num, :weight)
    end
end
