class SaleableDayMailer < ApplicationMailer
  default from: "web@chickpeas.org",
          reply_to: "web@chickpeas.org"

  def day_purchased
    @day = params[:day]
    @seller = @day.seller
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    parents = @seller.parents

    parents.map do |parent|
      parent.saleable_days_email
    end.compact

    if !EmailConfig.saleable_days_active?
      parent_emails = [EmailConfig.saleable_distribution_email]
    end

    unless parent_emails.empty?
      mail(to: parent_emails, subject: "One of #{@seller.name}'s Days has been Purchased")
    end
  end

  def day_put_on_sale
    @day = params[:day]
    @seller = @day.seller
    @url = "https://chickpeas.herokuapp.com/days"

    mail(to: EmailConfig.saleable_distribution_email, subject: "A New Day is Up For Sale")
  end
end
