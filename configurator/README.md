# "Pine" Configurator

## Issue

We have an application named "Pine".
"Pine" has deployment pipeline that builds, publishes and deploys "Pine" onto some target environment (e.g. QA, Production).

The user will launch the pipeline with a set of parameters (e.g. the environment name).
The deployment stage in the pipeline uses a tool that will be expecting a configuration for "Pine".

We will need to create this configuration; which in turn will be piped to the deployment tool downstream.

## Assumptions

The application has a root configuration file (/config/config.yaml) which serves as the default and also as the definition or schema.

Additional configuration files AKA "snippets" (/config/config.\*.yaml) control various aspects of the application.

Configuration profiles (/profiles/profile.\*.yaml) are a set of files that specify which "snippets" should be used to create a particular environment configuration.

The user may also request for some additional "snippets" to be included that may not be already listed within the profile.

## Requirements

Write a program that will receive as input:

- Mandatory: a profile name
- Optional: additional list of "snippets"

e.g.
./configurator --profile qa --snippets logging,logging.warn

The program should read the profile configuration, load all necessary snippets and merge them into a single configuration that would be returned to the standard output.

## Additional Features

- Support templating and value substitutions.
- Securing sensitive data.
- Error detection and prevention.

## Considerations

- Program flow and outline
- Testability
- Error handling
