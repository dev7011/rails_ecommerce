import { Controller } from "@hotwired/stimulus"

const dataResourceId = "data-resource-id";
const dataParent = "data-parent";

let dragUrl = null;
let dataResourceIdValue = null;
let dataParentValue = null;

// Connects to data-controller="drag"
export default class extends Controller {
  connect() {
    console.log("drag")
  }

  dragStart(event) {
    dragUrl = event.currentTarget.dataset.url;
    dataResourceIdValue = event.currentTarget.getAttribute(dataResourceId);
    dataParentValue = event.currentTarget.getAttribute(dataParent);
    event.dataTransfer.effectAllowed = "move";  // war: affectAllowed
    event.currentTarget.classList.add("opacity-60")
  }

  drop(event) {
    event.preventDefault();

    const dropTarget = event.currentTarget
    const parent = dropTarget.closest("tbody")
    const draggedRow = parent?.querySelector(`[${dataResourceId}="${dataResourceIdValue}"]`)

    if (!parent || !draggedRow || draggedRow === dropTarget) {
      return
    }

    const isMovingDown = Boolean(
      draggedRow.compareDocumentPosition(dropTarget) & Node.DOCUMENT_POSITION_FOLLOWING
    )
    const insertionPoint = isMovingDown ? dropTarget.nextSibling : dropTarget

    parent.insertBefore(draggedRow, insertionPoint)
    this.persistPosition(draggedRow, parent)
  }

  dragOver(event) {
    event.preventDefault();
    event.dataTransfer.dropEffect = "move"
  }

  async persistPosition(row, parent) {
    if (!dragUrl) {
      return
    }

    const rows = Array.from(parent.querySelectorAll(`[${dataResourceId}]`))
    const position = rows.indexOf(row) + 1
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content

    try {
      const response = await fetch(dragUrl, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json"
        },
        body: JSON.stringify({ position })
      })

      if (!response.ok) {
        console.error("Could not persist product order")
      }
    } catch (error) {
      console.error("Drag reorder failed", error)
    }
  }

  dragEnd(event) {
    event.currentTarget.classList.remove("opacity-60")
    dragUrl = null
    dataResourceIdValue = null
    dataParentValue = null
  }
}
