# Sharing infrastructure modules with Terraform and npm

This is a small demo of how you can share both infrastructure and code pieces with other projects in one single npm package.
In this case we're sharing a simple AWS Lambda that comes pre packaged with some code.

NOTE: You should also check out the [Terraform registry](https://www.terraform.io/docs/registry/modules/publish.html). npm might be useful if you already have a private repository set up or don't want to deal with a separate registry.

More info: https://www.terraform.io/docs/modules/create.html

```
Demo directories:
    mymain/    => this would be your main project
    mymodule/  => this would be a separate project that is published to npm
```

## How does it work

Below is a summary of how sharing an infrastructure package with Lambda works:

### Set paths properly for non-TF files

In your shareable module's TF file(s), use `path.module` to access additional files. Relative paths don't work.
```
filename = "${path.module}/code.zip"
```

### Package and publish your module

Make sure the additional files (e.g. code ZIP package) for your module are included in the published npm package. You should likely setup an automated pipeline for building, packaging and publishing your module. In this demo we have an overly simple manual script [`mymodule/build.sh`](mymodule/build.sh) that is run before publishing.

In your shareable module's `package.json`:
```
"scripts": {
    "prepublishOnly": "bash ./build.sh"
}
```

### Specify your dependency

In your main project's `package.json`:
```
"dependencies": {
    "mymodule": "your version"
}
```

### Use the dependency

In your main projects Terraform file(s):
```
module "mymodule" {
    source = "node_modules/mymodule"
}
```
