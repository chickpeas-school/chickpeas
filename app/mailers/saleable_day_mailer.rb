class SaleableDayMailer < ApplicationMailer
  default from: "web@chickpeas.org",
          reply_to: "web@chickpeas.org"

  def day_purchased
    @day = params[:day]
    @seller = @day.seller
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    parent_emails = @seller.parents.map(&:saleable_days_email).compact

    unless parent_emails.empty?
      send_mail(to: parent_emails, subject: "One of #{@seller.name}'s Days has been Purchased")
    end
  end

  def day_sold
    @day = params[:day]
    @seller = @day.seller
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    parent_emails = @buyer.parents.map(&:saleable_days_email).compact

    unless parent_emails.empty?
      send_mail(to: parent_emails, subject: "A Day has been Sold to #{@buyer.name}")
    end
  end

  # A Saleable Day has a `buyer`
  # The buyer is saying they want to `buy` the day
  def day_posted_for_purchase
    @day = params[:day]
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    buyer_parent_ids = @buyer.parents.map(&:id)
    emails = Parent.all_current_with_active_email_except(buyer_parent_ids)
    send_mail(to: emails, subject: "Someone wants to buy a Chickpeas Day")
  end

  # A Saleable Day has a `seller`
  # The the seller is saying they want to `sell` the day
  def day_put_on_sale
    @day = params[:day]
    @seller = @day.seller
    @url = "https://chickpeas.herokuapp.com/days"

    seller_parent_ids = @seller.parents.map(&:id)
    emails = Parent.all_current_with_active_email_except(seller_parent_ids)
    send_mail(to: emails, subject: "A New Chickpeas Day is Up For Sale")
  end

  private

  def send_mail(opts)
    if !EmailConfig.saleable_days_fallback_active?
      mail(opts)
    else
      mail(opts.merge(to: [EmailConfig.saleable_distribution_fallback_email]))
    end
  end
end
