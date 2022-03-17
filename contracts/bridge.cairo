%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn
from starkware.starknet.common.messages import send_message_to_l1

const L1_CONTRACT_ADDRESS = 0x2Db8c2615db39a5eD8750B87aC8F217485BE11EC
const MESSAGE_WITHDRAW = 0

@storage_var
func balance(user : felt) -> (amount : felt):
end

@external
func get_balance{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr : felt
}(user : felt) -> (amount : felt):
    let (result) = balance.read(user=user)
    return (result)
end

@external
func mint{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr : felt
}(amount : felt):
    assert_nn(amount)
    let (result) = balance.read(user=to)
    balance.write(user, result + amount) 
end

@external
func withdraw{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr : felt
}(user : felt, amount : felt):
    asset_nn(amount)

    let (res) = balance.read(user=user)
    tempvar new_balance = res - amount

    assert_nn(new_balance)

    balance.write(user, new_balance)

    let (message_payload : felt*) = alloc()
    assert message_payload[0] = MESSAGE_WITHDRAW
    assert message_payload[1] = user
    assert message_payload[2] = amount

    send_message_to_l1(
        to_address=L1_CONTRACT_ADDRESS,
        payload_size=3,
        payload=message_payload
    )
end