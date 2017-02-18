export const VIEW_STATE_HIDDEN = 'hidden'
export const VIEW_STATE_SHOWN = 'shown'
export const VIEW_STATE_SAVING = 'saving'
export const VIEW_STATE_ERROR = 'error'
// export const VIEW_STATE_SUCCESS = 'success'

export const state = {
  viewState: VIEW_STATE_HIDDEN,
  modalData: null,
  error: null,
  resultData: null
}

export const showModal = 'showModal'
export const beginSaving = 'beginSaving'
export const saveError = 'saveError'
// export const saveSuccessful = 'saveSuccessful'
export const closeModal = 'closeModal'

export const mutations = {
  [showModal](state, data={}) {
    state.viewState = VIEW_STATE_SHOWN
    state.modalData = data
  },
  [beginSaving](state) {
    state.viewState = VIEW_STATE_SAVING
  },
  [saveError](state, error) {
    state.viewState = VIEW_STATE_ERROR
    state.error = error
  },
  // [saveSuccessful](state, data={}) {
  //   state.viewState = VIEW_STATE_SUCCESS
  //   state.resultData = data
  // },
  [closeModal](state, data={}) {
    state.viewState = VIEW_STATE_HIDDEN
    state.resultData = data
  }
}

export const viewStateIsShown = 'viewStateIsShown'
export const viewStateIsSaving = 'viewStateIsSaving'
export const viewStateIsError = 'viewStateIsError'
// export const viewStateIsSuccess = 'viewStateIsSuccess'
export const viewStateIsHidden = 'viewStateIsHidden'
export const modalShown = 'modalShown'

export const getters = {
  [viewStateIsShown]: ({viewState})=> viewState == VIEW_STATE_SHOWN,
  [viewStateIsSaving]: ({viewState})=> viewState == VIEW_STATE_SAVING,
  [viewStateIsError]: ({viewState})=> viewState == VIEW_STATE_ERROR,
  // [viewStateIsSuccess]: ({viewState})=> viewState == VIEW_STATE_SUCCESS,
  [viewStateIsHidden]: ({viewState})=> viewState == VIEW_STATE_HIDDEN,
  [modalShown]: ({viewState})=> viewState != VIEW_STATE_HIDDEN
}