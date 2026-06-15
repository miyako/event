# huggingface
### Describes a single Hugging Face model repository and the file(s) to download from it.

> huggingface.new (model : Object; URL : Text; paths : Text | Collection; domain : Text; name : Text)

| Parameter | Type | | Description |
| --- | --- | --- | --- |
| model | 4D.Folder \| 4D.File | -> | Local destination — a `4D.Folder` for the repository root, or a `4D.File` for a single file target |
| URL | Text | -> | Hugging Face repository identifier — either a full `https://huggingface.co/user/repo` URL or a short `user/repo` path |
| paths | Text \| Collection | -> | One or more file paths within the repository to download (empty strings are ignored) |
| domain | Text | -> | Optional domain tag used to annotate resolved file metadata |
| name | Text | -> | Optional display name for the model |

## Description

`cs.event.huggingface` is a value object that carries all the information needed to locate and download one model (or a set of related files) from Hugging Face. One or more instances are collected into a `cs.event.huggingfaces` and passed to the module entry point.

`paths` accepts either a single file path string or a collection of strings. Non-string and empty-string entries are silently discarded. The `path` computed property always returns the first element of the resolved paths list.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| folder | 4D.Folder \| 4D.File | Local destination (folder for a repo, file for a single download) |
| URL | Text | Repository URL or `user/repo` identifier |
| paths | Collection | Resolved list of file paths to download |
| domain | Text | Domain tag for resolved file metadata |
| name | Text | Display name |

### Computed properties

#### get path () → Text

Returns the first entry in `paths`, or an empty string if `paths` is empty. Convenience accessor for single-file descriptors.

## Examples

```4d
// Single GGUF file from a repository
var $huggingface : cs.event.huggingface
$huggingface:=cs.event.huggingface.new(\
    Folder(fk home folder).folder(".GGUF/Llama-3.2-3B-Instruct-Q4_K_M"); \
    "hugging-quants/Llama-3.2-3B-Instruct-Q4_K_M-GGUF"; \
    "Llama-3.2-3B-Instruct-Q4_K_M.gguf"; \
    ""; "")

// Multiple files from the same repository
$huggingface:=cs.event.huggingface.new(\
    Folder(fk home folder).folder(".GGUF/my-model"); \
    "org/my-model-GGUF"; \
    ["my-model-Q4_K_M.gguf"; "my-model-Q8_0.gguf"]; \
    ""; "")
```

## See also

- [`huggingfaces`](huggingfaces.md) — typed collection of `huggingface` instances
