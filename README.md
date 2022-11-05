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
