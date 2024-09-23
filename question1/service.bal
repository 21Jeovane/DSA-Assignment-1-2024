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
 // Retrieve a list of all programmes
    resource function get listProgrammes(http:Caller caller, http:Request req) returns error? {
        Programme[] allProgrammes = []; // Create an empty list to hold all programmes.
        foreach var [_, programme] in programmeDB.entries() { // Iterate through all programmes in the database.
            allProgrammes.push(programme); // Add each programme to the list.
        }
        check caller->respond(allProgrammes); // Send the list of programmes as a response to the client.
    }

    // Update an existing programme
    resource function put updateProgramme(http:Caller caller, http:Request req, string programmeCode) returns error? {
        if !programmeDB.hasKey(programmeCode) { // Check if the programme exists in the database.
            check caller->respond("Programme not found."); // Send an error response if the programme does not exist.
        } else {
            json|error jsonPayload = req.getJsonPayload(); // Extract the JSON payload from the request.
            if jsonPayload is json {
                Programme updatedProgramme = check jsonPayload.cloneWithType(Programme); // Convert the JSON to a Programme record.
                programmeDB[programmeCode] = updatedProgramme; // Update the existing programme in the database.
                check caller->respond("Programme updated successfully."); // Send a success response to the client.
            } else {
                check caller->respond("Invalid JSON payload."); // Send an error response if the JSON is invalid.
            }
         // Retrieve the details of a specific programme
    resource function get getProgramme(http:Caller caller, http:Request req, string programmeCode) returns error? {
        Programme? programme = programmeDB[programmeCode]; // Retrieve the programme by its code.
        if programme is Programme {
            check caller->respond(programme); // Send the programme details as a response if it exists.
        } else {
            check caller->respond("Programme not found."); // Send an error response if the programme does not exist.
        }
    }
// Delete a programme's record
        resource function delete deleteProgramme(http:Caller caller, http: Request req, string programmeCode) returns error? { 
           if programmeDB.hasKey(programmeCode) { // Check if the programme exists in the database. 
               Programme = programmeDB.remove(programmeCode); // Remove the programme from the database. 
               check caller->respond("Programme deleted successfully."); // Send a success response to the client.
         } else {
            check caller->respond("Programme not found."); // Send an error response if the programme does not exist.
         }
} }
    }
}
}
    }
}
