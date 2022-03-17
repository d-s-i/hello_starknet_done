%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func owner() -> (owner_address : felt):
end

# @constructor
# func constructor{
#     syscall_ptr : felt*, 
#     pedersen_ptr : HashBuiltin*,
#     range_check_ptr
# }():
#     let (deployer) = get_caller_address()
#     owner.write(deployer)
#     return ()
# end

@constructor
func constructor{
    syscall_ptr : felt*, 
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(owner_address : felt):
    # let (deployer) = get_caller_address()
    owner.write(owner_address)
    return ()
end

@view
func get_owner{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}() -> (owner_address : felt):
    return owner.read()
end