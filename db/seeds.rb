# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'

# delete existing records so we can seed new ones in
# order matters here because of dependencies
LedgerEntry.delete_all
JournalEntryItem.delete_all
JournalEntry.delete_all
Account.delete_all
User.delete_all

jdoe = User.create!(
  name: 'John Doe',
  email: 'jdoe@corndog.herokuapp.com',
  role: 'no_access',
  password: '12345'
)

admin = User.create!(
  name: 'Joe Admin',
  email: 'admin@corndog.com',
  role: 'admin',
  password: '12345'
)

manager = User.create!(
  name: 'Joe Manager',
  email: 'manager@corndog.com',
  role: 'manager',
  password: '12345'
)

accountant = User.create!(
  name: 'Joe Accountant',
  email: 'accountant@corndog.com',
  role: 'accountant',
  password: '12345'
)

# Build The Default Accounts
# (all of these done by admin)
PaperTrail.whodunnit = admin.id

cash = Account.create!(
  name: 'Cash',
  code: 101,
  order: 101,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

ar = Account.create!(
  name: 'Accounts Receivable',
  code: 122,
  order: 122,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

supplies = Account.create!(
  name: 'Supplies',
  code: 141,
  order: 141,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

prepaid_insurance = Account.create!(
  name: 'Prepaid Insurance',
  code: 145,
  order: 145,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

# this is not in the specified chart of accounts
#TODO: check if Prepaid Rent should have a different code
prepaid_rent = Account.create!(
  name: 'Prepaid Rent',
  code: 146,
  order: 146,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

office_equipment = Account.create!(
  name: 'Office Equipment',
  code: 181,
  order: 181,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_asset
)

ap = Account.create!(
  name: 'Accounts Payable',
  code: 202,
  order: 202,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :current_liability
)

# this is not in the specified chart of accounts
#TODO: check if Contributed Capital should have a different code
contributed_capital = Account.create!(
  name: 'Contributed Capital',
  code: 330,
  order: 330,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :equity
)

# this is not in the specified chart of accounts
#TODO: check if Unearned Revenue should have a different code
unearned_revenue = Account.create!(
  name: 'Unearned Revenue',
  code: 420,
  order: 420,
  active: false,
  description: 'Enhance your calm :P',
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :revenue
)

# this is not in the specified chart of accounts
#TODO: check if Service Revenue should have a different code
service_revenue = Account.create!(
  name: 'Service Revenue',
  code: 404,
  order: 404,
  active: false,
  description: 'Not Found :P',
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :revenue
)

wages_expense = Account.create!(
  name: 'Wages Expense',
  code: 511,
  order: 511,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

advertising_expense = Account.create!(
  name: 'Advertising Expense',
  code: 512,
  order: 512,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

telephone_expense = Account.create!(
  name: 'Telephone Expense',
  code: 525,
  order: 525,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

utilities_expense = Account.create!(
  name: 'Utilities Expense',
  code: 533,
  order: 533,
  active: false,
  description: Faker::ChuckNorris.fact,
  created_by_id: admin.id,
  initial_balance: 0.0,
  kind: :expense
)

PaperTrail.whodunnit = nil

# Activate Necessary Accounts
# (all of these done by admin)
PaperTrail.whodunnit = admin.id

ActivateAccountJob.perform_now(cash)
ActivateAccountJob.perform_now(ar)
ActivateAccountJob.perform_now(supplies)
ActivateAccountJob.perform_now(prepaid_insurance)
ActivateAccountJob.perform_now(prepaid_rent)
ActivateAccountJob.perform_now(office_equipment)
ActivateAccountJob.perform_now(ap)
ActivateAccountJob.perform_now(contributed_capital)
ActivateAccountJob.perform_now(unearned_revenue)
ActivateAccountJob.perform_now(service_revenue)
ActivateAccountJob.perform_now(wages_expense)
ActivateAccountJob.perform_now(advertising_expense)
ActivateAccountJob.perform_now(telephone_expense)
ActivateAccountJob.perform_now(utilities_expense)

PaperTrail.whodunnit = nil

# Build The Default Journal Entries

je01 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 4),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 10_000.00
    },
    {
      account_id: ar.id,
      normal_side: :left,
      amount: 1_500.00
    },
    {
      account_id: supplies.id,
      normal_side: :left,
      amount: 1_250.00
    },
    {
      account_id: office_equipment.id,
      normal_side: :left,
      amount: 7_500.00
    },
    {
      account_id: contributed_capital.id,
      normal_side: :right,
      amount: 20_250.00
    }
  ]
)

je02 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 4),
  items_attributes: [
    {
      account_id: prepaid_rent.id,
      normal_side: :left,
      amount: 4_500.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 4_500.00
    }
  ]
)

je03 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 4),
  items_attributes: [
    {
      account_id: prepaid_insurance.id,
      normal_side: :left,
      amount: 1_800.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 1_800.00
    }
  ]
)

je04 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 6),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 3_000.00
    },
    {
      account_id: unearned_revenue.id,
      normal_side: :right,
      amount: 3_000.00
    }
  ]
)

je05 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 7),
  items_attributes: [
    {
      account_id: office_equipment.id,
      normal_side: :left,
      amount: 1_800.00
    },
    {
      account_id: ap.id,
      normal_side: :right,
      amount: 1_800.00
    }
  ]
)

je06 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 8),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 800.00
    },
    {
      account_id: ar.id,
      normal_side: :right,
      amount: 800.00
    }
  ]
)

je07 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 11),
  items_attributes: [
    {
      account_id: advertising_expense.id,
      normal_side: :left,
      amount: 120.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 120.00
    }
  ]
)

je08 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 12),
  items_attributes: [
    {
      account_id: ap.id,
      normal_side: :left,
      amount: 800.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 800.00
    }
  ]
)

je09 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 15),
  items_attributes: [
    {
      account_id: ar.id,
      normal_side: :left,
      amount: 2_250.00
    },
    {
      account_id: service_revenue.id,
      normal_side: :right,
      amount: 2_250.00
    }
  ]
)

#NOTE: used wages expense here
# this can also apply to salaries in the chart of accounts
je10 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 15),
  items_attributes: [
    {
      account_id: wages_expense.id,
      normal_side: :left,
      amount: 400.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 400.00
    }
  ]
)

je11 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 15),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 3_175.00
    },
    {
      account_id: service_revenue.id,
      normal_side: :right,
      amount: 3_175.00
    }
  ]
)

je12 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 18),
  items_attributes: [
    {
      account_id: supplies.id,
      normal_side: :left,
      amount: 750.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 750.00
    }
  ]
)

je13 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 22),
  items_attributes: [
    {
      account_id: ar.id,
      normal_side: :left,
      amount: 1_100.00
    },
    {
      account_id: service_revenue.id,
      normal_side: :right,
      amount: 1_100.00
    }
  ]
)

je14 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 22),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 1_850.00
    },
    {
      account_id: service_revenue.id,
      normal_side: :right,
      amount: 1_850.00
    }
  ]
)

je15 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 25),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 1_600.00
    },
    {
      account_id: ar.id,
      normal_side: :right,
      amount: 1_600.00
    }
  ]
)

je16 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 27),
  items_attributes: [
    {
      account_id: wages_expense.id,
      normal_side: :left,
      amount: 400.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 400.00
    }
  ]
)

je17 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 28),
  items_attributes: [
    {
      account_id: telephone_expense.id,
      normal_side: :left,
      amount: 130.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 130.00
    }
  ]
)

je18 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 29),
  items_attributes: [
    {
      account_id: utilities_expense.id,
      normal_side: :left,
      amount: 200.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 200.00
    }
  ]
)

je19 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 29),
  items_attributes: [
    {
      account_id: cash.id,
      normal_side: :left,
      amount: 2_050.00
    },
    {
      account_id: service_revenue.id,
      normal_side: :right,
      amount: 2_050.00
    }
  ]
)

je20 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 29),
  items_attributes: [
    {
      account_id: ar.id,
      normal_side: :left,
      amount: 1_000.00
    },
    {
      account_id: service_revenue.id,
      normal_side: :right,
      amount: 1_000.00
    }
  ]
)

je21 = JournalEntry.create!(
  created_by_id: accountant.id,
  description: Faker::ChuckNorris.fact,
  date: Date.new(2017, 4, 29),
  items_attributes: [
    {
      account_id: wages_expense.id,
      normal_side: :left,
      amount: 4_500.00
    },
    {
      account_id: cash.id,
      normal_side: :right,
      amount: 4_500.00
    }
  ]
)
