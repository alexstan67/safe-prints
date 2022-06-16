class FeedbacksController < ApplicationController
  def index
    @report = Report.find(params[:report_id]) # "23"
    @feedbacks = Feedback.where(report_id: params[:report_id])
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = current_user
    @feedback.report_id = params[:report_id]
    @feedback.user = current_user
    @feedback.votes = 0
    if @feedback.save!
      redirect_to report_feedbacks_path(@feedback.report)
    end
  end

  def update
    @feedback = Feedback.find(params[:id])
    @feedback.votes = @feedback.votes.to_i + 1
    @feedback.save
      redirect_to report_feedbacks_path(@feedback.report_id)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment, :votes)
  end
end
