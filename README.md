# Gardener Builds

This repo allows container image builds of forks of certain gardener artefacts which require modifications for metal-stack.io compatibility.

This is actually available for:

- https://github.com/metal-stack/gardener.git
- https://github.com/metal-stack/machine-controller-manager.git
- https://github.com/metal-stack/gardener-extension-networking-calico.git

Dashboard and networking-cilium are not yet migrated from gitlab.

To create a container image from a branch of one of the given repositories got to the "Actions" tab, and click on "Docker Build Action" on the left navigation.
You will see a "Run Workflow" pull-down menu on the far right. Add the desired branch into the text field of the component you would like to build.

If the build succeeded, the images will then be available under:

`ghcr.io/metal-stack/gardener-builds/<name of the component>:<branch || sha>`

For new images, they must be set to publicly visible before being able to pull them.