# "Pine" Archiver
## Issue

We have an application named "Pine".
"Pine" runs in a kubernetes cloud inside a pod

As "Pine" serves traffic, it produces various logs and reports as files that must be archived in remote storage.

## Requirements

Write a program that will:

- Watch over some directories and will handle files that match certain criteria.
- The program should upload and archive them to remote storage.
- The output of the program should be a summary of all files processed.
- The program should be containerized so that it could be implemented as a side car to "Pine".

## Assumptions

- Any tool needed can be added to the executor.

## Additional Features

- Files should be placed into a remote folder composed of the current date (e.g. s3://my-bucket/2022/01/01).
- The program should be able to run continuously.
- The program should be able to handle upload failures.
- The program should be able to process files serially but ideally with concurrency and in a batching fashion.

## Considerations

- Program flow and outline
- Testability
- Error handling

# Jeremy's Notes
So, I want to make a sidecar to a pod I know nothing about, have it share a filesystem, and upload files somewhere (example is S3 but I don't have a personal AWS account and don't wanna bother setting one up for this, so... TBD).

## Why would I do it this way?
I dunno. I would probably add this feature natively as part of the application, rather than making it a sidecar.
If I care about logs, I'd like my application to care about logs, and not add some feature in Kubernetes after the fact.
(I don't think "the ability to toggle caring about logs" by just removing the sidecar is valid, because you could just as easily make that a toggle in the application.)
But maybe I just want want to use off-the-shelf software as much as possible.
That's the only reasoning that feels satisfying to me, so I'll use it as my justification.

## Share FS
My initial thought was a `PV`, but it turns out you can just [share the whole filesystem](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/), so I guess I'm doing that to avoid requiring "pine" to use a PV / EmptyDir / whatever, since I don't know anything about it.

## Where am I archiving to?
The example mentions S3, but I don't wanna do that, because I don't have a personal AWS account.
I could make a pod in Kubernetes that's running a PV and say "this could be anything", which is... probably true.
How do I want to connect to that?
Could `POST` the file, could `scp` the file, could do `rsync` stuff (but I don't remember how `rsync` handles deletes and don't feel like learning how to make that run continuously), could do SFTP.
I like SFTP, I've used ... some python library for it before, let's go with that unless the log watcher thing I find has opinions.

### SFTP Deployment
I asked Google.
Google gave me [this](https://gist.github.com/jujhars13/1e99cf110e5df39d4ae3c7fef81589f8).
Sure.

## When do I archive a file?
It's unclear, but it looks like I'm supposed to expect completed files, not a file that gets continually written to (so the application can move finished files to some directory for upload but can't upload them itself?).
I'm going to assume I care about only completed, finished files.
(How do I know if they're finished? I could be watching for a [tombstone](https://www.quora.com/Some-authors-use-a-solid-square-punctuation-after-period-to-mark-the-end-of-an-article-e-g-Economist-magazine-what-is-this-style-called) on the file, but let's just assume that's unnecessary.)

## Off-the-shelf components
So... if people can do this in a half hour, they can't be writing their own log watcher application (though that would be fun), so let's see what the options are.

### FluentD
Kubernetes [has a specific example](https://kubernetes.io/docs/concepts/cluster-administration/logging/) on sidecar logging via FluentD, so that's probably good enough.

FluentD seems focused on log streaming, not file upload.
That's ... not really what I want, given my assumptions above.

Alright, I got bored searching for an off-the-shelf thing, how difficult would it be to do this in bash?

## Bash script
Well, you can [`sftp` from bash](https://stackoverflow.com/questions/5386482/how-to-run-the-sftp-command-with-a-password-from-bash-script), and you can [watch files in bash](https://unix.stackexchange.com/a/24955/257010), so... that sounds pretty quick.

[Here's](https://unix.stackexchange.com/a/323919/257010) exactly what I want `inotifywait` to do, nice.

#### How do I test it?
Ugh, I never learned [BATS](https://github.com/sstephenson/bats).
I guess a helm test is the best method?
... That sounds wrong. TBD.
