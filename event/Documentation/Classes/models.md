# models
### A typed collection of `model` instances.

> models.new (models : Collection)

| Parameter | Type | | Description |
| --- | --- | --- | --- |
| models | Collection | -> | Collection of `cs.event.model` instances |

## Description

`cs.event.models` is a thin wrapper around a collection of `cs.event.model` objects. The constructor filters the input, retaining only elements that are genuine `cs.event.model` instances. It is passed as `$models` to `event.onSuccess` and as the source of the models snapshot in `cs.event.error`.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| models | Collection | Filtered collection of `cs.event.model` instances |

## Examples

```4d
$event.onSuccess:=Formula(\
    var $names : Collection
    $names:=$2.models.extract("name")
    ALERT($names.join(", ")+" loaded!"))
```

## See also

- [`model`](model.md) — individual entries in the collection
- [`event`](event.md) — `onSuccess` receives a `models` instance as `$2`
- [`error`](error.md) — stores the raw `models` array at error time
