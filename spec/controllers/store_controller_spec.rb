require "rails_helper"

RSpec.describe StoreController, type: :controller do
  describe 'GET #index' do
    it 'responds with success' do
      get :index
      expect(response).to have_http_status(:success)
      puts "response.body = #{response.body}"
      expect(response.body).to have_selector('nav a', minimum: 4)
      expect(response.body).to have_selector('main ul li', count: 3)
      expect(response.body).to have_selector('h2', 'Programming Ruby 1.9')
      expect(response.body).to have_selector('div', /\$[,\d]+\.\d\d/)
    end
  end
end

__END__
class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select '​nav a'​, minimum: 4
    assert_select 'main ul li', 3
    assert_select '​h2'​, 'Programming Ruby 1.9'​
    assert_select '​div'​, /​\$[,\d]+\.\d\d/​
  end
end
