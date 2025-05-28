backend_build:
	docker build -t django-backend ./backend

backend_run:
	docker run -p 8000:8000 django-backend

# frontend_build:
# frontend_run:

production_up:
	docker-compose up --build

production_down:
	docker-compose down -v