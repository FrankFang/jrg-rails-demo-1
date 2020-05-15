require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "Create" do
    it 'should create a user' do
      expect {
        post :create, params: {username: 'frank',
                               password: '123456',
                               password_confirmation: '123456'}
        expect(response.status).to eq 200
      }.to change { User.count }.by(+1)
    end
  end

  describe "Index" do
    it 'should get all users' do
      u = User.create username: 'frank', password: '123456', password_confirmation: '123456'
      get :index
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 1
    end
  end

  describe "Show" do
    it 'should show a user' do
      u = User.create username: 'frank', password: '123456', password_confirmation: '123456'
      get :show, params: {id: u.id}
      body = JSON.parse response.body
      expect(body['resource']['id']).to eq u.id
    end

    it 'should not show a user' do
      get :show, params: {id: 444}
      expect(response.status).to eq 404
    end
  end

  describe "Destroy" do
    it 'should destroy a user' do
      u = User.create username: 'frank', password: '123456', password_confirmation: '123456'
      expect {
        delete :destroy, params: {id: u.id}
        expect(response.status).to eq 200
      }.to change { User.count }.by(-1)
    end

    it 'should not destroy a user' do
      expect {
        delete :destroy, params: {id: 444}
        expect(response.status).to eq 404
      }.to change { User.count }.by(-1)
    end
  end

  describe 'Update' do
    it 'should update a user'  do
      u = User.create username: 'frank', password: '123456', password_confirmation: '123456'
      patch :update, params: {id: u.id, nickname:'Jack'}
      body = JSON.parse response.body
      expect(body['resource']['nickname']).to eq 'Jack'
    end
    it 'should get errors'  do
      u = User.create username: 'frank', password: '123456', password_confirmation: '123456'
      patch :update, params: {id: u.id, nickname:'JackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJackJack'}
      body = JSON.parse response.body
      p body
      expect(body['errors']['nickname']).not_to be_nil
    end
  end
end
