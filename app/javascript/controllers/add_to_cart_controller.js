import { Controller } from "@hotwired/stimulus"
import hello_controller from "./hello_controller";

// Connects to data-controller="add-to-cart"
export default class extends Controller {
  static values = {
    selectSize: String,
    stockId: Number,
    quantity: Number,
    product: Object }

  static targets = [
    "selectedSize" ,
    "inputQuantity",
    "addToCartButton"
  ]

  initialize() {
    this.selectSizeValue = ""
    this.quantityValue = 0
  }

  connect() {
    this.selectedSizeTarget.innerHTML = `Selected Size: ${this.selectSizeValue}`
    this.inputQuantityTarget.innerHTML = `Quantity: ${this.quantityValue}`
    this.toggleAddToCartButton()
  }

  toggleAddToCartButton() {
    this.addToCartButtonTarget.disabled = !this.selectSizeValue
  }

  selectSize(event){
    event.preventDefault()
    this.selectSizeValue = event.currentTarget.dataset.size
    this.stockIdValue = event.currentTarget.dataset.stockId
    this.selectedSizeTarget.innerHTML = `Selected Size: ${this.selectSizeValue}`

    this.toggleAddToCartButton()
  }

  quantityInput(event){
    event.preventDefault()
    this.quantityValue = event.currentTarget.value
    this.inputQuantityTarget.innerHTML = `Quantity: ${this.quantityValue}`
  }

  validate(){
    if (!this.selectSizeValue) {
      alert('Please select a size before adding to cart.')
      return false
    }

    if (!this.quantityValue) {
      alert('Please select a quantity before adding to cart.')
      return false
    }

    return true
  }

  addToCart(event){
    event.preventDefault()

    if (!this.validate()) {
      return
    }

    const cartArray = JSON.parse(localStorage.getItem('cart')) || []

    const existingItem = cartArray.find(
        item =>
          item.product.id === this.productValue.id && item.size === this.selectSizeValue
    )

    if (existingItem) {
      existingItem.quantity += this.quantityValue
    } else {
      cartArray.push({
        product: this.productValue,
        size: this.selectSizeValue,
        stockId: this.stockIdValue,
        quantity: this.quantityValue
      })
    }

    localStorage.setItem('cart', JSON.stringify(cartArray))
    console.log("cart", cartArray)
  }
}
