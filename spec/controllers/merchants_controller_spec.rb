require 'rails_helper'

RSpec.describe MerchantsController, type: :controller do

#was trying to use the below lets to assign order to merchant
  #let (:product) do
  #  Product.create(name: "testy", price: 10, merchant_id: 1, description: "hi", photo_url: "www.google.com", inventory: 4)
  #end

  #let (:order_item) do
  #  OrderItem.create(quantity: 1, product_id: product.id, order_id: 1)
  #end

  #let (:order) do
  #  Order.create!(status: "pending", order_time: Time.now, customer_name: "Dillon Gray", customer_email: "dillon@hogwarts.com", customer_address: "Hogwarts Castle, UK", customer_card_last_four: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018 )
  #end
  describe "logged out functions" do

    describe "GET 'new'" do
      it "responds successfully with a 200 status code" do
        get :new
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    describe "POST 'create'" do
      let (:params) do
        {
          merchant:{
            user_name: "Ginny", email: "ginny@hogwarts.com", password: "p", password_confirmation: "p"
          },
        }
      end

        let (:bad_params) do
          {
            merchant:{
              email: "ginny@hogwarts.com", password: "p", password_confirmation: "p"
            }
          }
      end

      it "redirects to merchant show page when merchant is created" do
        post :create, params
        expect(subject).to redirect_to merchant_path(session[:merchant_id])
      end

      it "renders a new page when user already exists or if info doesn't pass validations" do
        post :create, bad_params
        expect(subject).to render_template :new
      end

    end
  end

  describe "Logged in functions" do
    let (:merchant) do
      Merchant.create(user_name: "Hailey", email: "spiderlover222@hogwarts.com", password: "123", password_confirmation: "123")
    end

  before (:each) do
    session[:merchant_id] = merchant.id
  end
    describe "GET #show" do
      it "responds successfully with an HTTP 200 status code" do
        get :show, id: merchant.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the show template" do
        get :show, id: merchant.id
        expect(subject).to render_template :show
      end
    #commenting the below code out because I think learning about FactoryGirl will help
    #  it "assigns the requested order status as @orders" do
    #    #merchant = subcategory = Merchant.create! valid_attributes
    #    @orders = merchant.orders.where(status: "pending")
    #    get :show, :id => merchant.id, :sort => :status
    #    assigns(:sort).should eq("pending")
    #  end
    end
  end
end
#  describe "GET #new" do
#    it "responds successfully with an HTTP 200 status code" do
#      get :new
#      expect(response).to be_success
#      expect(response).to have_http_status(200)
#    end
#    it "renders the new template" do
#      get :new
#      expect(subject).to render_template :new
#    end
#  end
