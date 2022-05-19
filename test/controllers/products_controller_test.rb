require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "should get index" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    get products_url
    assert_response :success
  end

  test "should get new" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    assert_difference('Product.count') do
      post products_url, params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    patch product_url(@product), params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @title } }
    assert_redirected_to product_url(@product)
  end

  test "can't delete product in cart" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    end

    assert_redirected_to products_url
  end

  test "should destroy product" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "can't get product list when not login" do
    delete logout_url
    get products_url
    assert_redirected_to login_url
  end
end
