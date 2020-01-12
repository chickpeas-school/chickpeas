class Parent < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  has_and_belongs_to_many :children
  has_and_belongs_to_many :mass_messages
  has_many :email_configs, dependent: :delete_all

  before_update :downcase_email
  before_create :downcase_email
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

    # run fter successful Google 0auth to find which chickpeas user to log in.
    # if we allow emails outside of the Chickpeas organization to authenticate
    # via 0auth (we would need for Google to verify our app), we can find via
    # a `google_oauth_email` param, in addition (we'd need to add this
    # (see commented line in omniauth migration))
    def from_omniauth(auth)
      parent_from_omniauth = where(email: auth.info.email).first
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
    children.select(&:current_year?)
  end

  def eligible_children
    children.select(&:eligible?)
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

  def downcase_email
    if !self.email.nil? 
      self.email = self.email.downcase
    end
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
