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

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store github.com/iamdevtry/go-bank/db/sqlc Store

proto:
	rm -f pb/*.go
	rm -f doc/swagger/*.swagger.json
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
    --go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
	--openapiv2_out=doc/swagger --openapiv2_opt=allow_merge=true,merge_file_name=go_bank \
    proto/*.proto

evans:
	evans --host localhost --port 9090 -r repl

.PHONY: createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock proto evans