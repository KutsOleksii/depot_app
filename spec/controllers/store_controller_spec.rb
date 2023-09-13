require "rails_helper"

RSpec.describe StoreController, type: :controller do
  describe 'GET #index' do
    it 'responds with success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end

__END__
class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
  end
end
