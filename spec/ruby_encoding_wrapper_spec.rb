require 'spec_helper'
require 'fakeweb'
require 'ruby_encoding_wrapper'

describe RubyEncodingWrapper do

  before do
    @sut = RubyEncodingWrapper.new
    FakeWeb.allow_net_connect = false
  end

  describe "#request_encoding" do
    describe "the server returns a 404 error code" do
      before do
        FakeWeb.register_uri(:post, "http://manage.encoding.com/", :body => '', :status => ['404', 'Not Found'])
        @result = @sut.request_encoding { |query| }
      end

      it 'should return nil' do
        @result.should be_nil
      end
      
      it 'should have "Not Found" as an error' do
        @sut.last_error.should == 'Not Found'
      end

    end

    describe "the server returns a 500 error code" do
      before do
        FakeWeb.register_uri(:post, "http://manage.encoding.com/", :body => '', :status => ['500', 'Server Error'])
        @result = @sut.request_encoding { |query| }
      end

      it 'should return nil' do
        @result.should be_nil
      end

      it 'should have "Server Error" as an error' do
        @sut.last_error.should == 'Server Error'
      end
      
    end

  end
  
end
