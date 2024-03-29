{{
    config(
        schema = 'gemswap_zksync',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v2_trades(
        blockchain = 'zksync',
        project = 'gemswap',
        version = '1',
        Pair_evt_Swap = source('gemswap_zksync', 'ZGemPair_evt_Swap'),
        Factory_evt_PairCreated = source('gemswap_zksync', 'ZGemFactory_evt_PairCreated')
    )
}}
