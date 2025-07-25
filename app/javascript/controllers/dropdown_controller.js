import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle(event) {
    event.stopPropagation()
    const isOpen = this.menuTarget.hasAttribute("data-dropdown-open")
    
    if (isOpen) {
      this.hide()
    } else {
      this.show()
    }
  }

  show() {
    this.menuTarget.setAttribute("data-dropdown-open", "")
    this.element.querySelector("button").setAttribute("aria-expanded", "true")
  }

  hide() {
    this.menuTarget.removeAttribute("data-dropdown-open")
    this.element.querySelector("button").setAttribute("aria-expanded", "false")
  }
}