#I will demonstrate creating a simple build pipeline using a Makefile for our Overlap Detection API Service. This pipeline will cover the following steps:

# 1. Building/Compiling the utility
# 2. Running the test suite
# 3. Producing a runtime artifact
# Create a file named Makefile in the project's root directory with the following content:


.PHONY: clean build test package

build: clean
	@echo "Creating a virtual environment"
	python -m venv venv
	@echo "Activating the virtual environment"
	source venv/bin/activate
	@echo "Installing dependencies"
	pip install -r requirements.txt
	@echo "Build complete"

test: build
	@echo "Running tests"
	pytest
	@echo "Tests complete"

package: test
	@echo "Building a Docker image"
	docker build -t yourusername/overlap-detection-api .
	@echo "Docker image created"

clean:
	@echo "Cleaning up virtual environment and build artifacts"
	rm -rf venv


# The first line of the Makefile is a special line that tells make that the clean, build, test, and package targets are not files. This is important because make will try to build a file named clean, build, test, and package if we don't tell it otherwise. The .PHONY line tells make that these targets are not files.

# This Makefile defines four targets: clean, build, test, and package. Here's an explanation of each target:

# 1. clean: Removes the virtual environment and any build artifacts.
# 2. build: Creates a virtual environment, installs dependencies, and compiles the utility (the Python code doesn't require compilation, but this step ensures the virtual environment and dependencies are set up correctly).
# 3. test: Runs the test suite using pytest.
# 4. package: Builds a Docker image for the API service.

# To run the build pipeline, execute the following command in your terminal:

make package

# This command will run the targets in the following order: clean → build → test → package. As a result, it will clean up the environment, set up the dependencies, run the tests, and finally produce a runtime artifact in the form of a Docker image.

# In a continuous integration (CI) environment, you can integrate this Makefile into your CI pipeline using tools like Jenkins or GitHub Actions. The CI pipeline will automatically execute the make package command whenever changes are pushed to the repository, ensuring the application is always tested and ready for deployment.
