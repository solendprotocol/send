module send::send {
    use sui::coin::{Self};
    use sui::url::{Self};

    public struct SEND has drop {}

    fun init(witness: SEND, ctx: &mut TxContext) {
        let (treasury, deny_cap, metadata) = coin::create_regulated_currency_v2(
            witness, 
            6, 
            b"SEND", 
            b"SEND", 
            b"",
            option::some(url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/SEND/SEND.svg")), 
            true,
            ctx
        );

        transfer::public_share_object(metadata);
        transfer::public_transfer(treasury, ctx.sender());
        transfer::public_transfer(deny_cap, ctx.sender());
    }
}
