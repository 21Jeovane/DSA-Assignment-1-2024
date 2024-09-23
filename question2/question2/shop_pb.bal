import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string SHOP_DESC = "0A0A73686F702E70726F746F120773686F704170701A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128015205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512160A067374617475731806200128095206737461747573221E0A0A50726F64756374534B5512100A03736B751801200128095203736B7522570A0F50726F64756374526573706F6E736512180A076D65737361676518012001280952076D657373616765122A0A0770726F6475637418022001280B32102E73686F704170702E50726F64756374520770726F6475637422430A1350726F647563744C697374526573706F6E7365122C0A0870726F647563747318012003280B32102E73686F704170702E50726F64756374520870726F6475637473223E0A0455736572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512120A04726F6C651803200128095204726F6C6522280A0C55736572526573706F6E736512180A076D65737361676518012001280952076D657373616765224D0A044361727412170A07757365725F69641801200128095206757365724964122C0A0870726F647563747318022003280B32102E73686F704170702E50726F64756374520870726F647563747322380A0B436172745265717565737412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B75224B0A0C43617274526573706F6E736512180A076D65737361676518012001280952076D65737361676512210A046361727418022001280B320D2E73686F704170702E436172745204636172742281010A054F7264657212190A086F726465725F696418012001280952076F72646572496412170A07757365725F69641802200128095206757365724964122C0A0870726F647563747318032003280B32102E73686F704170702E50726F64756374520870726F647563747312160A06737461747573180420012809520673746174757322270A0C4F726465725265717565737412170A07757365725F69641801200128095206757365724964224F0A0D4F72646572526573706F6E736512180A076D65737361676518012001280952076D65737361676512240A056F7264657218022001280B320E2E73686F704170702E4F7264657252056F72646572223B0A114F726465724C697374526573706F6E736512260A066F726465727318012003280B320E2E73686F704170702E4F7264657252066F726465727332C7040A0853686F7070696E6712380A0A41646450726F6475637412102E73686F704170702E50726F647563741A182E73686F704170702E50726F64756374526573706F6E7365123B0A0D55706461746550726F6475637412102E73686F704170702E50726F647563741A182E73686F704170702E50726F64756374526573706F6E736512420A0D52656D6F766550726F6475637412132E73686F704170702E50726F64756374534B551A1C2E73686F704170702E50726F647563744C697374526573706F6E736512430A0D4C697374416C6C4F726465727312162E676F6F676C652E70726F746F6275662E456D7074791A1A2E73686F704170702E4F726465724C697374526573706F6E736512350A0B4372656174655573657273120D2E73686F704170702E557365721A152E73686F704170702E55736572526573706F6E73652801124D0A154C697374417661696C61626C6550726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A1C2E73686F704170702E50726F647563744C697374526573706F6E7365123E0A0D53656172636850726F6475637412132E73686F704170702E50726F64756374534B551A182E73686F704170702E50726F64756374526573706F6E736512380A09416464546F4361727412142E73686F704170702E43617274526571756573741A152E73686F704170702E43617274526573706F6E7365123B0A0A506C6163654F7264657212152E73686F704170702E4F72646572526571756573741A162E73686F704170702E4F72646572526573706F6E7365620670726F746F33";

public isolated client class ShoppingClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOP_DESC);
    }

    isolated remote function AddProduct(Product|ContextProduct req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function AddProductContext(Product|ContextProduct req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateProduct(Product|ContextProduct req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function UpdateProductContext(Product|ContextProduct req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveProduct(ProductSKU|ContextProductSKU req) returns ProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductSKU message;
        if req is ContextProductSKU {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductListResponse>result;
    }

    isolated remote function RemoveProductContext(ProductSKU|ContextProductSKU req) returns ContextProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductSKU message;
        if req is ContextProductSKU {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductListResponse>result, headers: respHeaders};
    }

    isolated remote function ListAllOrders() returns OrderListResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/ListAllOrders", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderListResponse>result;
    }

    isolated remote function ListAllOrdersContext() returns ContextOrderListResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/ListAllOrders", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderListResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableProducts() returns ProductListResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductListResponse>result;
    }

    isolated remote function ListAvailableProductsContext() returns ContextProductListResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductListResponse>result, headers: respHeaders};
    }

    isolated remote function SearchProduct(ProductSKU|ContextProductSKU req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductSKU message;
        if req is ContextProductSKU {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function SearchProductContext(ProductSKU|ContextProductSKU req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductSKU message;
        if req is ContextProductSKU {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function AddToCart(CartRequest|ContextCartRequest req) returns CartResponse|grpc:Error {
        map<string|string[]> headers = {};
        CartRequest message;
        if req is ContextCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartResponse>result;
    }

    isolated remote function AddToCartContext(CartRequest|ContextCartRequest req) returns ContextCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        CartRequest message;
        if req is ContextCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartResponse>result, headers: respHeaders};
    }

    isolated remote function PlaceOrder(OrderRequest|ContextOrderRequest req) returns OrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        OrderRequest message;
        if req is ContextOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderResponse>result;
    }

    isolated remote function PlaceOrderContext(OrderRequest|ContextOrderRequest req) returns ContextOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        OrderRequest message;
        if req is ContextOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopApp.Shopping/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("shopApp.Shopping/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveUserResponse() returns UserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <UserResponse>payload;
        }
    }

    isolated remote function receiveContextUserResponse() returns ContextUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <UserResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public isolated client class ShoppingUserResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUserResponse(UserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUserResponse(ContextUserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingOrderListResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendOrderListResponse(OrderListResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextOrderListResponse(ContextOrderListResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductResponse(ProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductResponse(ContextProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingProductListResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductListResponse(ProductListResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductListResponse(ContextProductListResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingCartResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCartResponse(CartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCartResponse(ContextCartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingOrderResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendOrderResponse(OrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextOrderResponse(ContextOrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextProductSKU record {|
    ProductSKU content;
    map<string|string[]> headers;
|};

public type ContextProductListResponse record {|
    ProductListResponse content;
    map<string|string[]> headers;
|};

public type ContextUserResponse record {|
    UserResponse content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextOrderListResponse record {|
    OrderListResponse content;
    map<string|string[]> headers;
|};

public type ContextOrderRequest record {|
    OrderRequest content;
    map<string|string[]> headers;
|};

public type ContextCartRequest record {|
    CartRequest content;
    map<string|string[]> headers;
|};

public type ContextProduct record {|
    Product content;
    map<string|string[]> headers;
|};

public type ContextProductResponse record {|
    ProductResponse content;
    map<string|string[]> headers;
|};

public type ContextOrderResponse record {|
    OrderResponse content;
    map<string|string[]> headers;
|};

public type ContextCartResponse record {|
    CartResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ProductSKU record {|
    string sku = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type Order record {|
    string order_id = "";
    string user_id = "";
    Product[] products = [];
    string status = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type User record {|
    string id = "";
    string name = "";
    string role = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type OrderRequest record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type OrderListResponse record {|
    Order[] orders = [];
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    string status = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type OrderResponse record {|
    string message = "";
    Order 'order = {};
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type CartResponse record {|
    string message = "";
    Cart cart = {};
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ProductListResponse record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type UserResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type CartRequest record {|
    string user_id = "";
    string sku = "";
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type ProductResponse record {|
    string message = "";
    Product product = {};
|};

@protobuf:Descriptor {value: SHOP_DESC}
public type Cart record {|
    string user_id = "";
    Product[] products = [];
|};

