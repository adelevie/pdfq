# pdfq

A lightweight library that sits between ['pdftk'](https://www.pdflabs.com/tools/pdftk-server/) and [`jq`](https://stedolan.github.io/jq/manual/).

`pdfq` receives via stdin the output of `pdftk`'s `dump_data_fields` command and outputs it as JSON.

## Synopsis

These examples use [SF-1424](http://www.gsa.gov/portal/forms/download/115830).

```bash
$ pdftk SF-1424.pdf dump_data_fields | pdfq
[
  {
    "FieldType": "Text",
    "FieldName": "form1[0].#subform[0].item20[0]",
    "FieldNameAlt": "20. ITEM DESCRIPTION",
    "FieldFlags": "8388608",
    "FieldJustification": "Left"
  },
  {
    "FieldType": "Text",
    "FieldName": "form1[0].#subform[0].item21[0]",
    "FieldNameAlt": "21. ITEM DESCRIPTION",
    "FieldFlags": "8388608",
    "FieldJustification": "Left"
  },
  {
    "FieldType": "Text",
    "FieldName": "form1[0].#subform[0].SUBCONTRACTNUMBER[0]",
    "FieldNameAlt": "9. SUBCONTRACT NUMBER",
    "FieldFlags": "8388608",
    "FieldJustification": "Left"
  },
  ...
]
```

With this JSON, we can pipe that output into `jq`, a CLI for manipulating JSON:

```bash
$pdftk SF1424-15.pdf dump_data_fields | pdfq | jq '.[0]'                   
{
  "FieldType": "Text",
  "FieldName": "form1[0].#subform[0].item20[0]",
  "FieldNameAlt": "20. ITEM DESCRIPTION",
  "FieldFlags": "8388608",
  "FieldJustification": "Left"
}
$ pdftk SF1424-15.pdf dump_data_fields | pdfq | jq '.[1]'
{
  "FieldType": "Text",
  "FieldName": "form1[0].#subform[0].item21[0]",
  "FieldNameAlt": "21. ITEM DESCRIPTION",
  "FieldFlags": "8388608",
  "FieldJustification": "Left"
}
$ pdftk SF1424-15.pdf dump_data_fields | pdfq | jq '.[2]'
{
  "FieldType": "Text",
  "FieldName": "form1[0].#subform[0].SUBCONTRACTNUMBER[0]",
  "FieldNameAlt": "9. SUBCONTRACT NUMBER",
  "FieldFlags": "8388608",
  "FieldJustification": "Left"
}
```

## Installation

See latest [release](https://github.com/adelevie/pdfq/releases).

Download the appropriate binary and add it to your path.

## Development

Prerequisites:

- Docker
- docker-compose
- mruby-cli

`pdfq` is built using [`mruby`](https://github.com/mruby/mruby) and the [`mruby-cli`](https://github.com/hone/mruby-cli).

The `mruby-cli` is used to create the project skeleton and build toolchain.

To modify, run, and test `pdfq`, please refer to the [`mruby-cli` README](https://github.com/hone/mruby-cli/blob/master/README.md). However, here's a basic summary:

### Modifying

Right now everything is in `mrblib/pdfq.rb`.

### Running

```bash
$ docker-compose run compile
```

Then run `./mruby/build/{your build target}/bin/pdfq` version.

### Testing

#### Unit test(s)

Located in `test/test_pdfq.rb`.

```bash
$ docker-compose run test
```

#### Integration tests

Located in `bintest/pdfq.rb`.

```bash
$ docker-compose run bintest
```
