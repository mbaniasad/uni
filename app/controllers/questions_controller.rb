class QuestionsController < ApplicationController
  layout 'flatly'
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.course_id = params[:course_id] if params[:course_id]
    @prev_question = @question.course.questions.last
    if @prev_question.present?
      @question.index_number = @prev_question.index_number + 0.01
      @question.chapter = @prev_question.chapter
    else
      @question.index_number = 0
      @question.chapter = 1
    end
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to course_path(@question.course, chapter: @question.chapter), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to course_path(@question.course, chapter: @question.chapter), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    tmpcourse = @question.course
    tmpChapter = @question.chapter
    @question.destroy
    respond_to do |format|
      format.html { redirect_to course_path(tmpcourse, chapter: tmpChapter), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :answer, :course_id, :chapter, :index_number)
    end

    def latest_index_number
      Question.last.index_number
    end
end
