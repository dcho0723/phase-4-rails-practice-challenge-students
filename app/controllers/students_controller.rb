class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    def index
        render json: Student.all
    end

    def show
        students = find_student
        render json: students
    end
    
    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update 
        student = find_student
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end


    private
    def find_student
        Student.find_by!(id: params[:id])
    end
    
    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def record_not_found(exception)
        render json: { error: exception }, status: :not_found
    end

    def record_invalid(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
