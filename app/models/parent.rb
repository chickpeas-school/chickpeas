class Parent < ApplicationRecord
  has_and_belongs_to_many :children
  has_and_belongs_to_many :mass_messages
  has_many :email_configs

  class << self
    def all_current
      includes(:email_configs).joins(children: :years).where("years.current_year = true").uniq
    end

    def all_current_except(ids_to_exclude)
      where.not(id: ids_to_exclude).all_current
    end

    def all_current_with_active_email_except(ids_to_exclude)
      all_current_except(ids_to_exclude).map do |parent|
        parent.email_configs.find { |ec| ec.genre.eql?(SALEABLE_DAYS_GENRE) }&.email
      end.uniq.compact
    end
  end

  def saleable_days_email_config
    email_configs.where(genre: SALEABLE_DAYS_GENRE).limit(1).first
  end

  def saleable_days_email
    saleable_days_email_config.active? ? saleable_days_email_config.email : nil
  end

  def admin?
    is_admin
  end

  def current_year?
    current_children.present?
  end

  def current_children
    children.select { |c| c.current_year? }
  end

  def formatted_phone_number
    Phoner::Phone.parse(phone_number, country_code: "1").to_s
  end

  def has_seller?(seller)
    has_child?(seller)
  end

  def has_buyer?(buyer)
    has_child?(buyer)
  end

  def has_buyer_or_seller?(day)
    has_seller?(day.seller) || has_buyer?(day.buyer)
  end

  private

  def has_child?(child)
    children.include?(child)
  end
end
