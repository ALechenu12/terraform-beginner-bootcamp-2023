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


### Loading Variables
