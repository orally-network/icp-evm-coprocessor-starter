local_deploy: local_deploy_evm_rpc
	$(eval EVM_RPC_CANISTER := $(shell dfx canister id evm_rpc))

	dfx canister create chain_fusion && dfx build chain_fusion

	gzip -f -1 ./.dfx/local/canisters/chain_fusion/chain_fusion.wasm

	dfx canister install --wasm ./.dfx/local/canisters/chain_fusion/chain_fusion.wasm.gz --argument-file initArgument.did chain_fusion 

ic_deploy
	$(eval EVM_RPC_CANISTER := $(shell dfx canister id evm_rpc --ic))

	dfx canister create chain_fusion && dfx build chain_fusion --ic

	gzip -f -1 ./.dfx/local/canisters/chain_fusion/chain_fusion.wasm

	dfx canister install --wasm ./.dfx/local/canisters/chain_fusion/chain_fusion.wasm.gz --argument-file initArgument.did chain_fusion --ic

local_deploy_evm_rpc:
	dfx deploy evm_rpc --argument '(record { nodesInSubnet = 28 })'

local_build: 
	cargo build --release --target wasm32-unknown-unknown --package chain_fusion
