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

### Shebang Consideration

A shebang (pronounces sha-bang) tells the bash script what program that will interpret the script. `#!/bin/bash`. 
ChatGPT recommennded this format for bash: `#!/usr/bin/env bash`

- For portability for different os distributions
- will search the user"s PATH for the bash executable

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script
E.g `./bin/install_terraform_cli`
If we are using a script in gitpod.yml we need to point the script to a program to interpret it.
E.g. ` source ./bin/install_terraform_cli`

### Linux Permission Considerations

in orther to make bash scripts executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

### GitHub Lifecycle (Before, init, Command)

We need to be careful when using the init because it will not rerun if we start an existing workspace.

### Working with Env Vars

WE can list all Environment Variables Using the `env`  command
we can filter env vars using grep eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set Using `expoort Hello='world`

in the terminal we can unset uusing `unset Hello`

we can set an env var temporarily when just running a conmand

```sh
HELLO='WORLD' ./bin/print_message
```

Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

## Printing env Vars

We can print env vars using echo eg 'echo $HELLO'

### Scoping of env vars

when you open up a new bash terminal in VSCode it will not be aware of env vars that you have set in another window.

if you want to Env var to persist accross all future bash terminal that are open you need to set an env var in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod by storing them in Gitpod Secret Storagge

```sh
gp env HELLO='world'
```



All future workspace launched will set the env vvars for all bash terminals opened in those workspaces.

You can also set en vars in the '.gitpod.ymal' but this can only contain non sensitive env vars


### AWS CLI installation

AWS CLi is installed for this project via bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

we csn check if our AWS is configured correctly by running the following command:

```sh
aws sts get-caller-identity
```
If it successful you should seee a json payload that look lik this:

```json
{
    "UserId": "AEDURCVVISVLXThC6L4VK",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::073193227607:user/terraform-beginner-bootcamp"
}
```
WE neeed to generate aws cli credentials from IAM user in order to to the user cli.

## Terraform Basics

### Terraform Registry

Terraform sources their provider and modules from Terraform registry which is located at:
[https://registry.terraform.io/](https://registry.terraform.io/)

- **Providers** are interfaces to APIs that will allow you to creat resouces with terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable

[Random terraform provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

### Terraform console

We can see all the terraform command by simply typing `terraform`. Some of which include:

- **Terraform init** Terraform to initialize a new or existing Terraform working directory. It performs plugin installations, module installation, intitializing the backend and workspace.

- **Terraform Plan** command in Terraform is used to generate an execution plan. It does not make any changes to your infrastructure but instead shows you what Terraform intends to do when you run terraform apply.

- **Terraform apply** is used in Terraform to apply the changes defined in your Terraform configuration to your infrastructure. It is used to initialize, plan, review, confirm, execute and ouput infrastructure. An apply will promt a yes or no.

- **Terraform apply -auto-approve** is used to automatically approve the execution plan without being prompted for confirmation.
  
- **Terraform Destroy** is used in Terraform to destroy all the resources defined in your Terraform configuration. It effectively tears down your infrastructure to match the desired state defined in your configuration but in reverse.


### Terraform Lock Files
`.terraform.lock.hcl` contains the locked versioning for the providers or modules thtat should be used with this project.
**The Terraform Lock File should be commited** to version control system (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate`  conatain information about the current state of your infrastructure.

This File **should not be committed** to your VSC.

 This file contains sensitive data. If you loose this file, you loose knowing the state of your infrastructure.

 `.terraform.tfstate.backup` is the previous state file state.

 ### Terraform Directory

 `.terraform` directory contains binaries of terraform prividers.

 Terraform Destroy
 is used in Terraform to destroy all the resources defined in your Terraform configuration. It effectively tears down your infrastructure to match the desired state defined in your configuration but in reverse.

 ### Pull Request
 Because i resolves  branch 11 issue before branch 10, I experiences difficulty merging *conflict in .terraform.lock.hcl* to main branch using Github so I had to do it from the command line interface.
 first I used command
 ```sh
git pull origin main
```
then i used the command
```sh
git merge main
```
which failed due to conflict in .terraform.lock.hcl. so i used:
```sh
 config pull.rebase false
```
From gitpod activity bar i added before committing it, after which i used:
```sh
git push -u origin 10-simple-s3-bucket
```
I went back to github to Merge the pull request.






# Reference

- [How to check your linix flavor](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

- [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

- [Install_Terraform-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- [linux permission chmod](https://en.wikipedia.org/wiki/Chmod)

- [chmod permission calculator](https://chmod-calculator.com/)

- [Gitpod lifecycle task](https://www.gitpod.io/docs/configure/workspaces/tasks)

- [Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

- [AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

- [Random terraform provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)
