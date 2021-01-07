# 백신 인증서 토큰

## 개요
코로나바이러스감염증-19로 인해 백신 인증서의 글로벌화가 필요합니다.  
하지만 인증서에 대한 글로벌 인터페이스가 존재하지 않기 때문에 서비스 별 데이터 관리가 어렵습니다.  

아이텀게임즈는 NTT(Non-Transferable Token)이 이에 대한 해결책이 될 수 있다고 믿습니다.  

## Non-Transferable Token
NFT이지만 자신이 소유하고 있음에도 다른 유저에게 전송할 수 없습니다.  
그 외에는 모든 것이 NFT와 동일합니다. 그게 전부입니다.  

이 컨트랙트는 여러 NFT 지갑 서비스를 지원하기 위하여 ERC721 인터페이스를 사용하였습니다.  

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