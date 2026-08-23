# Domain-Partitioned Architecture

How a system divided first by domain and layered inside each domain is shaped: what a domain is, what may cross which boundary, and when a new one is earned.

## What it is

The system is divided by subject matter — one folder per domain, feature, or bounded context — and each domain is divided inside into horizontal layers of its own, commonly interface, business logic, and persistence. Every file belongs to exactly one domain, and to exactly one layer within it.

The outer division is what *Fundamentals of Software Architecture* (Richards and Ford, 2020) calls domain partitioning, against the technical partitioning a layered system uses; *Domain-Driven Design* (Evans, 2003) supplies the two halves as separate patterns, Bounded Context outside and Layered Architecture inside. `layered-domain` is this repository's file name and is not a term either source uses.

Nothing here states how a layer is divided inside, or how the system is deployed. The first divides by stack; the second is a separate decision, and the same partitioning serves one deployable or many.

## When it fits

- The subject areas are already named by the people who ask for the work, rather than inferred from code that exists.
- Most changes belong to one subject area, so one change should land inside one folder.
- People are organised by subject matter rather than technical skill, so each domain has an owner.
- The domains differ enough inside that one technical division imposed across all of them would fit none of them well.
- A domain may later ship separately, and its boundary is where that split would run.

## Boundaries and dependency direction

- **A domain is the outer unit.** One folder per domain, named for its subject matter and never for a technical role.
- **A layer is the inner unit.** One folder per technical responsibility, inside the domain that owns it and never above one. Every file belongs to exactly one layer of exactly one domain.
- **Layer dependencies point down, inside one domain.** A layer references the layers below it in its own domain and never the one above, and it references no layer of another domain.
- **A domain is reached only through what it declares public.** Its layers are internal, so reaching another domain's persistence or business logic is a defect even where the language permits it.
- **Whether a domain may depend on a sibling at all is contested.** *Domain-Driven Design* (Evans, 2003) gives no single answer: its relations between contexts run from Shared Kernel, where two share code, to Separate Ways, where neither may reference the other. A project takes one, records which, and a reference the recorded choice does not permit is a defect.
- **Shared code sits below every domain, never beside one.** What two domains both need is extracted below them, or owned by one and reached through its declared surface; it never becomes a sibling folder no domain owns.
- **A cycle between domains means the split is wrong**, and so does a file that belongs in two of them.
- **A new domain is earned** by subject matter with its own lifecycle and vocabulary, which something outside it depends on, and whose public surface can stay stable while its inside changes. A new layer is earned inside one domain and not across all of them: a domain with nothing to persist carries no persistence layer.

## What it costs

- The layer structure repeats in every domain, so a change to one technical concern is made once per domain rather than once.
- A technical specialist works across every domain, and no folder holds their concern whole.
- Work belonging to no single domain has no home, and the shared code it lands in grows without an owner.
- A boundary drawn in the wrong place is expensive to move, and it is drawn when the subject matter is least understood.
- Inside a domain, plain layering's costs still apply at that domain's scale: a change spread across its layers, and forwarding layers still written, read, and changed.

## Signs the choice was wrong

- Most changes touch several domains at once, and the pair that always move together cannot be released independently.
- The same fix is applied once per domain, and a domain keeps being missed.
- The shared code every domain imports is growing faster than any domain.
- Which domain a new file belongs to cannot be settled without asking someone.
- A domain's public surface has grown until it names what its layers hold.
