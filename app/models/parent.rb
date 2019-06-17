class Parent < ApplicationRecord
  has_and_belongs_to_many :children
  has_and_belongs_to_many :mass_messages
  has_many :email_configs, dependent: :delete_all

  after_create :create_default_email_config

  class << self
    def all_current
      includes(:email_configs).joins(children: :years).where("years.current_year = true").uniq
    end

    def all_current_except(ids_to_exclude)
      where.not(id: ids_to_exclude).all_current
    end

    def all_current_with_active_email_except(ids_to_exclude)
      all_current_except(ids_to_exclude).map do |parent|
        ec = parent.email_configs.find { |ec| ec.genre.eql?(SALEABLE_DAYS_GENRE) }
        ec.active? ? ec.email : nil
      end.uniq.compact
    end
  end

  def saleable_days_email_config_query
    email_configs.where(genre: SALEABLE_DAYS_GENRE)
  end

  def saleable_days_email_config_exists?
    saleable_days_email_config_query.exists?
  end

  def saleable_days_email_config
    saleable_days_email_config_query.limit(1).first
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

  def create_default_email_config
    unless saleable_days_email_config_exists?
      email_configs.create(
        email: email,
        active: true,
        genre: SALEABLE_DAYS_GENRE,
        description: "default parent email config"
      )
    end
  end
end
