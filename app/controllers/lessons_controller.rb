class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]
  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  helper_method :current_course
  def current_course
    @current_course ||= current_lesson.section.course
  end

  def require_authorized_for_current_lesson
    if current_user.enrolled_in?(current_lesson.section.course) != true
      redirect_to course_path(current_course), alert: 'You must be enrolled to view this lesson!'
    end
  end

end