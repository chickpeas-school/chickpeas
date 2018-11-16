class AddNameToChildren < ActiveRecord::Migration[5.2]
  def up
    convert_to_name = lambda do |klass|
      klass.all.each do |el|
        el.name = "#{el.first_name} #{el.last_name}"
      end
    end

    add_column :children, :name, :string

    convert_to_name.call(Child)

    add_column :parents, :name, :string

    convert_to_name.call(Parent)

    remove_column :children, :first_name
    remove_column :children, :last_name
    remove_column :parents, :first_name
    remove_column :parents, :last_name
  end

  def down
    remove_column :children, :name
    remove_column :parents, :name

    add_column :children, :first_name, :string
    add_column :children, :last_name, :string
    add_column :parents, :first_name, :string
    add_column :parents, :last_name, :string
  end
end
