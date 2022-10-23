// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Hospital {

    struct Record {
        string cid;
        string fileName;
        address doctorId;
        address patientId;
        uint time;
    }

    struct Doctor {
        address docId;
    }

    struct Patient {
        address patId;
        Record[] patientRecords;
    }


    mapping (address => Patient) patients;
    mapping (address => Doctor) doctors;

    // events

    event newPatient(address patId);
    event newDoctor(address docId);
    event newRecord(string cid, address patId, address docId);

    // modifiers (prerequisitos de las funciones)

    // Comprovamos que el sender sea un doctor
    modifier onlyDoctor() {
        require(doctors[msg.sender].docId == msg.sender, "Sender is not a doctor");
        _;
    }

    // Comprovamos que existe el paciente
    modifier patientExists(address patId) {
        require(patients[patId].patId == patId, "Patient does not exist");
        _;
    }

    // Comprovamos que existe el sender, sea doctor o paciente
    modifier senderExists() {
        require(doctors[msg.sender].docId == msg.sender || patients[msg.sender].patId == msg.sender, "Sender does not exist");
        _;
    }

    // Registramos médicos y pacientes

    function addDoctor() public {
        // Comprovamos si existe
        require(doctors[msg.sender].docId != msg.sender, "Doctor already exists");
        doctors[msg.sender].docId = msg.sender;
        // Log the transaction happening inthe blockchain
        emit newDoctor(msg.sender);
    }

    function addPatient(address patId) public onlyDoctor {
        // Comprovamos si existe
        require(patients[patId].patId != patId, "Patient already exists");
        patients[patId].patId = patId;
        emit newPatient(patId);
    }

    function addRecord(string memory cid, string memory fileName, address patId) public onlyDoctor patientExists(patId) {
        Record memory record = Record(cid, fileName, patId, msg.sender, block.timestamp);
        // Añadimos registro al vector de registros del paciente
        patients[patId].patientRecords.push(record);

        emit newRecord(cid, patId, msg.sender);
    }

    // Getters (Usamos view para asegurarnos de no modificar el estado)

    function getRecords(address patId) public view senderExists patientExists(patId) returns (Record[] memory) {
        return patients[patId].patientRecords;
    }

    function getSenderRole() public view returns (string memory) {
        if(doctors[msg.sender].docId == msg.sender) return "doctor";
        else if (patients[msg.sender].patId == msg.sender) return "patient";
        else return "none";
    }
   
}