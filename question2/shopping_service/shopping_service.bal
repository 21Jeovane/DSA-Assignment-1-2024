import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: SHOP_DESC}
service "Shopping" on ep {

    remote function AddProduct(Product value) returns ProductResponse|error {
    }

    remote function UpdateProduct(Product value) returns ProductResponse|error {
    }

    remote function RemoveProduct(ProductSKU value) returns ProductListResponse|error {
    }

    remote function ListAllOrders() returns OrderListResponse|error {
    }

    remote function ListAvailableProducts() returns ProductListResponse|error {
    }

    remote function SearchProduct(ProductSKU value) returns ProductResponse|error {
    }

    remote function AddToCart(CartRequest value) returns CartResponse|error {
    }

    remote function PlaceOrder(OrderRequest value) returns OrderResponse|error {
    }

    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns UserResponse|error {
    }
}

