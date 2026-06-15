# huggingfaces
### A typed collection of `huggingface` instances.

> huggingfaces.new (huggingfaces : Collection)

| Parameter | Type | | Description |
| --- | --- | --- | --- |
| huggingfaces | Collection | -> | Collection of `cs.event.huggingface` instances |

## Description

`cs.event.huggingfaces` is a thin wrapper around a collection of `cs.event.huggingface` objects. The constructor filters the input, retaining only elements that are genuine `cs.event.huggingface` instances. Pass an empty collection `[]` when using router mode (where models are defined via an INI file or directory rather than individual descriptors).

The internal collection is consumed destructively by `_models` during initialization — each entry is shifted off the front as it is processed.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| huggingfaces | Collection | Filtered collection of `cs.event.huggingface` instances |

## Examples

```4d
var $hf1 : cs.event.huggingface
$hf1:=cs.event.huggingface.new(\
    Folder(fk home folder).folder(".GGUF/model-a"); \
    "org/model-a-GGUF"; \
    "model-a-Q4_K_M.gguf"; ""; "")

var $hf2 : cs.event.huggingface
$hf2:=cs.event.huggingface.new(\
    Folder(fk home folder).folder(".GGUF/model-b"); \
    "org/model-b-GGUF"; \
    "model-b-Q4_K_M.gguf"; ""; "")

var $huggingfaces : cs.event.huggingfaces
$huggingfaces:=cs.event.huggingfaces.new([$hf1; $hf2])
```

## See also

- [`huggingface`](huggingface.md) — individual entries in the collection
