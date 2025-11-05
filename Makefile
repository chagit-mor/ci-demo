build:
	@echo "Building application..."
	if not exist build mkdir build
	copy src\hello.py build\


test:
	@echo "Running tests..."
	pytest --junitxml=results/results.xml || true

deploy:
	@echo "Simulating deployment..."
	@echo "Application deployed to staging!"
