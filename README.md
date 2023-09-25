# Terraform Beginner Bootcamp 2023

## Semantic versioning :mage:

This project is going to utilize Semantic versioning for it tagging.
[semver.org/](https://semver.org/)

The general Format:
**MAJOR, MINOR, PATCH**, EG. `101`

Given a version number **MAJOR.MINOR.PATCH**, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Consideration with Terraform CLI changes

The terraform installation have changed due to gpg keyring changes. so we needed to to refer to the latest install CLI instructions via Terraform documentation and change the scripting for installation 

[Install_Terraform-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for LInux diistribution

This project is built against ubuntu.
please consider checking your linux distrubutiob and change change according to distribution needs.

[How to check your linix flavor](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

```
cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. so we decided to creat a bash script to install the teraform cli.

This bash script is located here: ([./bin/install_terraform_cli](./bin/install_terraform_cli)) 



- This will keep the Gitpod File ([.gitpod.yml](.gitpod.yml))Tidy.
- This allow us an easier way to debug and execute manaually terraform cli install
- This will allow better portability for other projects that need to install terraform Cli.

### Shebang

A shebang (pronounces sha-bang) tells the bash script what program that will interpret the script. `#!/bin/bash`. 
ChatGPT recommennded this format for bash: `#!/usr/bin/env bash`

- For portability for different os distributions
- will search the user"s PATH for the bash executable

When executing the bash script we can use the `./` shorthand notation to execute the bash script

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))



# Reference

- [How to check your linix flavor](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

- [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

- [Install_Terraform-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- [linux permission chmod](https://en.wikipedia.org/wiki/Chmod)

- [chmod permission calculator](https://chmod-calculator.com/)

- [Gitpod lifecycle task](https://www.gitpod.io/docs/configure/workspaces/tasks)