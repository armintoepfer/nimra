import os, strutils

type
    Record = tuple[name : string, bases : string]

proc parse_fasta_file(filename : string) : seq[Record] =
    if not existsFile filename:
        quit("Provided fasta file does not exist: " & filename)

    var records : seq[Record] = @[]

    for line in lines filename:
        if line[0] == '>':
            records.add((name: line, bases: ""))
        else:
            records[records.len-1].bases &= line

    result = records

proc main() =
    if paramCount() < 1:
        quit("synopsis: " & getAppFilename() & " filename.fasta")

    let
        filename = paramStr(1)
        records = parse_fasta_file(filename)

    for r in records:
        echo "$1\t$2" % [r.name, r.bases]

main()