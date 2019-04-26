pragma ^4.0.24
contract DecentralizedHealth{
  address owner;
  address addressPatient;
  string hashIPFS;
  
  mapping (address => hashIPFS) hashMap;
  mapping (address => bool) doctorPermition;

  modifier isOwner () {
       require(msg.sender == owner);
       _;
   }
   modifier isDoctor(address _addres){
     require(doctorPermition[_addres]);
     _;
   }



  constructor(){
    owner = msg.sender;
  }
  function addToHR(address _addressDoctor, address _addresPatient) public payable isDoctor(_addressDoctor) {
    // el doctor agrega un documento a la historia clinica
    hashMap[_addresPatient] = hashIPFS; // COm crear el hash ipfs
  }


}
