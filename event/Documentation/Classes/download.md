# download
### Downloads a file from Hugging Face over HTTP, with optional range-request chunking and progress callbacks.

> download.new (that : Object; file : 4D.File; folder : 4D.Folder; oid : Text; URL : Text; options : Object; formula : 4D.Function; event : cs.event.event; onDownload : 4D.Function)

| Parameter | Type | | Description |
| --- | --- | --- | --- |
| that | Object | -> | Owning `_Model` instance; passed as `This` when `onDownload` is called |
| file | 4D.File | -> | Local destination file |
| folder | 4D.Folder | -> | Parent folder; created automatically if it does not exist |
| oid | Text | -> | Hugging Face object ID; passed to `onDownload` on completion |
| URL | Text | -> | Full download URL |
| options | Object | -> | Options object; `HF_TOKEN` is read for Bearer auth; `onTerminate`, `onStdErr`, `onStdOut` are forwarded to the event |
| formula | 4D.Function | -> | Internal response callback fired on success or failure (used by `_models`) |
| event | cs.event.event | -> | Callback container for progress and completion events |
| onDownload | 4D.Function | -> | Called on `that` when the download completes, passing `oid` |

## Description

`cs.event.download` manages the full lifecycle of downloading a single file. The constructor configures a `4D.HTTPRequest`-compatible object (method, headers, buffer size, agent) but does not start the transfer — call `head()` to begin.

Downloads are initiated with a `HEAD` request to determine content length and range support. If the server supports `Accept-Ranges: bytes`, the file is fetched in chunks of `bufferSize` (default 10 MB) using successive `Range` requests. Otherwise a single `GET` is issued. In both cases data is written incrementally to a `4D.FileHandle` opened on `file`.

If `file` already exists but its size differs from `content-length`, it is deleted before the download begins. If sizes match the download is skipped and `formula` is called directly.

An `HF_TOKEN` in `options` is sent as a `Bearer` authorization header, enabling access to gated models.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| that | Object | Owning `_Model` instance |
| file | 4D.File | Destination file |
| folder | 4D.Folder | Destination folder |
| URL | Text | Download URL |
| oid | Text | Hugging Face object ID |
| onDownload | 4D.Function | Completion callback |
| options | Object | Merged options |
| bufferSize | Integer | Chunk size in bytes (default: 10 485 760 — 10 MB) |
| range | Object | Progress state: `{start, end, length, ranges}` |
| method | Text | Current HTTP method (`"HEAD"` or `"GET"`) |
| dataType | Text | `"blob"` |
| automaticRedirections | Boolean | `True` |
| returnResponseBody | Boolean | `False` |
| decodeData | Boolean | `False` |
| headers | Object | Request headers (includes `Range` during chunked downloads) |
| event | cs.event.event | Callback container |
| agent | Object | `4D.HTTPAgent` with `keepAlive: False` (when available) |

### Methods

#### head ()

Starts the download. Issues a `HEAD` request to probe the server, then opens the destination file for writing and begins the first (or only) `GET` request. This is the only method called by application code; subsequent requests are issued automatically by `onResponse`.

### Event callbacks

These methods conform to the `4D.HTTPRequest` callback interface and are set on the request object automatically.

#### onData ($request : 4D.HTTPRequest; $event : Object)

Writes each incoming blob chunk to the file handle. Updates `range.end` and `range.length` for simple (non-chunked) downloads. Forwards to `event.onData` if an `event` is present — `This` inside that callback is the `download` instance, so `This.range` can be used to report progress:

```4d
$event.onData:=Formula(\
    MESSAGE(This.file.fullName+": "+\
    String((This.range.end / This.range.length)*100; "###.00%")))
```

#### onResponse ($request : 4D.HTTPRequest; $event : Object)

Handles HTTP 200 (simple GET) or 200/206 (ranged GET). For chunked downloads issues the next range request until the file is complete. On completion closes the file handle, calls `event.onResponse`, then calls `onDownload` on `that` with `oid`.

#### onError ($request : 4D.HTTPRequest; $event : Object)

Calls `formula` with `{success: False}`, closes and deletes the partial file.

#### onTerminate ($request : 4D.HTTPRequest; $event : Object)

No-op stub.

## See also

- [`event`](event.md) — supplies `onData`, `onResponse`, and `onTerminate` callbacks
- [`huggingface`](huggingface.md) — provides the URL and path resolved into a download
