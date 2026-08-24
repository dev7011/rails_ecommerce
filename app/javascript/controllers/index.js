import { application } from "controllers/application"

import HelloController from "controllers/hello_controller"
application.register("hello", HelloController)

import DragController from "controllers/drag_controller"
application.register("drag", DragController)

import DashboardController from "controllers/dashboard_controller"
application.register("dashboard", DashboardController)

import AddToCartController from "controllers/add_to_cart_controller"
application.register("add-to-cart", AddToCartController)