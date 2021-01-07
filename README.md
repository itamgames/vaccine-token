# Vaccine Certificate Token

## Introduction
Because of the COVID-19, there is a need to globalize vaccine certification.  
But It is difficult to manage data by service because there is no global interface for vaccine certificate.  

We believe **NTT(Non-Transferable Token)** can be a solution to that.  

## Non-Transferable Token
It is NFT. However, you cannot transfer it to anyone, even if you have it.  
Except for that, everything is the same as NFT. That's all.

This contract used the ERC721 interface to support multiple wallet services.

## How to use it
```
@notice Create vaccine information.
@dev this function throws for queries about duplicate vaccine name.
@param _name Name of vaccine
@param _organization Name of organization
@param _organizationAddress Address of organization
@param _organizationPhone Phone of organization
function createVaccine(string _name, string _organization, string _organizationAddress, string _organizationPhone)

@notice Update vaccine information
@dev this function throws for queries about duplicate vaccine name.
@param _name Name of vaccine
@param _organization Name of organization
@param _organizationAddress Address of organization
@param _organizationPhone Phone of organization
function updateVaccine(uint256 _vaccineId, string _name, string _organization, string _organizationAddress, string _organizationPhone)

@notice Enable/disable issue of vaccine certificates.
@param _vaccineId id of vaccine
@param _available Enable/disable issue
function setAvailableVaccine(uint256 _vaccineId, bool _available)

@notice Issue NFT of vaccine certificate.
@param _vaccineId id of vaccine
@param _inoculator owner of this NFT
function issue(uint256 _vaccineId, address _inoculator)

@notice Issue NFT of vaccine certificate with additional data. (optional)
@param _vaccineId id of vaccine
@param _inoculator owner of this NFT
@param _tokenURI URI of NFT information
function issueWithURI(uint256 _vaccineId, address _inoculator, string _tokenURI)

@notice Burn NFT of vaccine certificate.
@param _vaccineId id of vaccine
@param _tokenId_ id of NFT
function burn(uint256 _vaccineId, uint256 _tokenId)

@notice Set vaccine information base uri (optional)
@param _baseURI baseURI
function setBaseURI(string memory _baseURI)

@notice Get vaccine id of NFT
@param _tokenId id of NFT
function getVaccineId(uint256 _tokenId)

@notice Get vaccine name
@param _vaccineId id of vaccine
function getVaccineName(uint256 _vaccineId)

@notice Get vaccine organization
@param _vaccineId id of vaccine
function getVaccineOrganization(uint256 _vaccineId)
```