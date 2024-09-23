import ballerina/http; // Import the HTTP module to enable HTTP client operations.
import ballerina/io;   // Import the IO module to handle input and output operations.

type Course record {
    string courseCode; // The code identifying the course.
    string courseName; // The name of the course.
    int nqfLevel;      // The NQF (National Qualifications Framework) level of the course.
};

type Programme record {
    string programmeCode;    // The code identifying the programme.
    int nqfLevel;            // The NQF level of the programme.
    string facultyName;      // The faculty offering the programme.
    string departmentName;   // The department offering the programme.
    string programmeTitle;   // The title of the programme.
    string registrationDate; // The date when the programme was registered.
    Course[] courses;        // A list of courses included in the programme.
};

http:Client apiClient = check new("http://localhost:8080/programmes"); // Create an HTTP client to interact with the API at localhost:8080/programmes.

public function main() returns error? {
    // Add a new programme
    Programme newProgramme = {
        programmeCode: "07BCMS", // Unique code for the programme.
        nqfLevel: 7,              // NQF level of the programme.
        facultyName: "Faculty of Informatics and Computing", // Faculty offering the programme.
        departmentName: "Computer Science Department", // Department offering the programme.
        programmeTitle: "Bachelor of Computer Science", // Title of the programme.
        registrationDate: "2020-01-10", // Date when the programme was registered.
        courses: [                // List of courses included in the programme.
            { courseCode: "ICG611S", courseName: "Introduction to Computing", nqfLevel: 5 }, // Course details.
            { courseCode: "DSA611S", courseName: "Data Structures and Algorithms", nqfLevel: 6 } // Course details.
        ]
    };

     // Add a new programme
    Programme _ = {
        programmeCode: "07BECO", // Unique code for the programme.
        nqfLevel: 7,              // NQF level of the programme.
        facultyName: "FACULTY OF COMMERCE, HUMAN SCIENCE AND EDUCATION", // Faculty offering the programme.
        departmentName: "DEPARTMENT OF ECONOMICS, ACCOUNTING AND FINANCE", // Department offering the programme.
        programmeTitle: "Bachelor of Econmics", // Title of the programme.
        registrationDate: "2019-01-10", // Date when the programme was registered.
        courses: [                // List of courses included in the programme.
            { courseCode: "CUS411S", courseName: "Computer User Skills", nqfLevel: 5 }, // Course details.
            { courseCode: "SFE611S", courseName: "Statistics for Economists 2A", nqfLevel: 6 } // Course details.
        ]
    };
    

     // Add a new programme
    Programme _ = {
        programmeCode: "07BBIA", // Unique code for the programme.
        nqfLevel: 7,              // NQF level of the programme.
        facultyName: "FACULTY OF COMMERCE, HUMAN SCIENCE AND EDUCATION", // Faculty offering the programme.
        departmentName: "DEPARTMENT OF GOVERNANCE AND MANAGEMENT SCIENCES", // Department offering the programme.
        programmeTitle: "BACHELOR OF BUSINESS AND INFORMATION ADMINISTRATION", // Title of the programme.
        registrationDate: "2026-01-10", // Date when the programme was registered.
        courses: [                // List of courses included in the programme.
            { courseCode: "BMS411S", courseName: "Basic Mathematics", nqfLevel: 5 }, // Course details.
            { courseCode: "AMM621S", courseName: "Administrative Management 2B", nqfLevel: 6 } // Course details.
        ]
    };

    http:Response|http:ClientError response = apiClient->post("/addProgramme", newProgramme); // Send a POST request to add the new programme.
    if (response is http:Response) {
        string responseBody = check response.getTextPayload(); // Extract the response payload as text.
        io:println("Add Programme Response: ", responseBody); // Print the response from the server.
    } else {
        io:println("Failed to add programme: ", response.message()); // Print an error message if the request fails.
    }
}

}


// Retrieve all programmes
response apiClient->get("/listProgrammes"); // Send a GET request to retrieve all programmes.
if (response is http: Response) {
json error jsonPayload = response.getJsonPayload(); // Extract the response payload as JSON.
if (jsonPayload is json && jsonPayload is json[]) {
    Programme[] programmes = []; // Create an empty list to store the programmes.
    foreach json programmeJson in jsonPayload { // Iterate over each programme in the JSON response.
    programme check programmeJson.cloneWithType (Programme); // Convert JSON object to Programme record. programmes.push(programme); // Add the programme to the list.

}

I io:println("All Programmes: ", programmes); // Print the list of all programmes.

} else {
io:println("Failed to parse JSON payload: ", jsonPayload); // Print an error message if JSON parsing fails.
}

} else {
io:println("Failed to retrieve programmes: ", response.message()); // Print an error message if the request fails.

}
