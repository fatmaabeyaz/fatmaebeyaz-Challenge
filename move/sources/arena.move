module challenge::arena;

use challenge::hero::Hero;
use sui::event;

// ========= STRUCTS =========

public struct Arena has key, store {
    id: UID,
    warrior: Hero,
    owner: address,
}

// ========= EVENTS =========

public struct ArenaCreated has copy, drop {
    arena_id: ID,
    timestamp: u64,
}

public struct ArenaCompleted has copy, drop {
    winner_hero_id: ID,
    loser_hero_id: ID,
    timestamp: u64,
}

// ========= FUNCTIONS =========

// Bu fonksiyonu bul ve üzerine yaz:
public fun create_arena(hero: Hero, ctx: &mut TxContext) {

    // DÜZELTME: 'ctx::sender()' -> 'ctx.sender()' olarak değiştirildi.
    let arena = Arena {
        id: object::new(ctx),
        warrior: hero,
        owner: ctx.sender()
    };

    // DÜZELTME: 'created_at' -> 'timestamp' olarak değiştirildi.
    event::emit(ArenaCreated {
        arena_id: object::id(&arena),
        timestamp: ctx.epoch_timestamp_ms()
    });

    transfer::share_object(arena);
}
#[allow(lint(self_transfer))]
public fun battle(hero: Hero, arena: Arena, ctx: &mut TxContext) {
    
    let Arena { id, warrior, owner } = arena;

    // DÜZELTME: ID'leri, nesneler transfer edilmeden (move) ÖNCE alıyoruz.
    let hero_id = object::id(&hero);
    let warrior_id = object::id(&warrior);

    if (hero.hero_power() > warrior.hero_power()) {
        
        // 1. Adım: Önce event'i emit et (kayıtlı ID'leri kullanarak)
        event::emit(ArenaCompleted {
            winner_hero_id: hero_id,
            loser_hero_id: warrior_id,
            timestamp: ctx.epoch_timestamp_ms()
        });

        // 2. Adım: Sonra nesneleri transfer et
        transfer::public_transfer(hero, ctx.sender());
        transfer::public_transfer(warrior, ctx.sender());

    } else {
        
        // 1. Adım: Önce event'i emit et (kayıtlı ID'leri kullanarak)
        event::emit(ArenaCompleted {
            winner_hero_id: warrior_id,
            loser_hero_id: hero_id,
            timestamp: ctx.epoch_timestamp_ms()
        });

        // 2. Adım: Sonra nesneleri transfer et
        transfer::public_transfer(hero, owner);
        transfer::public_transfer(warrior, owner);
    };

    object::delete(id);
}