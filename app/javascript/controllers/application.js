import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.registerActionOption("confirm", ({ event }) => {
  const message = event.currentTarget.dataset.confirmationMessage

  return window.confirm(message)
})

export { application }

