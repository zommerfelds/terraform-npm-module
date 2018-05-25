# Sharing infrastructure modules with Terraform and npm

This is a small demo of how you can share both infrastructure and code pieces with other projects in one single npm package.
In this case we're sharing a simple Lambda that comes pre packaged with some code.

```
Separate projects:
    mymain/    => your main project
    mymodule/  => your shareable AWS Lambda module
```

The main parts to get this to work are:

In your main project's `package.json`:
```
  "dependencies": {
    "mymodule": "your version"
  },
```

In your main projects Terraform file(s):
```
module "mymodule" {
  source = "node_modules/mymodule"
}
```