require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let (:test_user) do
    Merchant.create(user_name: "Harry Potter", email: "hp@potter.gov", password: "hedwig", password_confirmation: "hedwig")
  end

  let (:login_params) do
    {
      session_data:{
        email: "hp@potter.gov", password: "hedwig"
      }
    }
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  let

  describe "POST #create" do
    it "redirects to merchant show page" do
      expect(subject).to redirect_to merchant_path(test_user)
    end

    it "renders login template on error" do
      post :create, bad_params1
      expect(subject).to render_template :new
    end

    it "renders new template on error" do
      post :create, bad_params2
      expect(subject).to render_template :new
    end
  end
end
