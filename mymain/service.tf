provider "aws" {
    region = "us-east-1"
}

module "mymodule" {
  source = "node_modules/mymodule"
  stack_name = "mymain"
}

# You can use
# "${module.mymodule.function_arn}"
# to get the output from the module.