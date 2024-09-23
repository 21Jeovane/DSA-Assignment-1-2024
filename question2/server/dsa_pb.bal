import ballerina/grpc;
import ballerina/protobuf;

public const string DSA_DESC = "0A096473612E70726F746F120873686F7070696E6722B6010A0750726F64756374120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128015205707269636512250A0E73746F636B5F7175616E74697479180520012805520D73746F636B5175616E7469747912100A03736B751806200128095203736B7512160A06737461747573180720012809520673746174757322400A1141646450726F6475637452657175657374122B0A0770726F6475637418012001280B32112E73686F7070696E672E50726F64756374520770726F6475637422330A1241646450726F64756374526573706F6E7365121D0A0A70726F647563745F6964180120012809520970726F64756374496422710A1455706461746550726F6475637452657175657374121D0A0A70726F647563745F6964180120012809520970726F647563744964123A0A0F757064617465645F70726F6475637418022001280B32112E73686F7070696E672E50726F64756374520E7570646174656450726F6475637422310A1555706461746550726F64756374526573706F6E736512180A076D65737361676518012001280952076D65737361676522350A1452656D6F766550726F6475637452657175657374121D0A0A70726F647563745F6964180120012809520970726F64756374496422460A1552656D6F766550726F64756374526573706F6E7365122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F6475637473223C0A0B50726F647563744C697374122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F647563747322280A1453656172636850726F647563745265717565737412100A03736B751801200128095203736B7522670A1553656172636850726F64756374526573706F6E7365122B0A0770726F6475637418012001280B32112E73686F7070696E672E50726F64756374520770726F6475637412210A0C69735F617661696C61626C65180220012808520B6973417661696C61626C65223D0A10416464546F436172745265717565737412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B7522280A0C43617274526573706F6E736512180A076D65737361676518012001280952076D657373616765222C0A11506C6163654F726465725265717565737412170A07757365725F6964180120012809520675736572496422440A0D4F72646572526573706F6E736512190A086F726465725F696418012001280952076F72646572496412180A076D65737361676518022001280952076D65737361676522340A094F726465724C69737412270A066F726465727318012003280B320F2E73686F7070696E672E4F7264657252066F726465727322A3010A054F7264657212190A086F726465725F696418012001280952076F72646572496412170A07757365725F69641802200128095206757365724964122D0A0870726F647563747318032003280B32112E73686F7070696E672E50726F64756374520870726F6475637473121F0A0B746F74616C5F7072696365180420012801520A746F74616C507269636512160A06737461747573180520012809520673746174757322560A0B5573657250726F66696C6512170A07757365725F69641801200128095206757365724964121A0A08757365726E616D651802200128095208757365726E616D6512120A04726F6C651803200128095204726F6C6522300A14557365724372656174696F6E526573706F6E736512180A076D65737361676518012001280952076D65737361676522070A05456D7074793295050A0F53686F7070696E675365727669636512470A0A41646450726F64756374121B2E73686F7070696E672E41646450726F64756374526571756573741A1C2E73686F7070696E672E41646450726F64756374526573706F6E736512500A0D55706461746550726F64756374121E2E73686F7070696E672E55706461746550726F64756374526571756573741A1F2E73686F7070696E672E55706461746550726F64756374526573706F6E736512500A0D52656D6F766550726F64756374121E2E73686F7070696E672E52656D6F766550726F64756374526571756573741A1F2E73686F7070696E672E52656D6F766550726F64756374526573706F6E736512350A0D4C697374416C6C4F7264657273120F2E73686F7070696E672E456D7074791A132E73686F7070696E672E4F726465724C697374123F0A154C697374417661696C61626C6550726F6475637473120F2E73686F7070696E672E456D7074791A152E73686F7070696E672E50726F647563744C69737412500A0D53656172636850726F64756374121E2E73686F7070696E672E53656172636850726F64756374526571756573741A1F2E73686F7070696E672E53656172636850726F64756374526573706F6E7365123F0A09416464546F43617274121A2E73686F7070696E672E416464546F43617274526571756573741A162E73686F7070696E672E43617274526573706F6E736512420A0A506C6163654F72646572121B2E73686F7070696E672E506C6163654F72646572526571756573741A172E73686F7070696E672E4F72646572526573706F6E736512460A0B437265617465557365727312152E73686F7070696E672E5573657250726F66696C651A1E2E73686F7070696E672E557365724372656174696F6E526573706F6E73652801620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, DSA_DESC);
    }

    isolated remote function AddProduct(AddProductRequest|ContextAddProductRequest req) returns AddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddProductResponse>result;
    }

    isolated remote function AddProductContext(AddProductRequest|ContextAddProductRequest req) returns ContextAddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddProductResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateProduct(UpdateProductRequest|ContextUpdateProductRequest req) returns UpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateProductResponse>result;
    }

    isolated remote function UpdateProductContext(UpdateProductRequest|ContextUpdateProductRequest req) returns ContextUpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateProductResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveProduct(RemoveProductRequest|ContextRemoveProductRequest req) returns RemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveProductResponse>result;
    }

    isolated remote function RemoveProductContext(RemoveProductRequest|ContextRemoveProductRequest req) returns ContextRemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveProductResponse>result, headers: respHeaders};
    }

    isolated remote function ListAllOrders(Empty|ContextEmpty req) returns OrderList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/ListAllOrders", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderList>result;
    }

    isolated remote function ListAllOrdersContext(Empty|ContextEmpty req) returns ContextOrderList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/ListAllOrders", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderList>result, headers: respHeaders};
    }

    isolated remote function ListAvailableProducts(Empty|ContextEmpty req) returns ProductList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductList>result;
    }

    isolated remote function ListAvailableProductsContext(Empty|ContextEmpty req) returns ContextProductList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductList>result, headers: respHeaders};
    }

    isolated remote function SearchProduct(SearchProductRequest|ContextSearchProductRequest req) returns SearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchProductResponse>result;
    }

    isolated remote function SearchProductContext(SearchProductRequest|ContextSearchProductRequest req) returns ContextSearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SearchProductResponse>result, headers: respHeaders};
    }

    isolated remote function AddToCart(AddToCartRequest|ContextAddToCartRequest req) returns CartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartResponse>result;
    }

    isolated remote function AddToCartContext(AddToCartRequest|ContextAddToCartRequest req) returns ContextCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartResponse>result, headers: respHeaders};
    }

    isolated remote function PlaceOrder(PlaceOrderRequest|ContextPlaceOrderRequest req) returns OrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderResponse>result;
    }

    isolated remote function PlaceOrderContext(PlaceOrderRequest|ContextPlaceOrderRequest req) returns ContextOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("shopping.ShoppingService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUserProfile(UserProfile message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUserProfile(ContextUserProfile message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveUserCreationResponse() returns UserCreationResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <UserCreationResponse>payload;
        }
    }

    isolated remote function receiveContextUserCreationResponse() returns ContextUserCreationResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <UserCreationResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public isolated client class ShoppingServiceRemoveProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRemoveProductResponse(RemoveProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRemoveProductResponse(ContextRemoveProductResponse response) returns grpc:Error? {
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

public isolated client class ShoppingServiceUserCreationResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUserCreationResponse(UserCreationResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUserCreationResponse(ContextUserCreationResponse response) returns grpc:Error? {
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

public isolated client class ShoppingServiceOrderResponseCaller {
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

public isolated client class ShoppingServiceProductListCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductList(ProductList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductList(ContextProductList response) returns grpc:Error? {
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

public isolated client class ShoppingServiceSearchProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSearchProductResponse(SearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSearchProductResponse(ContextSearchProductResponse response) returns grpc:Error? {
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

public isolated client class ShoppingServiceOrderListCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendOrderList(OrderList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextOrderList(ContextOrderList response) returns grpc:Error? {
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

public isolated client class ShoppingServiceUpdateProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUpdateProductResponse(UpdateProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUpdateProductResponse(ContextUpdateProductResponse response) returns grpc:Error? {
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

public isolated client class ShoppingServiceCartResponseCaller {
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

public isolated client class ShoppingServiceAddProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddProductResponse(AddProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddProductResponse(ContextAddProductResponse response) returns grpc:Error? {
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

public type ContextUserProfileStream record {|
    stream<UserProfile, error?> content;
    map<string|string[]> headers;
|};

public type ContextUserProfile record {|
    UserProfile content;
    map<string|string[]> headers;
|};

public type ContextAddProductResponse record {|
    AddProductResponse content;
    map<string|string[]> headers;
|};

public type ContextOrderResponse record {|
    OrderResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductResponse record {|
    RemoveProductResponse content;
    map<string|string[]> headers;
|};

public type ContextAddProductRequest record {|
    AddProductRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductRequest record {|
    UpdateProductRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchProductRequest record {|
    SearchProductRequest content;
    map<string|string[]> headers;
|};

public type ContextAddToCartRequest record {|
    AddToCartRequest content;
    map<string|string[]> headers;
|};

public type ContextCartResponse record {|
    CartResponse content;
    map<string|string[]> headers;
|};

public type ContextProductList record {|
    ProductList content;
    map<string|string[]> headers;
|};

public type ContextEmpty record {|
    Empty content;
    map<string|string[]> headers;
|};

public type ContextUserCreationResponse record {|
    UserCreationResponse content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderRequest record {|
    PlaceOrderRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductRequest record {|
    RemoveProductRequest content;
    map<string|string[]> headers;
|};

public type ContextOrderList record {|
    OrderList content;
    map<string|string[]> headers;
|};

public type ContextSearchProductResponse record {|
    SearchProductResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductResponse record {|
    UpdateProductResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: DSA_DESC}
public type Order record {|
    string order_id = "";
    string user_id = "";
    Product[] products = [];
    float total_price = 0.0;
    string status = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type UserProfile record {|
    string user_id = "";
    string username = "";
    string role = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type AddProductResponse record {|
    string product_id = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type Product record {|
    string id = "";
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    string status = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type OrderResponse record {|
    string order_id = "";
    string message = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type RemoveProductResponse record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: DSA_DESC}
public type AddProductRequest record {|
    Product product = {};
|};

@protobuf:Descriptor {value: DSA_DESC}
public type UpdateProductRequest record {|
    string product_id = "";
    Product updated_product = {};
|};

@protobuf:Descriptor {value: DSA_DESC}
public type SearchProductRequest record {|
    string sku = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type AddToCartRequest record {|
    string user_id = "";
    string sku = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type CartResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type ProductList record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: DSA_DESC}
public type Empty record {|
|};

@protobuf:Descriptor {value: DSA_DESC}
public type UserCreationResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type PlaceOrderRequest record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type RemoveProductRequest record {|
    string product_id = "";
|};

@protobuf:Descriptor {value: DSA_DESC}
public type SearchProductResponse record {|
    Product product = {};
    boolean is_available = false;
|};

@protobuf:Descriptor {value: DSA_DESC}
public type OrderList record {|
    Order[] orders = [];
|};

@protobuf:Descriptor {value: DSA_DESC}
public type UpdateProductResponse record {|
    string message = "";
|};

