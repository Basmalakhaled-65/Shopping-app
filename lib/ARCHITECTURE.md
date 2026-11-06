# Shopping App Architecture

The project is organized around Clean Architecture dependency direction:

- `presentation/`: screen-facing facades. Facades invoke Domain use cases; UI screens/widgets call these facades rather than data sources or repositories.
- `domain/entities/`: core product entity.
- `domain/repositories/`: repository contracts.
- `domain/usecases/`: application operations (authentication, products, cart, favorites).
- `data/datasources/remote/`: API-specific data sources.
- `data/repositories/`: implementations of Domain repository contracts and model/entity mapping.
- `core/`: dependency composition, API client/constants, and token storage.

`services/` retains backward-compatible facades for any older imports; current screens and widgets use `presentation/facades/`.

Dependency direction: Presentation -> Domain; Data -> Domain contracts; Core provides shared infrastructure.
