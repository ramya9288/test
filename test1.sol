pragma solidity^0.4.0;
contract token{
    function totalSupply()public constant returns(uint256);
    function transfer(address to,uint256 amount)public  returns(bool);
    function mint(uint256 value)public  returns(bool);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint256) {}
    
    
}

contract standardtoken is token{
    address owner;
    mapping(address=>uint256)balances;
    mapping(address => mapping(address => uint256)) allow;
    uint256 public totalSupply;
    
    modifier onlyowner(){
        require(owner==msg.sender);
        _;
    }
    
    function totalSupply()public   onlyowner() constant returns(uint256){
       return balances[owner];
   }
  
   function transfer(address to,uint256 amount)public  onlyowner() returns(bool){
     require(balances[owner]>=amount&& amount>0);
      balances[owner]-=amount;
      balances[to]+=amount;
    
      
   }
   function mint(uint256 value)public onlyowner() returns(bool){
     
      
       
       balances[owner]+=value;
      
   }
   
    function transferFrom(address _from,address _to,uint256 _value) returns(bool success) {
         require(balances[_from] >= _value && _value > 0 && allow[_from][_to] >= _value);
             
             balances[_from] -= _value;
             balances[_to] += _value;
             allow[_from][_to] -= _value;
             return true;
         }
     
     
    
     function approve(address _spender,uint256 _value) returns(bool success){
         allow[owner][_spender] = _value;
         return true;
     }
     
     
     function allowance(address _owner,address _spender) constant returns(uint256){
         return allow[_owner][_spender];
     }
     

}
contract testcoin is standardtoken{
    string public name;
    uint256 public totalSupply;
    uint256 public decimals;
    string public symbol;
    
    function testcoin(){
        owner=msg.sender;
        totalSupply=5000;
        balances[owner]=totalSupply;
        symbol="mnw token";
        name="mnw";
        decimals=18;
        
    }
    
}
    
