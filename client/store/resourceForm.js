import apiClient from '~plugins/apiClient'
import {cloneDeep, get} from 'lodash'

export const VIEW_STATE_HIDDEN = 'hidden'
export const VIEW_STATE_SHOWN = 'shown'
export const VIEW_STATE_SAVING = 'saving'
export const VIEW_STATE_ERROR = 'error'
export const VIEW_STATE_SUCCESS = 'success'

export const state = {
  viewState: VIEW_STATE_HIDDEN,
  modalData: null,
  error: null,
  resultData: null,
  canSave: true
}

export const showModal = 'showModal'
export const beginSaving = 'beginSaving'
export const saveError = 'saveError'
export const saveSuccessful = 'saveSuccessful'
export const closeModal = 'closeModal'
export const saveData = 'saveData'
export const enableSaving = 'enableSaving'
export const disableSaving = 'disableSaving'

export const mutations = {
  [showModal] (state, data) {
    state.viewState = VIEW_STATE_SHOWN
    state.modalData = cloneDeep(data)
  },
  [beginSaving] (state) {
    state.viewState = VIEW_STATE_SAVING
  },
  [saveError] (state, error) {
    state.viewState = VIEW_STATE_ERROR
    state.error = cloneDeep(error)
  },
  [saveData] (state, data) {
    state.modalData = cloneDeep(data)
  },
  [saveSuccessful] (state, data) {
    state.viewState = VIEW_STATE_SUCCESS
    state.resultData = cloneDeep(data)
  },
  [closeModal] (state) {
    state.viewState = VIEW_STATE_HIDDEN
    state.resultData = null
  },
  [enableSaving] (state) {
    state.canSave = true
  },
  [disableSaving] (state) {
    state.canSave = false
  }
}

export const viewStateIsShown = 'viewStateIsShown'
export const viewStateIsSaving = 'viewStateIsSaving'
export const viewStateIsError = 'viewStateIsError'
export const viewStateIsSuccess = 'viewStateIsSuccess'
export const viewStateIsHidden = 'viewStateIsHidden'
export const modalShown = 'modalShown'

export const getters = {
  [viewStateIsShown]: ({viewState}) => viewState === VIEW_STATE_SHOWN,
  [viewStateIsSaving]: ({viewState}) => viewState === VIEW_STATE_SAVING,
  [viewStateIsError]: ({viewState}) => viewState === VIEW_STATE_ERROR,
  [viewStateIsSuccess]: ({viewState}) => viewState === VIEW_STATE_SUCCESS,
  [viewStateIsHidden]: ({viewState}) => viewState === VIEW_STATE_HIDDEN,
  [modalShown]: ({viewState}) => (viewState !== VIEW_STATE_HIDDEN) && (viewState !== VIEW_STATE_SUCCESS)
}

export const save = 'save'

export const actions = {
  [save]: async ({commit, state}, resourceName) => {
    commit(beginSaving)
    try {
      // const meth = isNull(state.modalData.id)?apiClient.create:apiClient.update
      // const data = await meth(resourceName, state.modalData)
      let data
      if (get(state, 'modalData.id') == null) {
        data = await apiClient.create(resourceName, state.modalData)
      } else {
        data = await apiClient.update(resourceName, state.modalData)
      }
      commit(saveSuccessful, data)
    } catch (err) {
      commit(saveError, err)
    }
  }
}
