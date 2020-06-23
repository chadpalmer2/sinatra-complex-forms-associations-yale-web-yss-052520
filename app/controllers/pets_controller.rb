require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params[:pet_name])

    if params[:owner][:name] != ""
      new_owner = Owner.create(name: params[:owner][:name])
    else
      new_owner = Owner.find(params[:pet][:owner_ids].first)
    end

    @pet.update(owner: new_owner)

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])

    @pet.update(name: params[:pet_name])

    if params[:owner][:name] != ""
      new_owner = Owner.create(name: params[:owner][:name])
    else
      new_owner = Owner.find(params[:pet][:owner_ids].first)
    end

    @pet.update(owner: new_owner)

    redirect to "pets/#{@pet.id}"
  end
end