export default (apiClient)=> {
  apiClient.define('journal_entry', {
    created_by: {
      jsonApi: 'hasOne',
      type: 'users'
    },
    created_at: ''
  }, {
    readOnly: ['created_at', 'created_by'],
    include: 'created_by'
  })
}
