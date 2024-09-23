//import ballerina/io;
import ballerina/http; // Import the HTTP module to create an HTTP service.

type Course record {
    string courseCode;   // The code identifying the course.
    string courseName;   // The name of the course.
    int nqfLevel;        // The NQF (National Qualifications Framework) level of the course.
};

type Programme record {
    string programmeCode;    // The code identifying the programme.
    int nqfLevel;            // The NQF level of the programme.
    string facultyName;      // The faculty offering the programme.
    string departmentName;   // The department offering the programme.
    string programmeTitle;   // The title of the programme.
    string registrationDate; // The date the programme was registered.
    Course[] courses;        // A list of courses included in the programme.
};

// In-memory database simulation
map<Programme> programmeDB = {}; // A map to store Programmes with their codes as keys.

service /programmes on new http:Listener(8080) {
    // Add a new programme
    resource function post addProgramme(http:Caller caller, http:Request req) returns error? {
        json|error jsonPayload = req.getJsonPayload(); // Extract the JSON payload from the request.
        if (jsonPayload is json) {
            Programme newProgramme = check jsonPayload.cloneWithType(Programme); // Convert the JSON to a Programme record.
            programmeDB[newProgramme.programmeCode] = newProgramme; // Add the new programme to the in-memory database.
            check caller->respond("Programme added successfully."); // Send a success response to the client.
        } else {
            check caller->respond("Invalid JSON payload."); // Send an error response if the JSON is invalid.
        }
    }
}