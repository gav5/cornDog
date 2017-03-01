import apiClient from '~plugins/apiClient'
import {titleize, pluralize} from 'inflection'

export const VIEW_STATE_LOADING = 'loading'
export const VIEW_STATE_SUCCESS = 'success'
export const VIEW_STATE_FAILED = 'failed'

export const state = {
  viewState: null,
  data: null,
  selectedId: null,
  error: null,
  name: null,
  title: '',
  query: {},
  newResource: {}
}

export const beginLoading = 'beginLoading'
export const loadingSuccessful = 'loadingSuccessful'
export const loadingFailed = 'loadingFailed'
export const resourceSetup = 'resourceSetup'

export const mutations = {
  [beginLoading](state) {
    state.viewState = VIEW_STATE_LOADING
  },
  [loadingSuccessful](state, data) {
    state.viewState = VIEW_STATE_SUCCESS
    state.data = data
    state.meta = data.meta
  },
  [loadingFailed](state, error) {
    state.viewState = VIEW_STATE_FAILED
    state.error = error
  },
  [resourceSetup](state, {name, id=null, query={}, newResource={}, title=null}) {
    if (id == null) {
      state.data = []
    } else {
      state.data = null
    }
    state.name = name
    state.selectedId = id
    state.query = query
    state.newResource = newResource
    if (title == null) {
      state.title = pluralize(titleize(name))
    } else {
      state.title = title
    }
  }
}

export const isLoading = 'isLoading'
export const isSuccess = 'isSuccess'
export const isFailed = 'isFailed'
export const labelSingular = 'labelSingular'
export const labelPlural = 'labelPlural'

export const getters = {
  [isLoading]: ({viewState})=> viewState == VIEW_STATE_LOADING,
  [isSuccess]: ({viewState})=> viewState == VIEW_STATE_SUCCESS,
  [isFailed]: ({viewState})=> viewState == VIEW_STATE_FAILED,
  [labelSingular]: ({name})=> titleize(name),
  [labelPlural]: ({name})=> pluralize(titleize(name))
}

export const setup = 'setup'
export const fetch = 'fetch'

export const actions = {
  [setup]: async({commit, dispatch}, {name, id=null, query={}, newResource={}, title=null})=> {
    commit(resourceSetup, {name, id, query, newResource, title})
    await dispatch(fetch)
  },
  [fetch]: async ({commit, state})=> {
    commit(beginLoading)
    try {
      if (state.selectedId == null) {
        const data = await apiClient.findAll(state.name, state.query)
        commit(loadingSuccessful, data)
      } else {
        const data = await apiClient.find(state.name, state.selectedId, state.query)
        commit(loadingSuccessful, data)
      }
    } catch(err) {
      commit(loadingFailed, err.toString())
    }
  }
}
