# Kitura Threading Sample

This sample demonstrates the behaviour of a Titan app when used on a threaded web server like Kitura. Additionally, it demonstrates the manner in which resources can be correctly shared, depending on their thread safety, between requests.

## Getting started

As with all of the other samples in this repository, `swift build` works fine on a Mac, but realistically Titan should be running on a Linux environment. The virtualization to achieve this is using the provided Dockerfile. If you aren't comfortable with Docker, `./script/run.sh` will do this for you.
