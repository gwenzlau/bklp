# Discussions API

## Get all discussions for a book

#### GET `/api/book/:goodreads_id/discussions`

### Successful response

```json
{
    "success": true,
    "discussions": [{
        "id": 1,
        "book_id": 15847933,
        "quote": "Some random quote",
        "page": 14,
        "pages_total": 147,
        "created_at": "2013-11-23T11:25:45.700Z",
        "comments": [{
            "id": 3,
            "message": "Totally agree dude.",
            "created_at": "2013-11-23T11:53:59.555Z",
            "user": {
                "id": 1,
                "name": "Pete",
                "avatar_url": "https://s3.amazonaws.com/bklp/guest.png"
            }
        }]
    }]
}
```

## Get a single discussion for a book

#### GET `/api/book/:goodreads_id/discussions/:id`

### Successful response

```json
{
    "success": true,
    "discussion": {
        "id": 1,
        "book_id": 15847933,
        "quote": "Some random quote",
        "page": 14,
        "pages_total": 147,
        "comments": [{
            "id": 3,
            "message": "Totally agree dude.",
            "user": {
                "id": 1,
                "name": "Pete",
                "avatar_url": "https://s3.amazonaws.com/bklp/guest.png"
            }
        }]
    }
}
```

## Create a discussion

#### POST `/api/book/:goodreads_id/discussions`

### Params

* **quote** - The quote you want to comment on
* **page** - The page of the book the quote appears on
* **pages_total** - The total number of pages in your copy of the book

### Error response

```json
{
    "success": false,
    "errors": {
        "page": [
            "can't be blank"
        ],
        "pages_total": [
            "can't be blank"
        ]
    },
    "discussion": {
        "id": null,
        "quote": "Some random quote",
        "page": null,
        "pages_total": null,
        "book_id": 15847933,
        "created_at": null,
        "updated_at": null
    }
}
```

### Successful response

```json
{
    "success": true,
    "discussion": {
        "id": 1,
        "quote": "Some random quote",
        "page": 14,
        "pages_total": 147,
        "book_id": 15847933,
        "created_at": "2013-11-23T11:25:45.700Z",
        "comments": []
    }
}
```
