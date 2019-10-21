class PlantsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    
   def index
        @plants = Plant.all
    end
    
    def new
        @plant = Plant.new
    end
 
    

    def create
        plant = current_user.plants.create(plant_params)
  if @plant.valid?
    redirect_to root_path
  else
    render :new, status: :unprocessable_entity
  end
    end

    def show
        @plant = Plant.find(params[:id])
    end

    private

    def plant_params
      params.require(:plant).permit(:name, :zipcode)
    end

    def update
  @plant = Plant.find(params[:id])

  if @plant.user != current_user
    return render plain: 'Not Allowed', status: :forbidden
  end

  @plant.update_attributes(plant_params)
  if @plant.valid?
    redirect_to root_path
  else
    render :edit, status: :unprocessable_entity
  end
end
end
