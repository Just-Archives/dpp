# D++
:zap: ¤ D++ is a simple scripting language written in Pawn.

- For the impatient, here is the example code:
```pawn
import::package.console;
import::package.system;

using::system.rem,"Basic cout example.";
using::console.cout,"Hello World";
```

- Code output:

```
[12:44:50] >> D++ | INFO: Interpreter version 0.0.1-R1 - by: DEntisT
[12:44:50] >> D++ | INFO: Executing the entry script...
[12:44:50]                                                
[12:44:50] |====================| script.dpp |====================|
[12:44:50]                                                
[12:44:50] Hello World
[12:44:50]                                                
[12:44:50] |==============================================|
[12:44:50]                                                
[12:44:50] >> D++ | INFO: The interpreter reached the EOS point.
```
## Documentation

- Options you can modify using `pragma::option` - [read here](dpp_options.md).
- Importable packages and functions - [read here](dpp_packages.md).
- Examples - [see here](dpp_example.md).
- SA:MP and open.mp scripting - [see here](dpp_sampomp.md).


### Worried about the latest updates?

Just regularly check the [workflow runs](https://github.com/samp-api/dpp/actions)! Always select the latest workflow to download the latest build artifacts from.