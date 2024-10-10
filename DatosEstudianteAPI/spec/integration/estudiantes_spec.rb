require 'swagger_helper'

RSpec.describe 'Estudiantes API', type: :request do
  path '/estudiantes' do

    get('listar estudiantes') do
      tags 'Estudiantes'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array, items: { '$ref' => '#/components/schemas/estudiante' }

        run_test!
      end
    end

    post('crear estudiante') do
      tags 'Estudiantes'
      consumes 'application/json'
      parameter name: :estudiante, in: :body, schema: {
        type: :object,
        properties: {
          nombres: { type: :string },
          apellidos: { type: :string },
          carrera: { type: :string },
          carnet: { type: :string }
        },
        required: ['nombres', 'apellidos', 'carrera', 'carnet']
      }

      response(201, 'creado') do
        let(:estudiante) { { nombres: 'Juan', apellidos: 'Pérez', carrera: 'Ingeniería Telemática', carnet: '20240001' } }
        run_test!
      end
    end
  end

  path '/estudiantes/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'ID del estudiante'

    get('mostrar estudiante') do
      tags 'Estudiantes'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/estudiante'
        let(:id) { Estudiante.create(nombres: 'Juan', apellidos: 'Pérez', carrera: 'Ingeniería Telemática', carnet: '20240001').id }
        run_test!
      end
    end

    put('actualizar estudiante') do
      tags 'Estudiantes'
      consumes 'application/json'
      parameter name: :estudiante, in: :body, schema: {
        type: :object,
        properties: {
          nombres: { type: :string },
          apellidos: { type: :string },
          carrera: { type: :string },
          carnet: { type: :string }
        }
      }

      response(200, 'actualizado') do
        let(:id) { Estudiante.create(nombres: 'Juan', apellidos: 'Pérez', carrera: 'Ingeniería Telemática', carnet: '20240001').id }
        let(:estudiante) { { nombres: 'Carlos', apellidos: 'López', carrera: 'Arquitectura', carnet: '20240002' } }
        run_test!
      end
    end

    delete('eliminar estudiante') do
      tags 'Estudiantes'
      response(204, 'sin contenido') do
        let(:id) { Estudiante.create(nombres: 'Juan', apellidos: 'Pérez', carrera: 'Ingeniería Telemática', carnet: '20240001').id }
        run_test!
      end
    end
  end
end
