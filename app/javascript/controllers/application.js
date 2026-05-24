import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import DropDragController from "./drag_controller"
application.register("drag", DropDragController)


export { application }

