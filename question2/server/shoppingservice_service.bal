import ballerina/grpc;
import ballerina/time;

// Initialize gRPC listener on port 9090
listener grpc:Listener grpcListener = new(9090);

// Define ShoppingService service, mapping gRPC descriptor 
@grpc:Descriptor {value: DSA_DESC}
service "ShoppingService" on grpcListener {

    // Map to store products with SKU as key
     map<Product> products = {};

    // Map to store user profiles with user ID as key
     map<UserProfile> users = {};

    // Map to store shopping carts for each user, where key is user ID and value is an array of SKUs
     map<string[]> carts = {};

    // Array to store all placed orders 
     Order[] orders = [];

    // gRPC remote function to add a new product
    remote function AddProduct(AddProductRequest value) returns AddProductResponse|error {
        // Extract product SKU from request and add product to products map
        string sku = value.product.sku;
        self.products[sku] = value.product;

        // Return SKU as 'product_id' in AddProductResponse
        return {product_id: sku};
    }

    // gRPC remote function to update an existing product
    remote function UpdateProduct(UpdateProductRequest value) returns UpdateProductResponse|error {
        // Check if product with given ID exists
        if (!self.products.hasKey(value.product_id)) {
            return error("Product not found");
        }

        // Update product information in products map
        self.products[value.product_id] = value.updated_product;

        // Return a success message in UpdateProductResponse
        return {message: "Product updated successfully"};
    }

    // gRPC remote function to remove a product by its ID
    remote function RemoveProduct(RemoveProductRequest value) returns RemoveProductResponse|error {
        // Remove product with given ID from products map
        _ = self.products.remove(value.product_id);

        // Return updated product list after removal in RemoveProductResponse
        return {products: self.products.toArray()};
    }

    // gRPC remote function to list all orders
    remote function ListAllOrders(Empty value) returns OrderList|error {
        // Return list of all orders in OrderList response
        return {orders: self.orders};
    }

    // gRPC remote function to list all available products (those with status "available")
    remote function ListAvailableProducts(Empty value) returns ProductList|error {
        // Filter products based onir availability status
        Product[] availableProducts = self.products.toArray().filter(function(Product p) returns boolean {
            return p.status == "available";
        });

        // Return list of available products in ProductList response
        return {products: availableProducts};
    }

    // gRPC remote function to search for a product by its SKU
    remote function SearchProduct(SearchProductRequest value) returns SearchProductResponse|error {
        // If product does not exist, return an empty product and set is_available to false
        if (!self.products.hasKey(value.sku)) {
            return {product: {}, is_available: false};
        }

        // Fetch product and set is_available to true
        Product product = self.products.get(value.sku);
        return {product: product, is_available: true};
    }

    // gRPC remote function to add a product to a user's cart
    remote function AddToCart(AddToCartRequest value) returns CartResponse|error {
        // Check if user exists
        if (!self.users.hasKey(value.user_id)) {
            return {message: "User not found"};
        }

        // Check if product exists
        if (!self.products.hasKey(value.sku)) {
            return {message: "Product not found"};
        }

        // Initialize user's cart if it doesn't exist
        if (!self.carts.hasKey(value.user_id)) {
            self.carts[value.user_id] = [];
        }

        // Add product SKU to user's cart
        self.carts.get(value.user_id).push(value.sku);

        // Return a success message
        return {message: "Product added to cart"};
    }

    // gRPC remote function to place an order for a user
    remote function PlaceOrder(PlaceOrderRequest value) returns OrderResponse|error {
        // Check if user exists
        if (!self.users.hasKey(value.user_id)) {
            return {order_id: "", message: "User not found"};
        }

        // Check if user's cart is empty
        if (!self.carts.hasKey(value.user_id) || self.carts.get(value.user_id).length() == 0) {
            return {order_id: "", message: "Cart is empty"};
        }

        // Create a new order ID by combining user ID with current time
        string orderId = value.user_id + "-" + time:utcNow()[0].toString();

        // Create a new Order object with default values and add it to orders array
        Order newOrder = {order_id: orderId, user_id: value.user_id, products: [], total_price: 0.0, status: "Placed"};
        self.orders.push(newOrder);

        // Clear user's cart after placing order
        _ = self.carts.remove(value.user_id);

        // Return order ID and a success message in OrderResponse
        return {order_id: orderId, message: "Order placed successfully"};
    }

    // gRPC remote function to create multiple users using a stream
    remote function CreateUsers(stream<UserProfile, grpc:Error?> clientStream) returns UserCreationResponse|error {
        int count = 0;

        // Loop through user stream and add each user to users map
        check clientStream.forEach(function(UserProfile user) {
            self.users[user.user_id] = user;
            count += 1;
        });

        // Return a message indicating how many users were created
        return {message: string `Created ${count} users`};
    }
}
