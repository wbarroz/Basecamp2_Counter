#[starknet::interface]
trait ICounterContract<TContractState>{
    fn get_contador(self:@TContractState)->u32;
    fn increase_contador(ref self: TContractState);
}

#[starknet::contract]
mod CounterContract {
    // consultar core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    #[storage]
    struct Storage {
        contador: u32,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        contador_:u32) {
        self.contador.write(contador_);
    }

    #[abi(embed_v0)]
    impl CounterContract of super::ICounterContract<ContractState>{
        fn get_contador(self:@ContractState)->u32{
            self.contador.read()
        }
        fn increase_contador(ref self: ContractState){
            let current_contador = self.contador.read();
            self.contador.write(current_contador + 1);
        }
    }
}
