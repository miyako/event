# error
### Represents an error raised during server startup or model download.

> error.new (code : Integer; message : Text; models : cs.event.models)

| Parameter | Type | | Description |
| --- | --- | --- | --- |
| code | Integer | -> | Numeric error code |
| message | Text | -> | Human-readable error description |
| models | cs.event.models | -> | Models collection at the time of the error |

## Description

`cs.event.error` is a simple value object passed as the `$error` argument to `event.onError`. It captures a code, a message, and a snapshot of the models collection at the time the error occurred.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| code | Integer | Numeric error code |
| message | Text | Human-readable error description |
| models | Collection | Raw models array extracted from the supplied `cs.event.models` instance |

## Examples

```4d
$event.onError:=Formula(\
    LOG EVENT(Into 4D debug message; \
    "Error "+String($2.code)+": "+$2.message))
```

## See also

- [`event`](event.md) — `onError` receives an `error` instance as `$2`
- [`models`](models.md) — source of the `models` snapshot
