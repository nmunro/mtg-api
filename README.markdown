# Mtg-Api

A Common Lisp library for interfacing with the Magic: The Gathering [api](https://api.magicthegathering.io/).

## Usage

### Description

The api is has 9 end points the `cards` has multiple arguments that can be used and this library has a convenience `where` function that is used to build an argument list.

### Objects

#### Card

A card object represents a card in Magic: The Gathering, these objects are used in responses from the API.

A card has the following `reader` methods, they can be accessed from the `mtg-api/card` package.

- id
- name
- layout
- mana-cost
- multiverseid
- cmc
- colors
- color-identity
- type
- supertypes
- types
- subtypes
- rarity
- set
- set-name
- text
- flavor
- artist
- number
- power
- toughness
- image-url
- watermark
- rulings
- foreign-names
- printings
- original-text
- original-type
- legalities

#### Set

A set object represents a set in Magic: The Gathering, these objects are used in responses from the API.

A set has the following `reader` methods, they can be accessed from the `mtg-api/set` package.

- code
- gatherer-code
- old-code
- expansion
- name
- type
- border
- mkm-id
- booster
- mkm-name
- release-date
- onlineOnly
- magic-cards-info-code
- block

#### Ruling

A ruling object represents a ruling for a card in Magic: The Gathering, these objects are used in responses from the API.

A ruling has the following `reader` methods, they can be accessed from the `mtg-api/ruling` package.

- date
- text

#### Translation

A translation object represents a translation for a card in Magic: The Gathering, these objects are used in responses from the API.

A translation has the following `reader` methods, they can be accessed from the `mtg-api/translation` package.

- name
- language
- multiverse-id

#### Legalities

A legality object represents a legality for a card in Magic: The Gathering, these objects are used in responses from the API.

A legality has the following `reader` methods, they can be accessed from the `mtg-api/legality` package.

- format
- legality

### End points

Some end points and take combinations of options and an `:and` & `:or` option in provided to combine parameters.

#### card/:id

Returns a `card` identified by its `id` or `multiverseid`.

    (card :where '(:id 3668))
    
A where keyword arg that specifies an `:id` *MUST* be provided.

#### cards

Returns a list of `card`s filtered by `where` clauses that use arguments defined in the [api](https://docs.magicthegathering.io/#api_v1cards_list).

    (cards :where '(:name "Mirri" :or "unmake") :where '(:colors "black") :where '(:cmc 4))

#### set/:id

Returns a set by code.

    (set :where '(:code "BFZ"))

A where keyword arg that specifies a `:code` *MUST* be provided.

#### sets

Returns a set by code or block.

Sets may be given one or more names:

    (sets :where '(:name "Battle For Zendikar"))
    (sets :where '(:name "Battle For Zendikar" :or "Innistrad"))

Sets may be given one or more blocks

    (sets :where '(:block "Mirrodin"))
    (sets :where '(:block "Mirrodin" :or "Innistrad"))
    
The sets api end point uses `or` as the supported boolean operator so the `:and` operator does nothing.

Either a keyword arg of `:name` or `:block` *MAY* be provided, omitting a name or block will return a list of all sets.
    
#### sets/:id/booster

Returns a list of cards representing a booster in a set identified by set code.

    (set :where '(:code "BFZ") :where '(:booster t))

A where function that specifies a `:code` *MUST* be provided.

It is possible to provide a second `where` clause, a booster clause (which is `nil` by default) which when set to `t` will return an idiomatic booster pack for the set.

#### types

Returns a list of strings representing types.

    (types)

#### subtypes

Returns a list of strings representing subtypes.

    (subtypes)

#### supertypes

Returns a list of strings representing supertypes.

    (supertypes)

#### formats

Returns a list of strings representing formats.

    (formats)
