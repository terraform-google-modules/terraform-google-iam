# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keep-a-changelog],
and this project adheres to [Semantic Versioning][semantic-versioning].

Extending the adopted spec, each change should have a link to its
corresponding pull request appended.

## [7.7.1](https://github.com/terraform-google-modules/terraform-google-iam/compare/v7.7.0...v7.7.1) (2023-10-17)


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#199](https://github.com/terraform-google-modules/terraform-google-iam/issues/199)) ([a4debef](https://github.com/terraform-google-modules/terraform-google-iam/commit/a4debef5bc12242f95355ec4abe4a80369b94f85))

## [7.7.0](https://github.com/terraform-google-modules/terraform-google-iam/compare/v7.6.0...v7.7.0) (2023-09-11)


### Features

* add iam submodule for tag keys and values ([#190](https://github.com/terraform-google-modules/terraform-google-iam/issues/190)) ([91ff044](https://github.com/terraform-google-modules/terraform-google-iam/commit/91ff044511481248165cdfcb9cf5e1d5f9b48d77))
* set permissions and member field optional in custom-role sub-module ([#195](https://github.com/terraform-google-modules/terraform-google-iam/issues/195)) ([e5da8da](https://github.com/terraform-google-modules/terraform-google-iam/commit/e5da8daa1359713007f08220456cf9f35685aeb9))

## [7.6.0](https://github.com/terraform-google-modules/terraform-google-iam/compare/v7.5.0...v7.6.0) (2023-04-12)


### Features

* add dns zone IAM submodule ([#181](https://github.com/terraform-google-modules/terraform-google-iam/issues/181)) ([4f6e19d](https://github.com/terraform-google-modules/terraform-google-iam/commit/4f6e19d1e561853dd55106bcb2bcc1c4edc96d45))


### Bug Fixes

* update cloud run tflint ([#179](https://github.com/terraform-google-modules/terraform-google-iam/issues/179)) ([3d72db5](https://github.com/terraform-google-modules/terraform-google-iam/commit/3d72db5b655f9fef5948be5ec7cbb18babb88428))

## [7.5.0](https://github.com/terraform-google-modules/terraform-google-iam/compare/v7.4.1...v7.5.0) (2022-12-30)


### Features

* cloud run services iam submodule ([#164](https://github.com/terraform-google-modules/terraform-google-iam/issues/164)) ([96471a8](https://github.com/terraform-google-modules/terraform-google-iam/commit/96471a8dd3068e90f2c776b2940116f14dbdf143))


### Bug Fixes

* fixes lint issues and generate metadata ([#175](https://github.com/terraform-google-modules/terraform-google-iam/issues/175)) ([d6d503e](https://github.com/terraform-google-modules/terraform-google-iam/commit/d6d503e7dd965deb1c57fabb260fbf80dc84d2f4))

### [7.4.1](https://github.com/terraform-google-modules/terraform-google-iam/compare/v7.4.0...v7.4.1) (2022-03-02)


### Bug Fixes

* pass stage to *_custom_role resources ([255a427](https://github.com/terraform-google-modules/terraform-google-iam/commit/255a427afc110e5fb26028cf98195fc7b6f05b8f))

## [7.4.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v7.3.0...v7.4.0) (2021-12-04)


### Features

* Update version constraints to allow 4.0 ([#149](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/149)) ([44cd5d1](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/44cd5d12dfd694b34f2f1c491e13229fd3455bf8))


### Bug Fixes

* update expected service_account_id format in service_accounts_iam module docs ([#147](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/147)) ([d35e19b](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/d35e19b3a0a4865041cc9c452a0f4cc74de89db1))

## [7.3.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v7.2.0...v7.3.0) (2021-10-20)


### Features

* add bigquery dataset IAM submodule ([#143](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/143)) ([3af16f5](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/3af16f5cdbb7e6f06f270e7be1a479b939fd949d))

## [7.2.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v7.1.0...v7.2.0) (2021-05-10)


### Features

* Add submodule for managing artifact registry IAM ([#137](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/137)) ([3c84a19](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/3c84a196b37060b99383b93362f46fb3c5c4e8bc))

## [7.1.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v7.0.0...v7.1.0) (2021-03-25)


### Features

* Add submodule to support assigning IAM for Secret Manager secrets ([#135](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/135)) ([56b6688](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/56b668857955baeed87590eacca1bfcdaa1867cd))

## [7.0.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v6.4.1...v7.0.0) (2021-03-22)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#134)
* Update audit_config submodule to support multiple log types (#108)

### Features

* add Terraform 0.13 constraint and module attribution ([#134](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/134)) ([1bd58cf](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/1bd58cf7805a70ca7ae7bb3da463795b6a483327))
* Update audit_config submodule to support multiple log types ([#108](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/108)) ([1e5d793](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/1e5d79307f29327d3b5a7f453ca598a84255dad5))


### Bug Fixes

* Correctly exclude unsupported permissions at all stages. ([#131](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/131)) ([a0c07c3](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/a0c07c35cfe029c699396f64da858473a45492a1))

### [6.4.1](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v6.4.0...v6.4.1) (2021-01-19)


### Bug Fixes

* Remove deprecated syntax ([#124](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/124)) ([8fb0abc](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/8fb0abca61498ae4c3be2c7493c190117cf9a366))

## [6.4.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v6.3.1...v6.4.0) (2020-11-10)


### Features

* Add support for predefined roles as a basis for custom roles ([#118](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/118)) ([86c16ee](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/86c16eed31e9c4477a99453ea8a9bb25fe3ce106))

### [6.3.1](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v6.3.0...v6.3.1) (2020-09-22)


### Bug Fixes

* add depends_on to resource name outputs ([#114](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/114)) ([00a7b22](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/00a7b222d940b2f16d9ea8ff9e23a1d988072441))

## [6.3.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v6.2.0...v6.3.0) (2020-09-02)


### Features

* Adding support for IAM Conditions ([#109](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/109)) ([ac41053](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/ac41053db55fad183313dc4e9c7f7fbff86c232d))

## [6.2.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v6.1.0...v6.2.0) (2020-07-17)


### Features

* add type of member to member submodule (member or group or serviceAccount) ([#106](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/106)) ([c6b968c](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/c6b968ce22dc48e3996f72e1e8b0e9bd2a5a6c01))

## [6.1.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v6.0.0...v6.1.0) (2020-04-13)


### Features

* Add helper for assigning members to custom roles ([#102](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/102)) ([fc46920](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/fc469204fb961de12763904b323fd2e23d9acac2))
* Add submodule for managing audit config ([#82](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/82)) ([801788c](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/801788c0bcafb5694ca49a6d4495362f90807d0b))

## [6.0.0](https://www.github.com/terraform-google-modules/terraform-google-iam/compare/v5.1.0...v6.0.0) (2020-03-25)


### ⚠ BREAKING CHANGES

* The `project` variable has been removed from the `projects_iam` submodule. Please use `projects` instead.

### Features

* Add custom_role submodule ([#95](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/95)) ([18cbbf1](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/18cbbf1a4f703fb30987899c041a6844d842c6dc))


### Bug Fixes

* Support empty subnet bindings ([#97](https://www.github.com/terraform-google-modules/terraform-google-iam/issues/97)) ([2f04df9](https://www.github.com/terraform-google-modules/terraform-google-iam/commit/2f04df98ba1a01e907b0d5ab1da133810c5c18bd))

## [Unreleased]

### Added

- Added submodule for assigning multiple roles to a service account. [#88](https://github.com/terraform-google-modules/terraform-google-iam/pull/88)

## [5.1.0] - 2019-12-05

### Added

- Submodule `billing_accounts_iam`. [#52]

### Fixed

- The `folders_iam` submodule correctly handles folder IDs with and without a "folders/" prefix. [#65]

## [5.0.0]

This is a backward incompatible release. Refer to the [upgrade guide](docs/upgrading_to_iam_5.0.md) for more details.

### Changed
- The root module has been removed. [#73]

## [4.0.0] - 2019-11-07

This is a backward incompatible release. Refer to the [upgrade guide](docs/upgrading_to_iam_4.0.md) for more details.

### Changed

- Limit the dynamic configuration usecases. More on this in [caveats][caveats]. [#64]

### Removed

- `*_num` options. [#64]

### Fixed

- Authoritative bindings are correctly applied. [#61]
- Migrate to `for_each` which fixes the configuration update issue. [#64]

## [3.0.0] - 2019-09-26

### Added

- Submodules for each type of binding. [#43]

### Fixed

- Fix issue with long IAM bindings list. [#32]
- Allow referencing computed values. [#43]

## [2.0.0] - 2019-07-16

### Changed

- Supported version of Terraform is 0.12. [#24] [#29]

## [1.1.1] - 2019-05-29

### Fixed

- Updated folders input to accept either `folders/<id>` or `<id>`. [#19]

## [1.1.0] - 2019-05-03

### Added

- Clarification of [additive and authoritative modes in README][modes].
  [#5]
- A [Stackdriver Agent Roles example][stackdriver-agent-roles-example].
  [#12]

### Changed

- The [subnet example][subnet-example] constructs the required fully
  qualified subnet IDs using a `project` variable, a `region` variable,
  and the `subnet_one` and `subnet_two` variables. [#6] [#14]
- The [usage example in the README][usage-example] demonstrates a
  Terraform Module registry reference. [#7]
- The examples pin the `google` and `google-beta` providers to
  `~> 1.20`. [#9]

## [1.0.0] - 2018-09-26

This is the initial release of the module, with support for bulk IAM
management.

[modes]: README.md#additive-and-authoritative-modes
[keep-a-changelog]: https://keepachangelog.com/en/1.0.0/
[semantic-versioning]: https://semver.org/spec/v2.0.0.html
[stackdriver-agent-roles-example]: examples/stackdriver_agent_roles
[subnet-example]: examples/subnet
[usage-example]: README.md#usage
[caveats]: README.md#caveats

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v5.1.0...HEAD
[5.1.0]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v5.0.0...v5.1.0
[5.0.0]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v4.0.0...v5.0.0
[4.0.0]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v3.0.0...v4.0.0
[3.0.0]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v1.1.1...v2.0.0
[1.1.1]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/terraform-google-modules/terraform-google-iam/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-iam/releases/tag/v1.0.0

[#5]: https://github.com/terraform-google-modules/terraform-google-iam/pull/5
[#6]: https://github.com/terraform-google-modules/terraform-google-iam/pull/6
[#7]: https://github.com/terraform-google-modules/terraform-google-iam/pull/7
[#9]: https://github.com/terraform-google-modules/terraform-google-iam/pull/9
[#12]: https://github.com/terraform-google-modules/terraform-google-iam/pull/12
[#14]: https://github.com/terraform-google-modules/terraform-google-iam/pull/14
[#19]: https://github.com/terraform-google-modules/terraform-google-iam/pull/19
[#24]: https://github.com/terraform-google-modules/terraform-google-iam/pull/24
[#29]: https://github.com/terraform-google-modules/terraform-google-iam/pull/29
[#32]: https://github.com/terraform-google-modules/terraform-google-iam/pull/32
[#43]: https://github.com/terraform-google-modules/terraform-google-iam/pull/43
[#52]: https://github.com/terraform-google-modules/terraform-google-iam/issues/52
[#61]: https://github.com/terraform-google-modules/terraform-google-iam/pull/61
[#64]: https://github.com/terraform-google-modules/terraform-google-iam/pull/64
[#65]: https://github.com/terraform-google-modules/terraform-google-iam/issues/65
[#73]: https://github.com/terraform-google-modules/terraform-google-iam/pull/73
[#78]: https://github.com/terraform-google-modules/terraform-google-iam/pull/78
