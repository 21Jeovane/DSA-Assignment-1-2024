import ballerina/io;
import ballerina/grpc;

// Initialize gRPC client to communicate with ShoppingService
ShoppingServiceClient clientEp = check new ("http://localhost:9090");

// Function to create a user
function createUser() returns grpc:Error|()|error {
    io:println("Enter user details:");
    string userId = io:readln("User ID: ");
    string username = io:readln("User Name: ");
    string role = io:readln("Role (admin/customer): ");

    UserProfile user = {user_id: userId, username: username, role: role};

    CreateUsersStreamingClient clientStream = check clientEp->CreateUsers();
    check clientStream->sendUserProfile(user);
    check clientStream->complete();

    var response = clientStream->receiveUserCreationResponse();

    if response is grpc:Error {
        return response;
    } else if response is UserCreationResponse {
        io:println(response.message);
    } else {
        return error("Unexpected result from server");
    }

    return ();
}

// Function to add a product to the server
function addProduct() returns error? {
    io:println("Enter product details:");
    string sku = io:readln("SKU: ");
    string name = io:readln("Name: ");
    string description = io:readln("Description: ");
    string priceInput = io:readln("Price: ");
    float price = check 'float:fromString(priceInput);
    int stockQuantity = check 'int:fromString(io:readln("Stock Quantity: "));
    string status = io:readln("Status (available/out of stock): ");

    Product product = {id: "", name: name, description: description, price: price, stock_quantity: stockQuantity, sku: sku, status: status};
    AddProductRequest request = {product: product};

    AddProductResponse response = check clientEp->AddProduct(request);
    io:println("Product added successfully! Product ID: ", response.product_id);
}

// Function to list all available products
function listAvailableProducts() returns error? {
    Empty request = {};
    ProductList response = check clientEp->ListAvailableProducts(request);

    io:println("\nAvailable Products:");
    foreach Product product in response.products {
        io:println("SKU: ", product.sku, ", Name: ", product.name, ", Price: ", product.price, ", Stock: ", product.stock_quantity, ", Status: ", product.status);
    }
}

// Function to add a product to a user's cart
function addToCart() returns error? {
    io:println("Enter the following details to add to cart:");
    string userId = io:readln("User ID: ");
    string sku = io:readln("Product SKU: ");

    AddToCartRequest request = {user_id: userId, sku: sku};
    CartResponse response = check clientEp->AddToCart(request);

    io:println(response.message);
}

// Function to place an order for a user
function placeOrder() returns error? {
    string userId = io:readln("Enter User ID to place an order: ");
    PlaceOrderRequest request = {user_id: userId};
    OrderResponse response = check clientEp->PlaceOrder(request);

    if response.order_id == "" {
        io:println("Order could not be placed: ", response.message);
    } else {
        io:println("Order placed successfully! Order ID: ", response.order_id);
    }
}

// Function to remove a product by SKU
function removeProduct() returns error? {
    string productId = io:readln("Enter Product ID to remove: ");
    RemoveProductRequest request = {product_id: productId};
    
    RemoveProductResponse response = check clientEp->RemoveProduct(request);

    io:println("\nUpdated Product List:");
    foreach Product product in response.products {
        io:println("SKU: ", product.sku, ", Name: ", product.name, ", Price: ", product.price, ", Stock: ", product.stock_quantity, ", Status: ", product.status);
    }
}

// Function to search for a product by SKU
function searchProduct() returns error? {
    string sku = io:readln("Enter SKU of product to search: ");
    SearchProductRequest request = {sku: sku};

    SearchProductResponse response = check clientEp->SearchProduct(request);
    Product product = response.product;

    io:println("Product found:");
    io:println("SKU: ", product.sku, ", Name: ", product.name, ", Price: ", product.price, ", Stock: ", product.stock_quantity, ", Status: ", product.status);
    io:println("Availability: ", response.is_available ? "Available" : "Out of Stock");
}

// Function to update product details
function updateProduct() returns error? {
    io:println("Enter updated product details:");
    string productId = io:readln("Product ID: ");
    string name = io:readln("New Name: ");
    string description = io:readln("New Description: ");
    string priceInput = io:readln("New Price: ");
    float price = check 'float:fromString(priceInput);
    int stockQuantity = check 'int:fromString(io:readln("New Stock Quantity: "));
    string status = io:readln("New Status (available/out of stock): ");

    Product updatedProduct = {id: productId, name: name, description: description, price: price, stock_quantity: stockQuantity, sku: "", status: status};
    UpdateProductRequest request = {product_id: productId, updated_product: updatedProduct};

    UpdateProductResponse response = check clientEp->UpdateProduct(request);

    io:println(response.message);
}

// Function to display a menu and take user input
function displayMenu() returns error? {
    while true {
        io:println("\nMenu:");
        io:println("1. Create a User");
        io:println("2. Add a Product");
        io:println("3. List Available Products");
        io:println("4. Add to Cart");
        io:println("5. Place an Order");
        io:println("6. Remove a Product");
        io:println("7. Search for a Product");
        io:println("8. Update a Product");
        io:println("9. Exit");

        string choice = io:readln("Enter your choice (1-9): ");

        match choice {
            "1" => {
                check createUser();
            }
            "2" => {
                check addProduct();
            }
            "3" => {
                check listAvailableProducts();
            }
            "4" => {
                check addToCart();
            }
            "5" => {
                check placeOrder();
            }
            "6" => {
                check removeProduct();
            }
            "7" => {
                check searchProduct();
            }
            "8" => {
                check updateProduct();
            }
            "9" => {
                io:println("Exiting...");
                return;
            }
            _ => {
                io:println("Invalid choice, please try again.");
            }
        }
    }
}

// Main function to start the user interaction
public function main() returns error? {
    io:println("Welcome to the Shopping Service Client!");
    check displayMenu();
}
