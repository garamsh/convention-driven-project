# Interface Conventions

How a boundary between separately built components is specified and tested, so no single implementation shapes it.

## Scope

The rule binds a boundary between components that are built, released or deployed separately: a plugin or driver API, a protocol between separate services, an interface that implementations outside the project take.

It does not cover a boundary inside one build and one release: a module, a layer, a package.

## Rules

- **The boundary is a versioned public interface.** It has a written specification and a version, and a consumer depends on the version, not on an implementation.
- **Each interface has a conformance test.** It runs against any implementation and passes or fails it through the interface alone, reaching into no implementation's internals.
- **More than one implementation from the start**, so the interface is not shaped by the first one. In pre-stable releases, a reference implementation the conformance test runs against, such as a fake or in-memory one, counts as the second. The first stable version (v1 under semver) needs two production implementations that pass the conformance test.
- **The specification states its compatibility rules.** What a release may change without breaking an implementation, what forces a major version, how a deprecated element is retired, and how a caller learns which elements a peer supports before it uses one added in a later release. Without that, a caller sends an element an older peer rejects or misreads. The specification of each interface chooses the mechanism.

## Example

Container Storage Interface (CSI): the specification in `container-storage-interface/spec` defines the interface, and in the `kubernetes-csi` GitHub organization `csi-sanity` in `csi-test` is the conformance test and `csi-driver-host-path` is a sample non-production driver that runs against it beside production drivers. The Container Runtime Interface has the same shape, with `critest` in `cri-tools` as its validation suite. The OCI runtime specification (`opencontainers/runtime-spec`) is implemented by more than one runtime, `runc` and `crun` among them.
