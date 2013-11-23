# Discussions Comments API

## Create a comment

#### POST `/api/book/:goodreads_id/discussions/1/commentaries`

### Params

* **message** - The comment you want to leave

### Error response

```json
{
    "success": false,
    "errors": {
        "message": [
            "can't be blank"
        ]
    },
    "commentary": {
        "id": null,
        "message": null,
        "discussion_id": 1,
        "user_id": 1,
        "created_at": null,
        "updated_at": null
    }
}
```

### Successful response

```json
{
    "success": true,
    "commentary": {
        "id": 1,
        "message": "Some random comment",
        "discussion_id": 1,
        "user_id": 1,
        "created_at": "2013-11-23T11:25:45.700Z",
        "updated_at": "2013-11-23T11:25:45.700Z"
    }
}
```

## Update a comment

#### PATCH `/api/book/:goodreads_id/discussions/1/commentaries/1`

### Params

* **message** - The comment you want to leave

### Error response

```json
{
    "success": false,
    "errors": {
        "message": [
            "can't be blank"
        ]
    },
    "commentary": {
        "id": 1,
        "message": "Some old message",
        "discussion_id": 1,
        "user_id": 1,
        "created_at": "2013-11-23T11:25:45.700Z",
        "updated_at": "2013-11-23T11:25:45.700Z"
    }
}
```

### Successful response

```json
{
    "success": true,
    "commentary": {
        "id": 1,
        "message": "Some new comment",
        "discussion_id": 1,
        "user_id": 1,
        "created_at": "2013-11-23T11:25:45.700Z",
        "updated_at": "2013-11-23T11:25:45.700Z"
    }
}
```

## Delete a comment

#### DELETE `/api/book/:goodreads_id/discussions/1/commentaries/1`

### Error response

```json
{
    "success": false,
    "error": "You don't have permission to delete this comment"
}
```

### Successful response

```json
{
    "success": true,
    "commentary": {
        "id": 1,
        "message": "Some new comment",
        "discussion_id": 1,
        "user_id": 1,
        "created_at": "2013-11-23T11:25:45.700Z",
        "updated_at": "2013-11-23T11:25:45.700Z"
    }
}
```
