class BaggagesController < ApplicationController

  def initialize
    @mean_num = Float::NAN
    @mean_weight = Float::NAN
    @baggages = nil
  end

  def index
    
  end

  def all_baggage
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

  def a_task
    delta = 0.3
    @baggage = Baggage.where("NOT(ABS(weight - :mean) > :delta)", {mean: Baggage.average(:weight), delta: delta}).first
  end

  def b_task
    @num_more_than_two = Baggage.where("num > 2").count
    @num_more_than_mean = Baggage.where("num > :mean", {mean: Baggage.average(:num)}).count
  end

  def c_task
    delta = 0.5
    @baggage_meeting_req = Baggage.find_by_sql(["SELECT f.* From baggages f WHERE EXISTS(SELECT s.id FROM baggages s WHERE (f.id != s.id AND f.num = s.num AND NOT(ABS(f.weight - s.weight) > ?)))",
                                                delta])
  end

  def d_task
    first_two = Baggage.order(num: :desc, weight: :desc).first(2)
    if first_two.length > 1 && first_two[0].num > first_two[1].num && first_two[0].weight > first_two[1].weight
      @baggage = first_two[0]
    else
      @baggage = nil
    end
  end

  def e_task
    @baggage = Baggage.where("num = 1 AND weight < 30").first
  end
end
