### Run mongo DB

#### Make an .env file first with this data
```
CURRENT_PWD='path_to_main_dir'
```

```bash
sudo docker run -dp 27017:27017 -v ${CURRENT_PWD}mongodb_data:/data/db --name mongodb --restart=always mongo:latest
```

### SSH to mongoDB Docker
```bash
sudo docker exec -it mongodb bash
```

### check if you have the correct volume
```bash
sudo find / -type d -name "mongodb_data" 2>/dev/null
```

### Allow 27017 port
```bash
sudo ufw status
sudo ufw allow 27017/tcp
sudo ufw reload
sudo ufw status
```

# MongoDB CLI and Cheat Sheet

## Running Mongo CLI
To start the MongoDB shell (`mongosh`), use the following command:
```bash
mongosh
```

## Useful Resources
- [MongoDB Cheat Sheet](https://www.mongodb.com/developer/products/mongodb/cheat-sheet/)
- [MongoDB Queries YouTube Tutorial](https://www.youtube.com/watch?v=ofme2o29ngU)

## Common MongoDB Commands
- **Clear screen:** `cls`
- **Show databases:** `show dbs`
- **Use/create a database:** `use db_name`
  - Note: The database won't actually exist until data is inserted into it.
- **Show collections (tables) in the current database:** `show collections`
- **Exit MongoDB shell:** `exit`

### Database Commands
- **Drop the current selected database:**
  ```javascript
  db.dropDatabase()
  ```

### Document Operations
- **Insert one document:**
  ```javascript
  db.users.insertOne({name: "john"})
  db.users.insertOne({name: "john", age: 22, job: ["basketball player", "shoe maker"]})
  ```

- **Insert multiple documents:**
  ```javascript
  db.users.insertMany([{name: "john"}, {name: "jill"}])
  ```

### Querying Documents
- **Find all documents but limit to 2:**
  ```javascript
  db.users.find().limit(2)
  ```

- **Sort documents alphabetically by name:**
  ```javascript
  db.users.find().sort({name: 1})
  ```

- **Sort documents in reverse order by name:**
  ```javascript
  db.users.find().sort({name: -1})
  ```

- **Sort documents alphabetically by name and limit to 2:**
  ```javascript
  db.users.find().sort({name: 1}).limit(2)
  ```

- **Sort documents by age and name, then limit to 2:**
  ```javascript
  db.users.find().sort({age: 1, name: 1}).limit(2)
  ```

- **Skip the first document and limit to 3:**
  ```javascript
  db.users.find().sort({age: 1, name: 1}).skip(1).limit(3)
  ```

- **Find documents where the name is "john":**
  ```javascript
  db.users.find({name: "john"})
  ```

- **Find documents where the name is "john", only include the name field:**
  ```javascript
  db.users.find({name: "john"}, {name: 1})
  ```

- **Find documents where the name is "john", only exclude the name field:**
  ```javascript
  db.users.find({name: "john"}, {name: 0})
  ```

- **Find documents where the name is "john", exclude the _id field:**
  ```javascript
  db.users.find({name: "john"}, {name: 1, _id: 0})
  ```

- **Find documents where the name equals "john":**
  ```javascript
  db.users.find({name: {$eq: "john"}})
  ```

- **Find documents where the name is not equal to "john":**
  ```javascript
  db.users.find({name: {$ne: "john"}})
  ```

- **Find documents where age is greater than 13:**
  ```javascript
  db.users.find({age: {$gt: 13}})
  ```

#### Comparison Operators
- **Greater than or equal to:** `$gte`
- **Less than:** `$lt`
- **Less than or equal to:** `$lte`

- **Find documents where the name is in the provided list:**
  ```javascript
  db.users.find({name: {$in: ["john", "jill"]}})
  ```

- **Find documents where the name is not in the provided list:**
  ```javascript
  db.users.find({name: {$nin: ["john", "jill"]}})
  ```

- **Find documents where the age field exists:**
  ```javascript
  db.users.find({age: {$exists: true}})
  ```

#### Logical Operators
- **Use $and for multiple parameters:**
  ```javascript
  db.users.find({$and: [{age: 25}, {name: "john"}]})
  ```

- **Use $or for multiple parameters:**
  ```javascript
  db.users.find({$or: [{age: 25}, {name: "john"}]})
  ```

- **Use $not for negation:**
  ```javascript
  db.users.find({age: {$not: {$gte: 25}}})
  ```

### Advanced Queries
- **Find documents based on an expression:**
  ```javascript
  db.monthlyBudget.find({
    $expr: {
      $gt: ["$spent", "$budget"]
    }
  })
  ```

- **Find documents with a nested field:**
  ```javascript
  db.users.find({"address.street": "123 main st."})
  ```