# postgres:
# 	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123456 -d postgres

createdb:
	docker exec -it postgres createdb --username=root --owner=root go_bank

dropdb:
	docker exec -it postgres dropdb go_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/go_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/go_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/go_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/go_bank?sslmode=disable" -verbose down 1
sqlc:
	sqlc generate
.PHONY: createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc