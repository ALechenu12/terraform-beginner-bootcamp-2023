# Terraform Beginner Bootcamp 2023 - Week 1

## Root module structure

our root module structure is as follow:
```
- PROJECT_ROOT
  |- main.tf               - everything else
  |- variables.tf          - stores the structure of input variables
  |- provider.tf           - defined required provider and their configuration
  |- terraform.tfvars      - the data of variables we want to load into our Terraform project
  |- output.tf             - stores our output
  |- README.md             - required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform input Variables

### Terraform Cloud Variables

In Terraform we can set two kind of Variables:
- Environment variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set terraform cloud variables to be sensitive so they are not visible in the user interface


### Loading Terraform input Variables

[Terraform input variable](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag

We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"'

### var-file flag
-TODO : Research this Flag

### terraform.tfvars

This is the default file to load in terraform variables in blunk

### auto.tfvars

-TODO: documment this functionalit for terraform cloud 

### order of terraform variables
-TODO : document which terraform variables take presedence.

## Dealing with configuration Drift

## What happens if we loose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

## Fixing Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[AWS_S3_BUCKET](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)
[Terraform Import](https://developer.hashicorp.com/terraform/language/import)

### Fix Manual configuration

If someone goes and delete or modifies cloud resources manually through Clickops.
If we rerun Terraform plan back into the expected state fixing configuration drift

## Fix using Terraform Refresh


```sh
terraform apply -refresh-only -auto-approve
```

## Terraform modules

### Terraform modules Structure

it is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like

## Passing input Variables

We can pass input variables to to our modules.
The module has to declare the terraform variables in its own `variables.tf`

```tf
module "terrahouse_aws" {
  source      = "./modules/terrahouse_aws"
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name
}

```

### Module sources
Using the source we can import the module from various place eg. 

- locally
- github
- Terraform Registry

```tf
module "terrahouse_aws"{
  source = "./modules/terrahouse_aws"
}
```


## Considerations when using ChatGPT to write Terraform
LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. Often affecting providers.

## Working with Files in Terraform


### Fileexists function
This is a built in terraform function to check the existance of a file.


```tf
condition = fileexists(var.error_html_filepath)
```
https://developer.hashicorp.com/terraform/language/functions/fileexists

### etag(filemd5)
This is use to check changes in the data content of a file

[filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

## working with files in terraform

In terraform there is a special variable called `path` that allowsus reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"


  
  etag = filemd5(var.error_html_filepath)
}
```

### Terraform Local

Locals allows us to define local variables. It can be very useful when we need to transform data into another format and have a referenced variable.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```

[Terraform local value](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform data sources

This allows to source data from cloud resources.

This is useful when we want to reference cloud resources without inporting them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Terraform data sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with json

We used jsonencode to create the json inline with hcl

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}

```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

## Terraform Resource Lifecycle

This is the changing the lifecycle of resources

[Meta Argument Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Teraform Data
Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.
```tf
resource "terraform_data" "content_version" {
  input = var.content_version
  
}
```

```tf
variable "revision" {
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

# This resource has no convenient attribute which forces replacement,
# but can now be replaced by any change to the revision variable value.
resource "example_database" "test" {
  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}
```

[Terraform Data)(https://developer.hashicorp.com/terraform/language/resources/terraform-data_

## Provisioners
Provisioners allow you execute command on compute instances eg. a aws cli command .

They are not recommended for use by hashicorp. 

- Hashicorp recommend use only when there are no better inherent resource provided by vendor.
- Terraform cannot track changes to provisioner as they can take independent action.
- configuration managemen tools such as ansible are better fit , but the functionality exists.

[Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### local -exec
This will execute a command on the machine running the terraform command eg. plan and apply.

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}


```

[How to use Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Remote-exec

This will execute command on the machin which you target. You will need to provide credentials such as ssh to get into the machine

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}


```

[remote-exec Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)