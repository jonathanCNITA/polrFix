help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## [docker] initialize the project
	chmod -R a+wX storage
	composer install
	php artisan migrate
	php artisan geoip:update

devFilePerm: ## [host] fix right
	sudo setfacl -R  -m u:$(USER):rwX ./
	sudo setfacl -dR -m u:$(USER):rwX ./

bash: ## [host] opens a bash in the web container
	docker-compose exec web bash

