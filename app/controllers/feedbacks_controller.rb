class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.where(report_id: params[:report_id])
    @report = Report.find(params[:report_id]) # "23"

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

  def update
    @feedback = Feedback.find(params[:id])
    @feedback.votes+= 1
    @feedback.save
      redirect_to report_feedbacks_path(@feedback.report_id)
  end

  private

  def feedback_params
    params.require(:feedbacks).permit(:comment, :votes)
  end
end
