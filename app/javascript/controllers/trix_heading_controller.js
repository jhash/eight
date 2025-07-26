import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("trix-initialize", this.setupHeadingDropdown.bind(this))
  }

  setupHeadingDropdown(event) {
    const editor = event.target.editor
    const toolbar = event.target.toolbarElement
    
    if (!toolbar) return
    
    const boldButton = toolbar.querySelector(".trix-button--icon-bold")
    if (!boldButton) return
    
    const buttonGroup = boldButton.parentElement
    
    const headingDropdown = document.createElement("select")
    headingDropdown.className = "trix-button trix-button--text"
    headingDropdown.style.width = "auto"
    headingDropdown.style.height = "100%"
    headingDropdown.style.padding = "0 0.5em"
    headingDropdown.style.border = "none"
    headingDropdown.style.borderLeft = "1px solid #ccc"
    headingDropdown.style.background = "transparent"
    headingDropdown.style.cursor = "pointer"
    
    headingDropdown.innerHTML = `
      <option value="p">Paragraph</option>
      <option value="h1">Heading 1</option>
      <option value="h2">Heading 2</option>
      <option value="h3">Heading 3</option>
      <option value="h4">Heading 4</option>
      <option value="h5">Heading 5</option>
      <option value="h6">Heading 6</option>
    `
    
    buttonGroup.insertBefore(headingDropdown, buttonGroup.firstChild)
    
    headingDropdown.addEventListener("change", (e) => {
      const tag = e.target.value
      this.applyHeading(editor, tag)
    })
    
    editor.element.addEventListener("trix-selection-change", () => {
      this.updateHeadingDropdown(editor, headingDropdown)
    })
    
    this.updateHeadingDropdown(editor, headingDropdown)
  }

  applyHeading(editor, tag) {
    const range = editor.getSelectedRange()
    const text = editor.getDocument().getStringAtRange(range)
    
    if (tag === "p") {
      editor.activateAttribute("heading1", false)
      editor.deactivateAttribute("heading1")
      
      const html = `<p>${text}</p>`
      editor.setSelectedRange(range)
      editor.deleteInDirection("backward")
      editor.insertHTML(html)
    } else {
      const level = tag.replace("h", "")
      editor.activateAttribute(`heading${level}`)
    }
  }

  updateHeadingDropdown(editor, dropdown) {
    const attributes = editor.getSelectedAttributes()
    
    let selectedTag = "p"
    for (let i = 1; i <= 6; i++) {
      if (attributes[`heading${i}`]) {
        selectedTag = `h${i}`
        break
      }
    }
    
    dropdown.value = selectedTag
  }
}