%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

@contract_interface
namespace IBalanceContract:
    func increase_balance(amount : felt):
    end
    func get_balance() -> (amount : felt):
    end
end

@external
func call_increase_balance{
    syscall_ptr : felt*,
    range_check_ptr : felt
}(contract_address : felt, amount : felt):

    IBalanceContract.increase_balance(
        contract_address=contract_address, 
        amount=amount
    )
    return ()

end

@view
func call_get_balance{
    syscall_ptr : felt*,
    range_check_ptr : felt
}(contract_address : felt) -> (balance : felt):

    let (balance) = IBalanceContract.get_balance(
        contract_address=contract_address
    )

    return (balance)
    
end