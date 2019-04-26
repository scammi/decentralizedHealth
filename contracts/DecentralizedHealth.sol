pragma solidity ^0.5.7;

/**
 * @title DecentralizedHealth
 * @dev see https://github.com/marxMT/decentralizedHealth
*/
contract DecentralizedHealth{
  // hospital que crea el contrato
  address owner;

  mapping (address => bool) patientPermition;
  //Mapping de paciente address a IPFS hash
  mapping (address => string) hashPatient;
  //Mapping de doctor address a su permiso
  mapping (address => bool) doctorPermition;

  modifier isOwner () {
       require(msg.sender == owner);
       _;
   }

  constructor() public {
    owner = msg.sender;
  }

  /**
  *@dev sudo agrega a mapping paciente con su hash determinado
  *@param _addresPatient direccion del paciente
  *@param hashIPFS apunta a data en IPFS
  */
   function addPatient(address _addresPatient, string memory hashIPFS) public isOwner(){
      require(!patientPermition[_addresPatient], "Pasciente Existente");

      hashPatient[_addresPatient]=hashIPFS;

  }

  /**
  *@dev se agrega doctor y se otorga permiso para modificar HR
  *@param _addressDoctor
  */
  function  addDoctor(address _addressDoctor) public isOwner(){
      require(!(doctorPermition[_addressDoctor]));

      doctorPermition[_addressDoctor] = true;
  }
  /**
  *@dev sudo agrega a mapping paciente con su hash determinado
  *@param _addresPatient direccion del paciente
  *@param hashIPFS apunta a data en IPFS
  */
  function addToHR(address _addresPatient, string memory _hashIPFS ) public  {
    // el doctor agrega un documento a la historia clinica
    require(doctorPermition[msg.sender]);
    hashPatient[_addresPatient] = _hashIPFS; // Como crear el hash ipfs?
  }

  /**
  *@dev Returns IPFS hash 
  */
  function viewHR() public view returns(string memory result){
    require(patientPermition[msg.sender] || doctorPermition[msg.sender], "El

    paciente ingresado no existe");

    result= hashPatient[msg.sender];
  }


}
