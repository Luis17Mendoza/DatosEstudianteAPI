require 'rails_helper'

RSpec.describe Estudiante, type: :model do
  it { should validate_presence_of(:nombres) }
  it { should validate_length_of(:nombres).is_at_most(50) }
  it { should validate_presence_of(:apellidos) }
  it { should validate_length_of(:apellidos).is_at_most(50) }
  it { should validate_presence_of(:carrera) }
  it { should validate_presence_of(:carnet) }
  it { should validate_length_of(:carnet).is_equal_to(12) }

  # Creamos un registro antes de ejecutar la prueba de unicidad
  before(:each) do
    Estudiante.create!(
      nombres: "Juan",
      apellidos: "Pérez",
      carrera: "Ingeniería",
      carnet: "12345678" # El carnet con el que probaremos la unicidad
    )
  end

  it "valida la unicidad del carnet" do
    # Intentamos crear un nuevo estudiante con el mismo carnet
    estudiante_nuevo = Estudiante.new(
      nombres: "Carlos",
      apellidos: "López",
      carrera: "Arquitectura",
      carnet: "12345678" # Mismo carnet, debe fallar
    )

    # Verificamos que no sea válido debido a la duplicación del carnet
    expect(estudiante_nuevo).to_not be_valid
    expect(estudiante_nuevo.errors[:carnet]).to include("has already been taken")
  end
end
