BUILD:
	cd docker && \
	docker compose build && \
    docker compose up && \
    echo "Your files should now be available in ./outputs"