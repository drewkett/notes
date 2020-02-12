# Build Agents

## Hosted

Basic agent functionality is freely available

## Self Running

Haven’t tried it but supposedly just install the software and authorize it

[Deploy a build and release agent on Windows - Azure Pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows)

# Authorization Error

[https://docs.microsoft.com/en-us/azure/devops/pipelines/process/resources?view=azure-devops&viewFallbackFrom=vsts#troubleshooting-authorization-for-a-yaml-pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/resources?view=azure-devops&viewFallbackFrom=vsts#troubleshooting-authorization-for-a-yaml-pipeline)

Weird error where private pools only are authorized when setting them up using the GUI on the website. So if you use azure-pipelines.yml you need to first set it up in the GUI to authorize it

# Service

    The VSTS Agent (sieinc.SIE64-53) service terminated with the following error: 
    Incorrect function.

This is a permissions error. The default service install uses NETWORK SERVICE account. That needs access to the agent folder. The agent folder also didn't succeed when put inside a user account

Use this to run a cmd prompt as the user that that service uses. Useful for setting up build tools for rust or python

    psexec -i -u "nt authority\network service" cmd.exe

# Tools

[Microsoft/azure-pipelines-tool-lib](https://github.com/Microsoft/azure-pipelines-tool-lib/blob/master/docs/overview.md#tool-cache)

[https://s3-us-west-2.amazonaws.com/secure.notion-static.com/94cda71a-3de1-4b8b-8e77-5ebb9c67c1a8/Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/94cda71a-3de1-4b8b-8e77-5ebb9c67c1a8/Untitled)

Got it to work by using winpython installation. And then renaming the python-* folder inside to x64 and putting it at the appropriate location. Then had to install virtualenv to that installation. Though that could be done by build job as well

Not sure how to control whats in the environment variables for tools. Probably need to run step to set up environment variable in some way

# Build yaml

## Triggers

Add triggers to limit number of builds done. Turning on branch protection for pull requests, will run the tests on branch commits anyway

[Build pipeline triggers - Azure Pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/build/triggers?view=azure-devops&tabs=yaml)

# Rust

For rust builds, specify CARGO_TARGET_DIR so it doesn't have to do a full build from scratch everytime