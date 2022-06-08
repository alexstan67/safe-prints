class FeedbacksController < ApplicationController
  def show
    @feedback = Feedback.find(params[:id])
  end

  def create
    @feedback = Feedback.new(feedback_params)

    @feedback.save
  end

  private

  def feedback_params
    params.require(:feedbacks).permit(:comment, :votes)
  end
end
