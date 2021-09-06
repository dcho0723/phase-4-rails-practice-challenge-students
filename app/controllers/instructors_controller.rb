class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    def index
        render json: Instructor.all
    end

    def show
        instructor = find_instructor
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor = find_instructor
        instructor.destroy
        head :no_content
    end
    private
    def find_instructor
        Instructor.find_by!(id: params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def record_not_found(exception)
        render json: {error: exception}, status: :not_found
    end
    def record_invalid(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
