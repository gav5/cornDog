export const state = {
  shown: true
}

export const mutations = {
  hide (state) {
    state.shown = false
  },
  show (state) {
    state.shown = true
  },
  toggle (state) {
    state.shown = !state.shown
  }
}
