require 'rails_helper'
require "swagger_helper"

RSpec.describe "Categories", type: :request do
	path '/api/categories' do
		post 'Creates a category' do
			tags 'Categories'
			consumes 'application/json'
			parameter name: :category, in: :body, schema: {
				type: :object,
				properties: {
					category_name: { type: :string }
				},
			required: ['category_name']
			}

			response '200', 'category created' do
				let(:category) { { category_name: "Abc" } }
				run_test! 
			end


			response '200', 'invalid request' do
				let(:category) { { category_name: '' } }
				run_test!
				# examples 'application/json' => { error: ["Category name can't be blank"] }
			end
		end
	end

	path '/api/categories/{id}' do
		get 'Retrieves a category' do
			tags 'Categories'
			produces 'application/json', 'application/xml'
			parameter name: :id, in: :path, type: :string, schema:{ 
				type: :object,
				properties: {
					id: { type: :integer },
					category_name: { type: :string }
				},
				required: ['id', 'category_name']
			}

			response '200', 'category found' do  
			  let(:id) { create(:category).id }
			  run_test!
			end

			response '200', 'category not found' do
				let(:id) { 999 } # Assuming a category with ID 999 does not exist
				run_test!
			end
		end
	end

	path '/api/categories' do
		get 'Retrieves all category' do
			tags 'Categories'
			produces 'application/json'

			response '200', 'categories found' do  
			  let(:category) { create(:category) }
			  run_test!
			end

			response '200', 'categories not found' do  
			  let(:category) { Category.destroy_all }
			  run_test!
			end
		end
	end
end
