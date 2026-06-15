# model
### Describes a single loaded model.

> model.new (name : Text; isHuggingFace : Boolean)

| Parameter | Type | | Description |
| --- | --- | --- | --- |
| name | Text | -> | Model name or file name |
| isHuggingFace | Boolean | -> | `True` if the model was sourced from Hugging Face and is not yet present on disk |

## Description

`cs.event.model` is a lightweight value object representing one entry in a loaded models list. It is constructed internally by `_Model.models()` and collected into a `cs.event.models` instance that is passed to `event.onSuccess`.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| name | Text | Model name |
| isHuggingFace | Boolean | `True` when the model file does not yet exist locally (i.e. still to be downloaded) |

## See also

- [`models`](models.md) — collects one or more `model` instances
- [`event`](event.md) — `onSuccess` receives a `models` collection containing `model` entries
