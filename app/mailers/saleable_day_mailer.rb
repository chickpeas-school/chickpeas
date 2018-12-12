class SaleableDayMailer < ApplicationMailer
  default from: "web@chickpeas.org",
          reply_to: "web@chickpeas.org"

  def day_purchased
    @day = params[:day]
    @seller = @day.seller
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    parent_emails = @seller.parents.map(&:email)

    unless parent_emails.empty?
      mail(to: parent_emails, subject: "One of #{@seller.name}'s Days has been Purchased")
    end
  end

  def day_put_on_sale
    @day = params[:day]
    @seller = @day.seller
    @url = "https://chickpeas.herokuapp.com/days"

    mail(to: SALE_DISTRIBUTION_EMAIL, subject: "A New Day is Up For Sale")
  end
end
