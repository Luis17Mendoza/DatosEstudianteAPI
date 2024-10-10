class CreateEstudiantes < ActiveRecord::Migration[7.2]
  def change
    create_table :estudiantes do |t|
      t.string :nombres
      t.string :apellidos
      t.string :carrera
      t.string :carnet

      t.timestamps
    end
  end
end
