// SPDX-License-Identifier: none
pragma solidity ^0.7.4;

import "@openzeppelin/contracts/token/ERC721/ERC721Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Certification is ERC721Pausable, Ownable {
    struct Vaccine {
        string name;
        string organization;
        string organizationAddress;
        string organizationPhone;
        bool available;
    }

    // vaccine id => Vaccine
    mapping(uint256 => Vaccine) vaccineInfos;

    // vaccine name => bool
    mapping(string => bool) private existsVaccines;

    // token id => vaccine id 
    mapping(uint256 => uint256) private tokenVaccines;

    uint256 private vaccineCounter = 1;
    uint256 private tokenCounter = 1;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function createVaccine(string calldata _name, string calldata _organization, string calldata _organizationAddress, string calldata _organizationPhone) onlyOwner public {
        require(existsVaccines[_name] == false, "exists vaccine name.");
        vaccineInfos[vaccineCounter] = Vaccine({
            name: _name,
            organization: _organization,
            organizationAddress: _organizationAddress,
            organizationPhone: _organizationPhone,
            available: true
        });
        existsVaccines[_name] = true;
        
        vaccineCounter++;
        emit SetVaccine(vaccineCounter, _name, _organization, _organizationAddress, _organizationPhone);
    }

    function updateVaccine(uint256 _vaccineId, string calldata _name, string calldata _organization, string calldata _organizationAddress, string calldata _organizationPhone) onlyOwner public {
        Vaccine memory vaccineInfo = vaccineInfos[_vaccineId];
        _requireVaccine(vaccineInfo);

        if (!compareString(vaccineInfo.name, _name)) {
            require(existsVaccines[_name] == false, "exists vaccine name.");
        }

        vaccineInfos[_vaccineId] = Vaccine({
            name: _name,
            organization: _organization,
            organizationAddress: _organizationAddress,
            organizationPhone: _organizationPhone,
            available: vaccineInfo.available
        });
        
        emit SetVaccine(vaccineCounter, _name, _organization, _organizationAddress, _organizationPhone);
    }

    function setAvailableVaccine(uint256 _vaccineId, bool _available) onlyOwner public {
        Vaccine memory vaccineInfo = vaccineInfos[_vaccineId];
        _requireVaccine(vaccineInfo);

        vaccineInfos[_vaccineId].available = _available;
        emit SetAvailableVaccine(_vaccineId, _available);
    }

    function issue(uint256 _vaccineId, address _inoculator) onlyOwner public {
        Vaccine memory vaccineInfo = vaccineInfos[_vaccineId];
        _requireVaccine(vaccineInfo);
        require(vaccineInfo.available, "unavailable vaccine.");

        _mint(_inoculator, tokenCounter);
        tokenVaccines[tokenCounter] = _vaccineId;

        tokenCounter++;
    }

    function issueWithURI(uint256 _vaccineId, address _inoculator, string calldata _tokenURI) onlyOwner public {
        issue(_vaccineId, _inoculator);
        _setTokenURI(tokenCounter - 1, _tokenURI);
    }

    function burn(uint256 _vaccineId, uint256 _tokenId) onlyOwner public {
        Vaccine memory vaccineInfo = vaccineInfos[_vaccineId];
        _requireVaccine(vaccineInfo);

        _burn(_tokenId);
        tokenVaccines[tokenCounter] = 0;
    }

    function setBaseURI(string memory _baseURI) onlyOwner public {
        _setBaseURI(_baseURI);
    }

    function getVaccineId(uint256 _tokenId) public view returns(uint256) {
        uint256 vaccineId = tokenVaccines[_tokenId];
        require(vaccineId != 0, "invalid token id");
        return vaccineId;
    }

    function getVaccineName(uint256 _vaccineId) public view returns(string memory) {
        Vaccine memory vaccineInfo = vaccineInfos[_vaccineId];
        _requireVaccine(vaccineInfo);
        return vaccineInfo.name;
    }

    function getVaccineOrganization(uint256 _vaccineId) public view returns(string memory) {
        Vaccine memory vaccineInfo = vaccineInfos[_vaccineId];
        _requireVaccine(vaccineInfo);
        return vaccineInfo.organization;
    }

    function _requireVaccine(Vaccine memory vaccineInfo) internal pure {
        require(bytes(vaccineInfo.name).length != 0 && bytes(vaccineInfo.organization).length != 0, "invalid vaccine id");
    }

    function compareString(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

    event SetVaccine(uint256 vaccineId, string name, string organization, string organizationAddress, string organizationPhone);
    event SetAvailableVaccine(uint256 vaccineId, bool available);
}