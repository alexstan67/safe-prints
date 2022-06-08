class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.where(report_id: params[:report_id])
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = current_user
    @feedback.report_id = params[:report_id]

    if @feedback.save
      redirect_to feedback_path(@feedback)
    else
      render "feedbacks/index"
    end
  end

  private

  def feedback_params
    params.require(:feedbacks).permit(:comment, :votes)
  end
end
