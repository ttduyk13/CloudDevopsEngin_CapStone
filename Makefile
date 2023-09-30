## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	pip install --no-cache-dir --upgrade pip==21.3.1 &&\
		pip install -r requirements.txt &&\
		wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Linux-x86_64 &&\
		chmod +x /bin/hadolint

test:
	# Additional, optional, tests could go here
	python -m pytest -vv --cov=myrepolib tests/*.py
	python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	@if test -f Dockerfile ; then\
		cat Dockerfile;\
		hadolint Dockerfile;\
	else\
		echo "Dockerfile doesn't found"\
		exit 0;\
	fi

	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	@if test -f ./app/app.py ; then\
		pylint --disable=R,C,W1203,W1202 ./app/app.py;\
	else\
		echo "appp.py doesn't found";\
		ls -l app;\
		exit 0;\
	fi

all: install lint test
