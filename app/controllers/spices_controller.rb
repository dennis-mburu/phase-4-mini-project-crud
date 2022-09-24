class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_json_error

    #GET /spices
    def index
        render json: Spice.all, except:[:created_at, :updated_at]
    end

    #POST /spices
    def create 
        spice = Spice.create(spice_params)
        render json: spice, status: 201
    end

    #PATCH/PUT /spices/:id
    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: 202
    end

    #DELETE /spices/:id
    def destroy
        spice = find_spice
        spice.destroy
        head 204
    end
    
    
    private

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_json_error
        render json: {error: "Spice not found"}, status: 404
    end
end
