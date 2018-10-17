# kr8-configs
A repo containing example configuration and layout for kr8

## Pre-requisites

Install kr8:


Install kubecfg and jsonnet:

```
brew install kubecfg jsonnet
```

Install task:

```
brew install go-task/tap/go-task
```


## Using

Clone this repository.

Add the ./bin directory to your path

Set the environment variable KR8_BASE to the root of this repository. Example

```
export KR8_BASE=~/kr8-configs
```

Run this script to create the main Taskfile.yml in the base directory

```
bin/update-main-taskfile
```

Generate all components in all clusters

```
task
```

List individual cluster tasks

```
task -l
```

Generates components for cluster

```
task <clustername>
```

You can also use the helper script `bin/generate` to automatically generate manifests
