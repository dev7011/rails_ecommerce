import { application } from "controllers/application"

// Import và đăng ký thủ công từng controller
import HelloController from "controllers/hello_controller"
application.register("hello", HelloController)

// Nếu bạn có drag_controller, hãy đăng ký thêm dòng dưới:
// import DragController from "controllers/drag_controller"
// application.register("drag", DragController)