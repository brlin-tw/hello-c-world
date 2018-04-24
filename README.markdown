# Hello C World

An example C software project to experiment coding methodologies
<https://github.com/Lin-Buo-Ren/hello-c-world>

## Licensing

This project is released into the Public Domain.

## Experimental Branches

The project is separated into various Git branches for different levels of friendliness/modern/variety experiments.

### Realistic

The default branch is `realistic`, which is the currently recommended level for beginners to avoid practical obstacles while still being relatively friendly and advanced.

#### Assertions

##### Limitations

* The build system doesn't allow spaces in filenames/paths
* The build system is not non-ASCII friendly
* The I18N toolkit only allows English strings in source code.
* Only use undercase alphabets and dashes(`-`) as filenames/path components, for command-line autocomplete friendliness
* The build system *may* place files outside of it's build-solutions directory(which is dirty, but still widely common for many build solutions)

##### Friendliness

* The build system allows custom names(as long as it fits in the limitation)

### Space Friendly

The`space-friendly` branch is the experimental branch that believes spaces in filenames/paths are reasonable and should be supported by the build environment.

#### Assertions

##### Limitations

- The build system is not non-ASCII friendly
- The I18N toolkit only allows English strings in source code.

#####  Friendliness

- The build system allows custom names(as long as it fits in the limitation)
- The build system allows spaces in filenames/paths

### Unicode Friendly

The `unicode-friendly` branch is the experimental branch that believes Unicode characters in filenaes/paths/code is reasonable and should be supported by the build environment.

#### Assertions

##### Limitations

None.

#####  Friendliness

- The build system allows custom names(as long as it fits in the limitation)
- The build system allows spaces in filenames/paths
- The build system allows Unicode characters in filenames/paths
- The I18N tookit allows Unicode strings in source code and don't assume English locale

## Control Case Branches

### Old-fashioned

Advanced?  Nope!  Stick to the quo!

The `old-fashioned` branch is the non-experimental branch that follows (and don't question) any conventions.  Of course this is the most safe one, but it's boring.
