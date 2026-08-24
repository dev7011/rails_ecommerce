import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {

  static targets = ["cartList"]
  static values = {
    total: Number
  }

  initialize() {
    this.renderCart()

  }

  connect() {

  }

  renderCartItem(item) {
    let totalPrice = item.product.price * item.quantity

    return`
        <div 
            id = "cart-item-${item.product.id}-${item.size}"           
            class="cart-item grid grid-cols-2 
            bg-gray-200 justify-between 
            my-2  
            items-center" >    
          <div class='cart-content flex gap-2'> 
              <p>${item.product.name}</p> 
              <p>${item.size}</p> 
              <p></p>${totalPrice}</p> 
          </div>
          
          <div class='cart-actions flex gap-2 justify-end items-center'> 
                <label for="quantity-${item.product.id}-${item.size}" class="mr-2">Price: ${item.product.price} € x quantity </label>
                <input type="number" 
                    min="0"
                    value="${item.quantity}"
                    class = "quantity-input border border-gray-200 w-24 shadow-md bg-white px-2"                    
                    data-action="change->cart#updateQuantity" 
                    data-product-id="${item.product.id}" 
                    data-size="${item.size}">
                    
                </input>
                    
                <button 
                    class = "btn bg-red-500 text-white px-2 py-1 rounded"
                    data-action="click->cart#removeFromCart:confirm"
                    data-product-id="${item.product.id}"             
                    data-size="${item.size}"
                    data-confirmation-message="Are you sure?"                               
                    >Remove</button>                    
          </div>  
        </div>  
    `
  }

  calculateTotal(cartArray, isHtml = true) {
    const total = cartArray.reduce((total, item) => total + (item.product.price * item.quantity), 0)
    const subtotal = (total * 1.19).toFixed(2) // Assuming 19% VAT
    const tax = (subtotal - total).toFixed(2) // Assuming 19% VAT

    if (isHtml) {
      return `
        <div class = "cart-total my-5 w-full flex justify-end font-bold">
          <div class = "cart-total px-5 w-[350px] justify-end bg-gray-300 shadow-md rounded-lg ">
            <div class = "flex justify-between py-2">
                <p>Total:</p>
                <p>${total} €</p>
            </div> 
            <div class = "flex justify-between py-2">
                <p>Mwst:</p>
                <p>${tax} €</p>
            </div>  
            <div class = "flex justify-between py-2">
                <p>Gesamt:</p>
                <p>${subtotal} €</p>
            </div>     
          </div>  
        </div>  
      `
    }

    return total
  }

  getParamsFromEvent(event) {
    const { productId, size }  = event.currentTarget.dataset

    return { productId, size }
  }

  findCartItemIndex(cartArray, productId, size) {
    return cartArray.findIndex(item => item.product.id == productId && item.size == size)
  }

  getCartArray() {
    return JSON.parse(localStorage.getItem("cart")) || []
  }

  removeFromCart(event) {
    event.preventDefault

    const { productId, size } = this.getParamsFromEvent(event)

    let cartArray =  this.getCartArray()

    cartArray = cartArray.filter(item => !(item.product.id == productId && item.size == size))

    localStorage.setItem("cart", JSON.stringify(cartArray))

    this.renderCart()
  }


  updateQuantity(event) {
    event.preventDefault

    const { productId, size } = this.getParamsFromEvent(event)
    let cartArray = this.getCartArray()
    const itemIndex = this.findCartItemIndex(cartArray, productId, size)

    cartArray[itemIndex].quantity = parseInt(event.currentTarget.value)
    localStorage.setItem("cart", JSON.stringify(cartArray))

    this.renderCart()

  }

  clearCart() {
    localStorage.removeItem("cart")
    this.renderCart()
  }

  renderCart() {
    const cartArray = this.getCartArray()

    this.cartListTarget.innerHTML = cartArray
      .map( item =>  this.renderCartItem(item))
      .join("")

    if (cartArray.length === 0) {
      this.cartListTarget.innerHTML = "<p class='text-center my-5'>Your cart is empty.</p>"
      return
    }

    this.cartListTarget.insertAdjacentHTML("beforeend", this.calculateTotal(cartArray))
  }

  checkout() {
    const cartArray = this.getCartArray()
    const payload = {
      authenticity_token: "",
      cart: cartArray
    }


    if (cartArray.length === 0) {
      alert("Your cart is empty. Please add items to your cart before checking out.")
      return
    }

    const response = fetch("/checkouts", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ cart: cartArray })
    })

    response
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }

        return response.json()

      })
      .then(body => {
          window.location.href = body.url })
      .catch(err => {
        console.error("Error during checkout:", err)
        alert("An error occurred during checkout. Please try again.")
      })
  }

}
