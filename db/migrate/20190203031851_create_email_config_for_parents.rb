class CreateEmailConfigForParents < ActiveRecord::Migration[5.2]
  def up
    # Add Saleable Days Email Config
    parents = Parent.all

    parents.each do |parent|
      parent.email_configs.create(
        email: parent.email,
        active: true,
        genre: SALEABLE_DAYS_GENRE,
        description: "default parent email config"
      )
    end
  end

  def down
    parents = Parent.all

    parents.each do |parent|
      parent.email_configs.where(genre: SALEABLE_DAYS_GENRE).each { |conf| conf.destroy }
    end
  end
end
