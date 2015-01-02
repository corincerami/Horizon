class CarsController < ApplicationController

  def index
    @cars = Car.all
  end

  def new
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @car = Car.new
    @years = valid_years
  end

  def create
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @car = @manufacturer.cars.build(car_params)
    if @car.save
      flash[:notice] = "Car created"
      redirect_to cars_path
    else
      @years = valid_years
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:color, :year, :mileage, :description)
  end

  def valid_years
    DateTime.now.year.downto(1920).to_a
  end
end
