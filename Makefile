build:
	@echo "Building application..."
	mkdir -p build
	cp src/hello.py build/

test:
	@echo "Running tests..."
	pytest --junitxml=results/results.xml || true

deploy:
	@echo "Simulating deployment..."
	@echo "Application deployed to staging!"
