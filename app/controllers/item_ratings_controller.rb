class ItemRatingsController < ApplicationController
  expose(:assignment) { RatingAssignment.find(params[:assignment_id]) }
  expose(:scenario) { assignment.scenarios.find(params[:scenario_id]) }
  expose(:item) { scenario.items.find(params[:item_id]) }
  expose(:item_rating) do
    if params[:id] 
      item.ratings.where(:rater_id => current_user.id).find(params[:id])
    else
      item_rating_params = { :rater => current_user }
      item_rating_params.reverse_merge!(params[:item_rating]) if params[:item_rating]
      item.ratings.build(item_rating_params)
    end
  end

  before_filter :check_assigned_to_current_user!

  # New: Implicit render of item_ratings/new.html.haml
  
  # Edit: Implicit render of item_ratings/edit.html.haml

  def create
    save_and_redirect
  end

  def update
    item_rating.attributes = params[:item_rating]
    save_and_redirect
  end

  protected
  def save_and_redirect
    if item_rating.save
      redirect_to assignment_scenario_path(params[:assignment_id], params[:scenario_id])
    else
      flash[:error] = "Could not save the rating."  
      redirect_to assignment_scenario_path(params[:assignment_id], params[:scenario_id], :current_item_id => item)
    end
  end
end
