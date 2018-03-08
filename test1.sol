pragma solidity^0.4.0;
contract token{
    function totalSupply()public constant returns(uint256);
    function transfer(address to,uint256 amount)public  returns(bool);
    function mint(uint256 value)public  ;
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint256) {}
    
    
}

contract standardtoken is token{
    
     string public name;
    uint256 public totalSupply_;
    uint256 public decimals;
    string public symbol;
    
     function standardtoken(){
        
        totalSupply_=5000;
        owner=msg.sender;
        balances[owner]=totalSupply_;
        symbol="mnw token";
        name="mnw";
        decimals=18;
        
    }
    
    address public owner;
    mapping(address=>uint256)public balances;
    mapping(address => mapping(address => uint256)) allow;
    
    
    modifier onlyowner(){
        require(owner==msg.sender);
        _;
    }
    
    function totalSupply()public   onlyowner() constant returns(uint256){
       return balances[owner];
   }
  
   function transfer(address to,uint256 amount)public  onlyowner() returns(bool){
     require(balances[owner]>=amount&& amount>0 && amount<totalSupply_);
     
      balances[owner]-=amount; 
     }
   function mint(uint256 value)public {
     
       balances[owner]+=value;
      require(balances[owner]<=totalSupply_);
      
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
 
