FROM surrealdb/surrealdb:latest

COPY ./schema.surql .

CMD ["start", "-u", "root", "-p", "root"]