import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "menu"]

  openMenu() {
    this.overlayTarget.classList.remove("hidden")

    if (this.menuTarget.classList.contains("-translate-x-full")) {
        this.menuTarget.classList.remove("-translate-x-full")
    }
  }

  closeMenu() {
    this.overlayTarget.classList.add("hidden")

    if (!this.menuTarget.classList.contains("-translate-x-full")) {
        this.menuTarget.classList.add("-translate-x-full")
    }
  }
}
