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

    // Retrieve all programmes
    response = apiClient->get("/listProgrammes"); // Send a GET request to retrieve all programmes.
    if (response is http:Response) {
        json|error jsonPayload = response.getJsonPayload(); // Extract the response payload as JSON.
        if (jsonPayload is json && jsonPayload is json[]) {
            Programme[] programmes = []; // Create an empty list to store the programmes.
            foreach json programmeJson in jsonPayload { // Iterate over each programme in the JSON response.
                Programme programme = check programmeJson.cloneWithType(Programme); // Convert JSON object to Programme record.
                programmes.push(programme); // Add the programme to the list.
            }
            io:println("All Programmes: ", programmes); // Print the list of all programmes.
        } else {
            io:println("Failed to parse JSON payload: ", jsonPayload); // Print an error message if JSON parsing fails.
        }
    } else {
        io:println("Failed to retrieve programmes: ", response.message()); // Print an error message if the request fails.
    }

    // Retrieve a specific programme by programmeCode using query parameters
    string programmeCode = ""; // Define the programme code to search for.
    response = apiClient->get("/getProgramme?programmeCode=" + programmeCode); // Send a GET request to retrieve the specific programme by code.
    if (response is http:Response) {
        json|error jsonPayload = response.getJsonPayload(); // Extract the response payload as JSON.
        if (jsonPayload is json) {
            Programme programme = check jsonPayload.cloneWithType(Programme); // Convert JSON object to Programme record.
            io:println("Programme Details: ", programme); // Print the details of the programme.
        } else {
            io:println("Failed to parse JSON payload: ", jsonPayload.message()); // Print an error message if JSON parsing fails.
        }
    } else {
        io:println("Failed to retrieve programme: ", response.message()); // Print an error message if the request fails.
    }

    // Update an existing programme using query parameters
    newProgramme.nqfLevel = 8; // Update the NQF level of the programme.
    response = apiClient->put("/updateProgramme?programmeCode=" + programmeCode, newProgramme); // Send a PUT request to update the programme details.
    if (response is http:Response) {
        string responseBody = check response.getTextPayload(); // Extract the response payload as text.
        io:println("Update Programme Response: ", responseBody); // Print the response from the server.
    } else {
        io:println("Failed to update programme: ", response.message()); // Print an error message if the request fails.
    }

    //  Delete a programme using query parameters
    response = apiClient->delete("/deleteProgramme?programmeCode=" + programmeCode); // Send a DELETE request to remove the programme.
    if (response is http:Response) {
        string responseBody = check response.getTextPayload(); // Extract the response payload as text.
        io:println("Delete Programme Response: ", responseBody); // Print the response from the server.
    } else {
        io:println("Failed to delete programme: ", response.message()); // Print an error message if the request fails.
    }
 //  Retrieve all programmes due for review
    response = apiClient->get("/programmesDueForReview"); // Send a GET request to retrieve programmes due for review.
    if (response is http:Response) {
        json|error jsonPayload = response.getJsonPayload(); // Extract the response payload as JSON.
        if (jsonPayload is json && jsonPayload is json[]) {
            Programme[] dueProgrammes = []; // Create an empty list to store programmes due for review.
            foreach json programmeJson in jsonPayload { // Iterate over each programme in the JSON response.
                Programme programme = check programmeJson.cloneWithType(Programme); // Convert JSON object to Programme record.
                dueProgrammes.push(programme); // Add the programme to the list of due programmes.
            }
            io:println("Programmes Due for Review: ", dueProgrammes); // Print the list of programmes due for review.
        } else {
            io:println("Failed to parse JSON payload: ", jsonPayload); // Print an error message if JSON parsing fails.
        }
    } else {
        io:println("Failed to retrieve programmes due for review: ", response.message()); // Print an error message if the request fails.
    }

    //  Retrieve all programmes by faculty using query parameters
    string facultyName = "Faculty of Informatics and Computing"; // Define the faculty name to search for.
    response = apiClient->get("/programmesByFaculty?facultyName=" + facultyName); // Send a GET request to retrieve programmes by faculty.
    if (response is http:Response) {
        json|error jsonPayload = response.getJsonPayload(); // Extract the response payload as JSON.
        if (jsonPayload is json && jsonPayload is json[]) {
            Programme[] facultyProgrammes = []; // Create an empty list to store programmes from the specified faculty.
            foreach json programmeJson in jsonPayload { // Iterate over each programme in the JSON response.
                Programme programme = check programmeJson.cloneWithType(Programme); // Convert JSON object to Programme record.
                facultyProgrammes.push(programme); // Add the programme to the list of faculty programmes.
            }
            io:println("Programmes in Faculty: ", facultyProgrammes); // Print the list of programmes in the specified faculty.
        } else {
            io:println("Failed to parse JSON payload: ", jsonPayload); // Print an error message if JSON parsing fails.
        }
    } else {
        io:println("Failed to retrieve programmes by faculty: ", response.message()); // Print an error message if the request fails.
    }
}
