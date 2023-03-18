import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="blink"
export default class extends Controller {
  static values = {
    classToRemove: String
  }

  connect() {
    if (this.hasClassToRemoveValue) {
      requestAnimationFrame(() => {
        this.element.classList.remove(this.classToRemoveValue)
      })
    } else {
      console.error("BlinkController has no classToRemoveValue")
    }
  }
}
