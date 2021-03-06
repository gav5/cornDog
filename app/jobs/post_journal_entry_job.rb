class PostJournalEntryJob < ApplicationJob
  def perform(journal_entry, user, description)
    journal_entry.transaction do
      # build the attributes for the new ledger entries
      # there should be one for each item in the entry
      items = journal_entry.items.includes(account: :ledger_entries)
      ledger_entries = items.map do |item|
        {
          journal_entry_item_id: item.id,
          balance: item.account.ledger_balance + item.left_normalized_amount,
          description: description,
          user: user
        }
      end
      # create the ledger entries as specified
      # (done this way so it happens in one query)
      # (it's far more efficient this way)
      LedgerEntry.create!(ledger_entries)

      # mark the journal entry as "posted"
      journal_entry.paper_trail_event = 'post'
      journal_entry.update!(state: :posted)
    end
  end
end
