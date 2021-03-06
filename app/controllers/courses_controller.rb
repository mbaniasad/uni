class CoursesController < ApplicationController
  layout 'flatly'
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    chapterno = params[:chapter]|| "all"
    chapterno = chapterno.to_i
    @chapter_questions = (chapterno == 0 ? @course.questions : @course.questions.where("chapter >= #{chapterno} and chapter < #{chapterno+1}").order(index_number: :desc))
    @chapternumbers = @course.questions.collect(&:chapter).uniq
    answerd = params[:answerd]|| "all"
    if answerd == "false"
      @chapter_questions = @chapter_questions.where("answer is null or answer=''")
    elsif answerd == "true"
      @chapter_questions = @chapter_questions.where("answer is not null or answer<>''")
    end

    @chapter_questions.order(index_number: :desc)


  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_chapter_numbers
    @course = Course.find(params[:course_id])
    chapterno = params[:chapter]|| "all"
    chapterno = chapterno.to_i
    @chapternumbers = @course.questions.collect(&:chapter).uniq

    @chapter_questions = (chapterno == 0 ? @course.questions : @course.questions.where("chapter >= #{chapterno} and chapter < #{chapterno.to_i+1}").order(index_number: :asc))
    questionsCounter = 1
    @chapter_questions.each do |question|
      question.update_attribute(:index_number, questionsCounter)
      puts question.index_number, questionsCounter
      questionsCounter+=1
    end
    render :show
  end
  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name)
    end
end
