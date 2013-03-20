require_relative '../minitest_helper'

describe ChromeData::Division do
  it 'returns a proper request name' do
    ChromeData::Division.request_name.must_equal 'getDivisions'
  end

  describe '.find_all_by_year' do
    before do
      ChromeData.configure do |c|
        c.account_number = '123456'
        c.account_secret = '1111111111111111'
      end

      VCR.use_cassette('wsdl') do
        VCR.use_cassette('divisions/2013') do
          @divisions = ChromeData::Division.find_all_by_year(2013)
        end
      end
    end

    it 'returns array of Division objects' do
      @divisions.first.must_be_instance_of ChromeData::Division
      @divisions.size.must_equal 38
    end

    it 'sets ID on Division objects' do
      @divisions.first.id.must_equal '1'
    end

    it 'sets name on Division objects' do
      @divisions.first.name.must_equal 'Acura'
    end
  end
end