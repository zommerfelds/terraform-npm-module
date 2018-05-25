# Sharing infrastructure modules with Terraform and npm

This is a small demo of how you can share both infrastructure and code pieces with other projects in one single npm package.
In this case we're sharing a simple AWS Lambda that comes pre packaged with some code.

NOTE: You should also check out the [Terraform registry](https://www.terraform.io/docs/registry/modules/publish.html). npm might be useful if you already have a private repository set up or don't want to deal with a separate registry.

```
Demo directories:
    mymain/    => this would be your main project
    mymodule/  => this would be a separate project that is published to npm
```

## How does it work

Below is a summary of how sharing an infrastructure package with Lambda works:

In your main project's `package.json`:
```
"dependencies": {
    "mymodule": "your version"
}
```

In your main projects Terraform file(s):
```
module "mymodule" {
    source = "node_modules/mymodule"
}
```

And lastly, you need to make sure the code ZIP file for your module is included in the published npm package. You should likely setup an automated pipeline for building, packaging and publishing your module. In this demo we have an overly simple manual script [`mymodule/build.sh`](mymodule/build.sh) that is run before publishing.

In your shareable module's `package.json`:
```
"scripts": {
    "prepublishOnly": "bash ./build.sh"
}
```