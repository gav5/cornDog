require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'accepts the default fabricator' do
    account = Fabricate.build(:account)
    expect(account).to be_valid
  end

  context '#name' do
    it 'cannot be an empty string' do
      account = Fabricate.build(:account, name: '')
      expect(account).not_to be_valid
    end

    it 'cannot be nil' do
      account = Fabricate.build(:account, name: nil)
      expect(account).not_to be_valid
    end

    it 'cannot be only whitespace' do
      account = Fabricate.build(:account, name: ' ')
      expect(account).not_to be_valid
    end
  end

  context '#code' do
    it 'cannot be zero' do
      account = Fabricate.build(:account, code: 0)
      expect(account).not_to be_valid
    end

    it 'cannot be negative' do
      account = Fabricate.build(:account, code: -1)
      expect(account).not_to be_valid
    end

    it 'cannot be nil' do
      account = Fabricate.build(:account, code: nil)
      expect(account).not_to be_valid
    end
  end

  context '#order' do
    it 'cannot be zero' do
      account = Fabricate.build(:account, order: 0)
      expect(account).not_to be_valid
    end

    it 'cannot be negative' do
      account = Fabricate.build(:account, order: -1)
      expect(account).not_to be_valid
    end

    it 'cannot be nil' do
      account = Fabricate.build(:account, order: nil)
      expect(account).not_to be_valid
    end
  end

  context '#active' do
    it 'cannot be nil' do
      account = Fabricate.build(:account, active: nil)
      expect(account).not_to be_valid
    end

    it 'can be true' do
      account = Fabricate.build(:account, active: true)
      expect(account).to be_valid
    end

    it 'can be false' do
      account = Fabricate.build(:account, active: false)
      expect(account).to be_valid
    end
  end

  context '#description' do
    it 'can be nil' do
      account = Fabricate.build(:account, description: nil)
      expect(account).to be_valid
    end

    it 'can be 255 characters long' do
      account = Fabricate.build(:account, description: ?! * 255)
      expect(account).to be_valid
    end

    it 'cannot be more than 255 characters long' do
      account = Fabricate.build(:account, description: ?! * 256)
      expect(account).not_to be_valid
    end
  end
end