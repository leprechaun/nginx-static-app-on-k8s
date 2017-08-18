# nginx-static-app-on-openshift

This repo is an attempt at doing something ci-cd like with openshift for a simple static web application.

Because Jenkins isn't perfect, it means I've have to make a couple compromises, most importantly, the split between build and deploy pipelines.

That seperation *is a good thing*, in the sense that I care to be able to deploy any build that ran successfully without having to think about the build step again.

Thing is, I wasn't able to have Jenkins pause a build for user input ("Deploy? Yes/No") without using up a thread *AND* garanteeing using the same source code.

So, by using Openshift to trigger builds, I can specify a commit hash directly. The build step builds it's things, and runs a few tests. The last step is triggering another build, a deployment job to a dev environment. That job deploys, waits until it succeeds (I actually check), then runs a very simplistic E2E test on the new environment (which uses selenium grid).

The files of interest are
- oc-manifests/build-time/ (what we need before building the app)
- oc-manifests/run-time/ (a template containing all the run-time things)

If the build is succesful, I publish the template to openshift, using the app name as well as the git commit hash, and build number part of the name. The build is done.

Then, I trigger a deployment job in the dev environment. This job is useless without parameters and shouldn't be directly used (although it should fail fast if a mistake is made). This job takes the build number and git hash.

It renders the template with the parameters (build number, git hash), and applies it to open shift in a specified namespace/project. Then I tail the ollout logs to make sure it actually works. Should that pass, we run a simple smoke test (curl, for simplicity sake), and then a selenium based test.

This, with zero downtime, provided liveness and readiness probes are correctly configured.
