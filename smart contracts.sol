pragma solidity >=0.4.22 <0.7.0;


contract eHealth{
	address patient_address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
	address doctor_address = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
	address receptionist_address = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
	address lab_address = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    
                   //required attributes
	string patient_name;
                   string patient_id;
	string patient_sex;
                   uint patient_age;
                   string doctor_name;
	string appointment_time;
                  string medical_department;
	uint appointment_date;
	string prescription;
	
                   //to access by specific patients
                   mapping (address => Result) results;
    
    
                   struct Result{
       
                   string patientName;
        
                   string patientId;
        
                   string officerId;
        
                   string testResults;
        
                 uint resultDate;
   
                 }
  
	 
	   
		
	//events to be stored in blockchain
	
	event ScheduleAppointment(address adrs, string msg);
	event Consultation(address adrs, string msg);
	event LabResult(address adrs, string msg);
	   
   
                //modifiers for controlling access between the entities
    
	modifier OnlyReceptionist{
		require(msg.sender == receptionist_address);
		_;
	}
    
	modifier OnlyDoctor{
		require(msg.sender == doctor_address);
		_;
	}

	modifier OnlyPatient{
		require(msg.sender == patient_address);
		_;
	}
   
	modifier OnlyLab{
		require(msg.sender == lab_address);
		_;
	}
    
	//scheduling appointments
	
	function addAppointment(string memory pat_name,
			          string memory pat_id,
			          string memory doc_name,
			          string memory med_dept,
			          string memory apt_time,
			          uint apt_date) public OnlyReceptionist{
								
				patient_name = pat_name;
				patient_id = pat_id;
				doctor_name = doc_name;
				medical_department = med_dept;
				appointment_time = apt_time;
				appointment_date = apt_date;
				emit ScheduleAppointment(patient_address, doctor_address, "Appointment created");
													
							}
                             
   
	//consultation
	
               function addPrescription(string memory pat_name,
		                       string memory pat_id,
		                       string memory doc_name,
		                       string memory apt_time,
		                       uint apt_date,
		                       string memory pat_prescription ) public OnlyDoctor{
							
				patient_name = pat_name;
				patient_id = pat_id;
				doctor_name = doc_name;
				appointment_time = apt_time;
				appointment_date = apt_date;
				prescription = pat_prescription;
				emit Consultation(patient_address, "Prescription added");                         
							}

                   //lab notifying the patient their respective test results    
                   function addLabResults( address _address,
 
                                                                 string memory _patientName, 
                                                                 string memory _patientId,
 
                                                                 string memory _officerId,
 
                                                                 string memory _testResults,
  
                                                                 uint _resultDate
 ) public OnlyLab{
                                
                             
                                                          
                                                                        results[_address].patientName = _patientName;
                              
                                                                        results[_address].patientId = _patientId;
                              
                                                                        results[_address].officerId = _officerId;
                              
                                                                        results[_address].testResults = _testResults;
                              
                                                                        results[_address].resultDate = _resultDate;
                              
                              

                                                                        emit LabResult(patient_address, "Results added");
                                
                           
                                                 }

    

                      //patient allowing the result to be displayed to the doctor                        
    
                      function displayResult(address _address) public view returns (string memory, string memory, string memory, string memory, uint){
        
        

                              require(msg.sender == patient_address);
        
                              return (results[_address].patientName,results[_address].patientId,results[_address].officerId,results[_address].testResults,results[_address].resultDate);
        

                                       }
