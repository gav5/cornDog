RSpec.describe User, type: :model do
  let!(:user){Fabricate :user}; subject{user}

  context 'default fabricator' do
    it{is_expected.to be_valid}
  end

  context '#name' do
    context 'when an empty string' do
      before{user.name = ''}
      it{is_expected.to be_invalid}
    end
  end

  context '#email' do
    context 'when a username-style input' do
      before{user.email = 'gav5'}
      it{is_expected.to be_invalid}
    end

    context 'when an invalid domain' do
      before{user.email = 'gav5@corndog'}
      it{is_expected.to be_invalid}
    end
  end

  context '#accounts_created' do
    subject{user.accounts_created}
    let!(:accounts){Fabricate.times 4, :account, created_by: user}
    it{is_expected.to contain_exactly(*accounts)}
  end

  context '#journal_entries_created' do
    subject{user.journal_entries_created}
    let!(:journal_entries){Fabricate.times 4, :journal_entry, created_by: user}
    it{is_expected.to contain_exactly(*journal_entries)}
  end
end
