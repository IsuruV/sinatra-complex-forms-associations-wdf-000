class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect to "owners/#{@owner.id}"
  end


  get '/owners/:id/edit' do
    @pet = Pet.all.first
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  patch '/owners/:id/edit' do

    @owner = Owner.find_by_id(params[:id])
    @owner.name = params[:owner][:name]
    @owner.save

    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end


  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    if !params["owner"].empty?
    @owner.update(params["owner"])
    end
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end

end
