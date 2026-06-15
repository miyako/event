# event
### Callback container for server lifecycle, HTTP download, and system worker events.

> event.new ()

No parameters.

## Description

`cs.event.event` is the central callback hub passed through the module. It defines no-op stubs for every event that the module may fire, so callers only need to override the callbacks they care about. Instances are passed to constructors such as `cs.event.download` and propagated through to `_models` and `_Model`.

Callbacks are grouped into three categories:

### Server lifecycle

| Function | Parameters | Description |
| --- | --- | --- |
| onError | $params : Object; $error : cs.event.error | Fired when a server error occurs (e.g. port already in use, download failure) |
| onSuccess | $params : Object; $models : cs.event.models | Fired when the server has started and all models are loaded |

### HTTPRequest (download progress)

| Function | Parameters | Description |
| --- | --- | --- |
| onData | $request : 4D.HTTPRequest; $event : Object | Fired on each data chunk received during a file download; `This` is the `cs.event.download` instance, so `This.range` reflects current progress |
| onResponse | $request : 4D.HTTPRequest; $event : Object | Fired when a file download completes successfully |

### SystemWorker (server process)

| Function | Parameters | Description |
| --- | --- | --- |
| onStdOut | $worker : 4D.SystemWorker; $params : Object | Fired when the server process emits stdout |
| onStdErr | $worker : 4D.SystemWorker; $params : Object | Fired when the server process emits stderr |
| onTerminate | $worker : 4D.SystemWorker; $params : Object | Fired when the server process terminates |

## Examples

```4d
var $event : cs.event.event
$event:=cs.event.event.new()

$event.onError:=Formula(ALERT($2.message))
$event.onSuccess:=Formula(ALERT($2.models.extract("name").join(",")+" loaded!"))

// Track download progress via This.range on the download instance
$event.onData:=Formula(\
    MESSAGE(This.file.fullName+": "+\
    String((This.range.end/This.range.length)*100; "###.00%")))

$event.onResponse:=Formula(\
    LOG EVENT(Into 4D debug message; This.file.fullName+": download complete"))

$event.onTerminate:=Formula(\
    LOG EVENT(Into 4D debug message; "process "+String($1.pid)+" terminated"))
```

## See also

- [`download`](download.md) — fires `onData` and `onResponse` during file transfers
- [`error`](error.md) — passed as `$error` to `onError`
- [`models`](models.md) — passed as `$models` to `onSuccess`
