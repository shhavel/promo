require 'spec_helper'

describe Promo::OptIn do
  subject do
    described_class.uri = 'http://test-api.com'
    described_class
  end

  it 'stores uri' do
    subject.uri = 'http://my-cool-app.com/api'
    subject.uri.should == 'http://my-cool-app.com/api'
  end

  it 'lists opt-ins' do
    response = [{ "email"=>"test@gmail.com" }]
    RestClient.should_receive(:get).with(subject.uri).and_return(response.to_json)
    subject.list.should == response
  end

  it 'gets opt-in' do
    response = { "opt_in"=>{ "email"=>"test@gmail.com" } }
    RestClient.should_receive(:get).with("#{subject.uri}/4").and_return(response.to_json)
    subject.get(4).should == response
  end

  it 'creates opt-in' do
    response = { "opt_in"=>{ "email"=>"test@gmail.com" } }
    params = { "email"=>"test@gmail.com" }
    RestClient.should_receive(:post).with(subject.uri, params.to_json, content_type: :json, accept: :json).and_return(response.to_json)
    subject.create(params).should == response
  end

  it 'updates opt-in' do
    params = { "channel"=>"sms" }
    RestClient.should_receive(:put).with("#{subject.uri}/4", params.to_json, content_type: :json, accept: :json).and_return("true")
    subject.update(4, params).should be_true
  end

  it 'deletes opt-in' do
    response = { "opt_in"=>{ "email"=>"test@gmail.com" } }
    RestClient.should_receive(:delete).with("#{subject.uri}/4").and_return(response.to_json)
    subject.delete(4).should == response
  end
end
