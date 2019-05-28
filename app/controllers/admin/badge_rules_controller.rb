class Admin::BadgeRulesController < Admin::BaseController
  before_action :find_badge

  def new
    @badge.build_rule(badge_rule_params)
  end

  def create
    @badge.build_rule(badge_rule_params)

    if @badge.rule.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @badge.rule.update(badge_rule_params)
      redirect_to admin_badges_path
    else
      render :edit
    end
  end

  def destroy
    @badge.rule.destroy
    redirect_to admin_badges_path
  end

  private

  def find_badge
    @badge = Badge.find(params[:badge_id])
  end

  def badge_rule_params
    params.require(:badge_rule).permit(:badge_id, :resource_id, :resource_type, :first_try, :level, :rule_type, :unique)
  end
end
