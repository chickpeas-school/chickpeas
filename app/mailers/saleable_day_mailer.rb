class SaleableDayMailer < ApplicationMailer
  default from: "web@chickpeas.org",
          reply_to: "web@chickpeas.org"

  def day_purchased
    @day = params[:day]
    @seller = @day.seller
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    # email to both buyers and sellers
    transaction_emails = transaction_notification_emails(@buyer, @seller)
    unless parent_emails.empty?
      send_mail(to: transaction_emails, subject: "One of #{@seller.name}'s Days has been Purchased")
    end
  end

  def day_sold
    @day = params[:day]
    @seller = @day.seller
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    # email to both buyers and sellers
    transaction_emails = transaction_notification_emails(@buyer, @seller)

    unless parent_emails.empty?
      send_mail(to: transaction_emails, subject: "A Day has been Sold to #{@buyer.name}")
    end
  end

  # A Saleable Day has a `buyer`
  # The buyer is saying they want to `buy` the day
  def day_posted_for_purchase
    @day = params[:day]
    @buyer = @day.buyer
    @url = "https://chickpeas.herokuapp.com/days"

    buyer_parent_ids = @buyer.parents.map(&:id)
    # email to all parents other than those posting
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
    # email to all parents other than those posting
    emails = Parent.all_current_with_active_email_except(seller_parent_ids)
    send_mail(to: emails, subject: "A New Chickpeas Day is Up For Sale")
  end

  private

  # i guess this will deliver email to a testing email if one is set,
  # or will send to the list of emails passed, if testing email is not active
  def send_mail(opts)
    if EmailConfig.saleable_days_fallback_active?
      return mail(opts.merge(to: [EmailConfig.saleable_distribution_fallback_email]))
    end
    mail(opts)
  end

  def transaction_notification_emails(buyer, seller)
    seller_emails = seller.parents.map(&:saleable_days_email).compact
    buyer_emails = buyer.parents.map(&:saleable_days_email).compact
    seller_emails.concat(buyer_emails)
  end
end
