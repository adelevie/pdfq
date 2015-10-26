# pdfq

A lightweight library that sits between ['pdftk'](https://www.pdflabs.com/tools/pdftk-server/) and [`jq`](https://stedolan.github.io/jq/manual/).

`pdfq` receives via stdin the output of `pdftk`'s `dump_data_fields` command and outputs it as JSON.

## Synopsis

If you clone this repo and `cd` into the `examples` folder, you can run these yourself:

### Basic

Takes the output from dump_data_fields, pipe it into pdfq, and output json:

```bash
pdftk pdfs/SF-52.pdf dump_data_fields | pdfq
```

### Buttons

Like the previous example, but only outputs fields where `FieldType` is `Button`.

```bash
pdftk pdfs/SF-52.pdf dump_data_fields | pdfq buttons
```

### jq

`pdfq` mixes nicely with `jq`. In this example, jq filters for fields where FieldType is a Button.

```bash
pdftk pdfs/SF-52.pdf dump_data_fields | pdfq | jq '.[] | select(.FieldType=="Button")'
```

### FDF

Generates FDF from JSON:

```bash
cat json/SF-52-fields.json | pdfq json_to_fdf
```

### Fill

Combine the `json_to_fdf` command with `pdftk` to fill a form from json in two commands:

```bash
cat json/SF-52-fields.json | pdfq json_to_fdf > fdfs/SF-52-fields.fdf
pdftk pdfs/SF-52.pdf fill_form fdfs/SF-52-fields.fdf output pdfs/SF-52-filled.pdf
```

### PDFTK wrappers

The following commands provide convenience methods on top of `pdftk`. To run them, you must have `pdftk` on your path.

### Get

Gets the value of a single field in the PDF.

```bash
pdfq get <field> <pdf_path>
```

Example:

```bash
pdfq get EdLevel pdfs/SF-52-filled.pdf
```

### Set

Sets the value of a single field in the PDF.

```bash
pdfq set <field> <value> <input_pdf_path> <output_pdf_path>
```

Example:

```bash
pdfq set EdLevel ED_LEVEL pdfs/SF-52.pdf pdfs/SF-52-filled.pdf
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
