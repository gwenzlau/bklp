require 'spec_helper'

describe "API Discussions", type: :api do

  before do
    # Create some sample discussions
    @discussions = []

    5.times do
       @discussions << FactoryGirl.create(:discussion)
    end

    # Login a sample user
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end


  context "fetching all discussions" do
    let(:json) { get_json("/api/book/1928/discussions") }

    it "returns success" do
      expect(json[:success]).to be_true
      expect(last_response.status).to eq(200)
    end

    it "has discussions" do
      expect(json[:discussions]).to have(5).items
    end
  end


  context "fetching a single discussion" do
    let(:json) { get_json("/api/book/1928/discussions/#{@discussions.first.id}") }

    it "returns success" do
      expect(json[:success]).to be_true
      expect(last_response.status).to eq(200)
    end

    it "has a quote" do
      expect(json[:discussion][:quote]).to eq(@discussions.first.public_params[:quote])
    end
  end


  context "posting a comment" do
    let(:json) { create_comment }

    it "returns success" do
      expect(json[:success]).to be_true
      expect(last_response.status).to eq(200)
    end

    it "returns the comment" do
      expect(json[:commentary]).to_not be_nil
    end
  end


  context "updating a comment" do
    before do
      @json_comment = create_comment
      patch("/api/book/1928/discussions/#{@discussions.first.id}/commentaries/#{@json_comment[:commentary][:id]}", {
        commentary: { message: "My updated comment" }
      })
    end

    let(:json) { parse_json(last_response.body) }

    it "returns success" do
      expect(last_response.status).to eq(200)
      expect(json[:success]).to be_true
    end

    it "updates the comment" do
      expect(json[:commentary][:message]).to eq("My updated comment")
    end
  end


  context "deleting a comment" do
    before do
      @json_comment = create_comment
      delete("/api/book/1928/discussions/#{@discussions.first.id}/commentaries/#{@json_comment[:commentary][:id]}")
    end

    let(:json) { parse_json(last_response.body) }

    it "returns success" do
      expect(json[:success]).to be_true
      expect(last_response.status).to eq(200)
    end
  end


  # Helpers

  def create_comment
    post_json("/api/book/1928/discussions/#{@discussions.first.id}/commentaries", {
      commentary: { message: "My first comment" }
    })
  end

end
