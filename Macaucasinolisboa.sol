#
#  Panoramix v4 Oct 2019 
#  Decompiled source of bsc:0xfE4EB925914Bf72f6FC19b98B359E246ac3DF132
# 
#  Let's make the world open source 
# 

def storage:
  owner is addr at storage 0
  stor1 is addr at storage 1
  balanceOf is mapping of uint256 at storage 2
  allowance is mapping of uint256 at storage 3
  totalSupply is uint256 at storage 4
  name is array of uint256 at storage 5
  symbol is array of uint256 at storage 6
  decimals is uint8 at storage 7

def name() payable: 
  return name[0 len name.length]

def totalSupply() payable: 
  return totalSupply

def decimals() payable: 
  return decimals

def balanceOf(address _owner) payable: 
  require calldata.size - 4 >= 32
  return balanceOf[addr(_owner)]

def owner() payable: 
  return owner

def symbol() payable: 
  return symbol[0 len symbol.length]

def allowance(address _owner, address _spender) payable: 
  require calldata.size - 4 >= 64
  return allowance[addr(_owner)][addr(_spender)]

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def transferOwnership(address _newOwner) payable: 
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  if not _newOwner:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  38,
                  0x654f776e61626c653a206e6577206f776e657220697320746865207a65726f20616464726573,
                  mem[202 len 26]
  stor1 = _newOwner

def acceptOwnership() payable: 
  if stor1 != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  44,
                  0x734f776e61626c653a206f6e6c79206e6577206f776e65722063616e20616363657074206f776e6572736869,
                  mem[208 len 20]
  owner = stor1
  stor1 = 0
  log OwnershipTransferred(
        address previousOwner=owner,
        address newOwner=owner)

def mint(address _to, uint256 _amount) payable: 
  require calldata.size - 4 >= 64
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  if not _to:
      revert with 0, 'ERC20: mint to the zero address'
  if totalSupply + _amount < totalSupply:
      revert with 0, 'SafeMath: addition overflow'
  totalSupply += _amount
  if balanceOf[addr(_to)] + _amount < balanceOf[addr(_to)]:
      revert with 0, 'SafeMath: addition overflow'
  balanceOf[addr(_to)] += _amount
  log Transfer(
        address from=_amount,
        address to=0,
        uint256 value=_to)

def burn(uint256 _value) payable: 
  require calldata.size - 4 >= 32
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  33,
                  0x6545524332303a206275726e2066726f6d20746865207a65726f20616464726573,
                  mem[197 len 31]
  if _value > balanceOf[caller]:
      revert with 0, 32, 34, 0x7345524332303a206275726e20616d6f756e7420657863656564732062616c616e63, mem[162 len 30], mem[222 len 2]
  balanceOf[caller] -= _value
  if _value > totalSupply:
      revert with 0, 'SafeMath: subtraction overflow'
  totalSupply -= _value
  log Transfer(
        address from=_value,
        address to=caller,
        uint256 value=0)

def approve(address _spender, uint256 _value) payable: 
  require calldata.size - 4 >= 64
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] = _value
  log Approval(
        address owner=_value,
        address spender=caller,
        uint256 value=_spender)
  return 1

def decreaseAllowance(address _spender, uint256 _subtractedValue) payable: 
  require calldata.size - 4 >= 64
  if _subtractedValue > allowance[caller][addr(_spender)]:
      revert with 0, 
                  32,
                  37,
                  0x7045524332303a2064656372656173656420616c6c6f77616e63652062656c6f77207a6572,
                  mem[165 len 27],
                  mem[219 len 5]
  if not caller:
      revert with 0, 32, 36, 0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[296 len 28]
  if not _spender:
      revert with 0, 32, 34, 0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573, mem[294 len 30]
  allowance[caller][addr(_spender)] -= _subtractedValue
  log Approval(
        address owner=(allowance[caller][addr(_spender)] - _subtractedValue),
        address spender=caller,
        uint256 value=_spender)
  return 1

def increaseAllowance(address _spender, uint256 _addedValue) payable: 
  require calldata.size - 4 >= 64
  if allowance[caller][addr(_spender)] + _addedValue < allowance[caller][addr(_spender)]:
      revert with 0, 'SafeMath: addition overflow'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] += _addedValue
  log Approval(
        address owner=(allowance[caller][addr(_spender)] + _addedValue),
        address spender=caller,
        uint256 value=_spender)
  return 1

def withdraw(uint256 _amount, address _recepient) payable: 
  require calldata.size - 4 >= 64
  if owner != caller:
      revert with 0, 'Ownable: caller is not the owner'
  else:
      require _amount > 0
      if _recepient:
          require ext_code.size(_recepient)
          static call _recepient.balanceOf(address owner) with:
                  gas gas_remaining wei
                 args this.address
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          else:
              require return_data.size >= 32
              require ext_call.return_data >= _amount
              require ext_code.size(_recepient)
              call _recepient.transferFrom(address from, address to, uint256 value) with:
                   gas gas_remaining wei
                  args addr(this.address), caller, _amount
              if not ext_call.success:
                  revert with ext_call.return_data[0 len return_data.size]
              else:
                  require return_data.size >= 32
                  stop
      else:
          call caller with:
             value _amount wei
               gas 2300 * is_zero(value) wei
          if not ext_call.success:
              revert with ext_call.return_data[0 len return_data.size]
          else:
              stop

def transfer(address _to, uint256 _value) payable: 
  require calldata.size - 4 >= 64
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  37,
                  0x7345524332303a207472616e736665722066726f6d20746865207a65726f20616464726573,
                  mem[201 len 27]
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  35,
                  0xfe45524332303a207472616e7366657220746f20746865207a65726f20616464726573,
                  mem[199 len 29]
  if _value > balanceOf[caller]:
      revert with 0, 
                  32,
                  38,
                  0x7345524332303a207472616e7366657220616d6f756e7420657863656564732062616c616e63,
                  mem[166 len 26],
                  mem[218 len 6]
  balanceOf[caller] -= _value
  if balanceOf[addr(_to)] + _value < balanceOf[addr(_to)]:
      revert with 0, 'SafeMath: addition overflow'
  balanceOf[addr(_to)] += _value
  log Transfer(
        address from=_value,
        address to=caller,
        uint256 value=_to)
  return 1

def burnFrom(address _from, uint256 _value) payable: 
  require calldata.size - 4 >= 64
  if _value > allowance[addr(_from)][caller]:
      revert with 0, 32, 36, 0x6545524332303a206275726e20616d6f756e74206578636565647320616c6c6f77616e63, mem[164 len 28], mem[220 len 4]
  if not _from:
      revert with 0, 32, 36, 0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[296 len 28]
  if not caller:
      revert with 0, 32, 34, 0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573, mem[294 len 30]
  allowance[addr(_from)][caller] -= _value
  log Approval(
        address owner=(allowance[addr(_from)][caller] - _value),
        address spender=_from,
        uint256 value=caller)
  if not _from:
      revert with 0, 32, 33, 0x6545524332303a206275726e2066726f6d20746865207a65726f20616464726573, mem[293 len 31]
  if _value > balanceOf[addr(_from)]:
      revert with 0, 32, 34, 0x7345524332303a206275726e20616d6f756e7420657863656564732062616c616e63, mem[258 len 30], mem[318 len 2]
  balanceOf[addr(_from)] -= _value
  if _value > totalSupply:
      revert with 0, 'SafeMath: subtraction overflow'
  totalSupply -= _value
  log Transfer(
        address from=_value,
        address to=_from,
        uint256 value=0)

def transferFrom(address _from, address _to, uint256 _value) payable: 
  require calldata.size - 4 >= 96
  if not _from:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  37,
                  0x7345524332303a207472616e736665722066726f6d20746865207a65726f20616464726573,
                  mem[201 len 27]
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  35,
                  0xfe45524332303a207472616e7366657220746f20746865207a65726f20616464726573,
                  mem[199 len 29]
  if _value > balanceOf[addr(_from)]:
      revert with 0, 
                  32,
                  38,
                  0x7345524332303a207472616e7366657220616d6f756e7420657863656564732062616c616e63,
                  mem[166 len 26],
                  mem[218 len 6]
  balanceOf[addr(_from)] -= _value
  if balanceOf[addr(_to)] + _value < balanceOf[addr(_to)]:
      revert with 0, 'SafeMath: addition overflow'
  balanceOf[addr(_to)] += _value
  log Transfer(
        address from=_value,
        address to=_from,
        uint256 value=_to)
  if _value > allowance[addr(_from)][caller]:
      revert with 0, 
                  32,
                  40,
                  0x6545524332303a207472616e7366657220616d6f756e74206578636565647320616c6c6f77616e63,
                  mem[264 len 24],
                  mem[312 len 8]
  if not _from:
      revert with 0, 32, 36, 0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[392 len 28]
  if not caller:
      revert with 0, 32, 34, 0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573, mem[390 len 30]
  allowance[addr(_from)][caller] -= _value
  log Approval(
        address owner=(allowance[addr(_from)][caller] - _value),
        address spender=_from,
        uint256 value=caller)
  return 1


