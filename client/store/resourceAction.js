import {titleize, tableize} from 'inflection'

export const VIEW_STATE_HIDDEN = 'hidden'
export const VIEW_STATE_SHOWN = 'shown'
export const VIEW_STATE_EXECUTING = 'executing'
export const VIEW_STATE_ERROR = 'error'
export const VIEW_STATE_SUCCESS = 'success'

export const state = {
  viewState: VIEW_STATE_HIDDEN,
  name: '',
  resource: '',
  data: null,
  error: null,
  result: null
}

export const showAction = 'showAction'
export const beginExecuting = 'beginExecuting'
export const executionError = 'executionError'
export const executeSuccessful = 'executeSuccessful'
export const cancelAction = 'cancelAction'
export const saveData = 'saveData'

export const mutations = {
  [showAction](state, {name, resource, data={}}) {
    let _data = {}; Object.assign(_data, data)
    state.viewState = VIEW_STATE_SHOWN
    state.data = _data
    state.name = name
    state.resource = resource
  },
  [beginExecuting](state) {
    state.viewState = VIEW_STATE_EXECUTING
  },
  [executionError](state, error) {
    state.viewState = VIEW_STATE_ERROR
    state.error = error
  },
  [executeSuccessful](state, result) {
    state.viewState = VIEW_STATE_SUCCESS
    state.result = result
  },
  [cancelAction](state) {
    state.viewState = VIEW_STATE_HIDDEN
  },
  [saveData](state, data) {
    state.data = data
  }
}

export const viewStateIsShown = 'viewStateIsShown'
export const viewStateIsExecuting = 'viewStateIsExecuting'
export const viewStateIsError = 'viewStateIsError'
export const viewStateIsSuccess = 'viewStateIsSuccess'
export const viewStateIsHidden = 'viewStateIsHidden'
export const modalShown = 'modalShown'
export const humanActionName = 'humanActionName'
export const actionPath = 'actionPath'

export const getters = {
  [viewStateIsShown]: ({viewState})=> viewState == VIEW_STATE_SHOWN,
  [viewStateIsExecuting]: ({viewState})=> viewState == VIEW_STATE_EXECUTING,
  [viewStateIsError]: ({viewState})=> viewState == VIEW_STATE_ERROR,
  [viewStateIsSuccess]: ({viewState})=> viewState == VIEW_STATE_SUCCESS,
  [viewStateIsHidden]: ({viewState})=> viewState == VIEW_STATE_HIDDEN,
  [modalShown]: ({viewState})=> (viewState != VIEW_STATE_HIDDEN) && (viewState != VIEW_STATE_SUCCESS),
  [humanActionName]: ({name, resource})=> `${titleize(name)} ${titleize(resource)}`,
  [actionPath]: ({name, resource})=> {
    return `${tableize(resource)}/${name}`
  }
}

export const execute = 'execute'

export const actions = {
  [execute]: async ({commit, state})=> {
    commit(beginExecuting)
    try {
      const response = {message: 'Hooray! It (sort-of) Worked!!'}
      commit(executeSuccessful, response)
    } catch(err) {
      commit(executionError, err.toString())
    }
  }
}
