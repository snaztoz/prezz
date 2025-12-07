import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]
  static values = { timeoutDuration: Number }

  submit() {
    if (!this.hasTimeoutDurationValue) {
      this.formTarget.requestSubmit()
    } else {
      this.submitDebounced()
    }
  }

  submitDebounced() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }

    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, this.timeoutDurationValue)
  }
}
