// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16;

contract Certification {
    
    struct Certificate {
        bytes32 id;
        string email;
        string candidateName;
        string orgName;
        string courseName;
        string ipfsHash;
    }
    
    mapping(string => Certificate) public certificates;
    mapping(bytes32 => bool) private ipfs_Hash;
    
    function generateId(string memory _email) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_email));
    }
    
    function generateCertificate(
        string memory _email,
        string memory _candidate_name,
        string memory _org_name,
        string memory _course_name,
        string memory _ipfs_hash 
    ) public returns (bytes32) {
        bytes32 _id = generateId(_email);
        certificates[_email] = Certificate(
            _id,
            _email,
            _candidate_name,
            _org_name,
            _course_name,
            _ipfs_hash
            );
        ipfs_Hash[_id] = true;
        //emit certificateGenerated(_id, _ipfs_hash);
        return _id;
    }
    
    function getId(string memory _email) public view returns (bytes32) {
        return certificates[_email].id;
    }
    
    function isVerified(bytes32 _id) public view returns (bool) {
        if (ipfs_Hash[_id]) {
            return true;
        }
        return false;
    }
    
    
    function getHash(string memory _email) public view returns (string memory) {
        
        return certificates[_email].ipfsHash;
    }

}