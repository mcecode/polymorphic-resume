# Polymorphic Resume

I was dusting off my resume and wanted a way to write it in [Markdown](https://www.markdownguide.org/getting-started) because it has an [easy to write syntax](https://www.markdownguide.org/basic-syntax) that allows you to focus on the content and structure of the document. I prefer this over using WYSIWYG editors like [Microsoft Word](https://en.wikipedia.org/wiki/Microsoft_Word) where you need to fiddle around with setting the design while you write the content. Additionally, there is a lot of support in converting Markdown into other formats that allow fine-grained control of the output document's design and layout, which WYSIWYG editors may not support.

With that in mind, I already knew about the document converter, [Pandoc](https://pandoc.org), and was using it for basic conversions, like Markdown to HTML. However, I did not know how to use it for creating PDFs, which is probably the most important format your resume can be in. When I tried, it always gave me an error about not having a PDF engine. After searching for a while, finding [pandoc_resume](https://github.com/mszep/pandoc_resume), and digging around in the [Pandoc documentation](https://pandoc.org/MANUAL.html), I was inspired to use [ConTeXt](https://wiki.contextgarden.net/FAQ#What_is_ConTeXt.3F) as my PDF engine and make my own templates based on how I would like my resume to look.

Lots of fiddling later, I had something working. So, I decided to clean it up a bit and share it here. This project does not aim to be as fully featured as [pandoc_resume does](https://github.com/mszep/pandoc_resume/issues/1). Rather, it aims to be a starter template to give others an idea of how to convert their own resume documents into other formats using Pandoc.

Theoretically, since [Pandoc's Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown) supports a wide variety of structures, you can also use this template to generate documents other than resumes, but I will leave you to explore that if you wish to.

## Requirements

The following packages need to be installed and be in your [`PATH`](<https://en.wikipedia.org/wiki/PATH_(variable)>):

- [Pandoc](https://pandoc.org/installing.html), as the document converter
- [ConTeXt](https://wiki.contextgarden.net/Installation), as the PDF engine

## Directory structure

- [`assets`](assets)
  - This is where you will put the images and other media you want to locally reference in your resume/s.
  - All local media files must be referenced relative to this directory. See the [Images section in `sample.md`](src/sample.md#images) for examples.
  - The project comes with two sample images, `sample.jpg` and `sample.png`, which are stored here.
- `build`
  - This is where Pandoc will emit the different document formats generated.
  - It automatically gets created when running [`generate.sh`](#generatesh).
- [`scripts`](scripts)
  - This contains the [scripts](#scripts) that run the batch jobs.
- [`src`](src)
  - This is where you will store your Markdown resume/s.
  - This holds [`sample.md`](src/sample.md), which details some ways you can use the project.
- [`templates`](templates)
  - This contains the [Pandoc templates](#formats-with-templates) that are used in this project.

## Scripts

The following scripts are written in [shell script](https://en.wikipedia.org/wiki/Shell_script), which are usually run on \*nix systems. However, they should be runnable in Windows using environments like [Cygwin](https://cygwin.com), [Git for Windows](https://gitforwindows.org), or [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) running any POSIX-ish shells such as [Bash](https://www.gnu.org/software/bash).

### `cleanup.sh`

This script deletes all of the files and directories inside of the `build` directory.

### `generate.sh`

This script coverts the Markdown files inside of the `src` directory into the specified formats. It takes the following arguments:

```console
./generate.sh <format> <base_names>
```

`<format>` specifies the format to convert to. It can be any of `pdf`, `context`, `html`, `docx`, `odt`, `rtf`, or `all`. Specifying `all` will convert the specified Markdown file/s to all supported formats.

`<base_names>` specifies the base names, without any extensions, of one or more Markdown file/s located in the `src` directory to convert. Because it relies on base names without any extensions to find the files to convert, this script assumes that you use a `.md` extension for your Markdown files.

If `<base_names>` is omitted, all Markdown files within the `src` directory except for `sample.md` will be converted into the specified format.

If both `<format>` and `<base_names>` are omitted, the format will default to `all` and all Markdown files within the `src` directory except for `sample.md` will be converted.

You can run,

```console
./generate.sh all sample
```

to see an example of how the supported formats would look using `sample.md` as input.

### Example usage

Assuming the file `src/resume.md` exists and does not reference any media,

```console
./generate.sh pdf resume
```

creates a `resume` directory inside of the `build` directory and outputs `resume.pdf` inside of it using `src/resume.md` as input;

```console
./generate.sh context resume
```

outputs `resume.tex` in the previously created `resume` directory; this intermediate format can be useful in debugging any problems with PDF creation or for using Pandoc to do most of the heavy lifting in creating a ConTeXt document, editing some parts to better suit your needs and tastes, and running `context resume.tex` in the `resume` directory to create `resume.pdf`;

```console
./generate.sh all resume
```

outputs the following files in the `resume` directory:

- `resume.docx`
- `resume.html`
- `resume.odt`
- `resume.pdf`
- `resume.rtf`
- `resume.tex`

Assuming the file `src/other-resume.md` exists and references the image `sample.jpg` from the `assets` directory,

```console
./generate.sh html other-resume
```

creates an `other-resume` directory inside of the `build` directory and outputs `other-resume.html` as well as `sample.jpg` inside of it; if instead of `sample.jpg`, `src/other-resume.md` references the image `https://example.com/sample.jpg` which has a SHA-1 hash of `9b6fb57ef128201893db6ee99117f5c14601f3b7`, then,

```console
./generate.sh html other-resume
```

still creates an `other-resume` directory inside of the `build` directory and outputs `other-resume.html`. However, instead of also outputting `sample.jpg`, this time, it will output `9b6fb57ef128201893db6ee99117f5c14601f3b7.jpg`;

```console
./generate.sh docx other-resume
```

only outputs `other-resume.docx` inside of the previously created `other-resume` directory as media files are embedded directly into DOCX files.

Assuming the files `src/resume-1.md`, `src/resume-2.md`, and `src/resume-3.md` exists and do not reference any media,

```console
./generate.sh rtf resume-1 resume-2 resume-3
```

creates `resume-1`, `resume-2`, and `resume-3` directories inside of the `build` directory and outputs `resume-1.rtf`, `resume-2.rtf`, and `resume-3.rtf` in their respective directories.

```console
./cleanup.sh
```

Deletes all of the previously generated directories and files as well as any other directories and files located inside of the `build` directory.

## Formats with templates

### General

- Due to certain limitations, some structures will look different between PDF and HTML outputs.
- Only styles the first four levels of headings; this means that it only styles `h1` to `h4` HTML tags and `section` to `subsubsubsection` ConTeXt headings.
- Uses colors from the [RAL Classic color system](https://en.wikipedia.org/wiki/RAL_colour_standard#RAL_Classic) as they are [used in ConTeXt](https://source.contextgarden.net/tex/context/base/mkiv/colo-imp-ral.mkiv); below are the specific colors used, their respective approximated hexadecimal values, and where they are used:

  | RAL color | Hexadecimal value | Used in                     |
  | --------- | ----------------- | --------------------------- |
  | RAL 9005  | `#0a0a0a`         | Document text               |
  | RAL 9003  | `#f4f4f4`         | Document background         |
  | RAL 7011  | `#434b4d`         | Block quote text and border |
  | RAL 5015  | `#2271b3`         | Link text                   |
  | RAL 9018  | `#d7d7d7`         | Code background             |

### PDF and ConTeXt

[`template.tex`](templates/template.tex) is used to create both PDF and ConTeXt formats. It is based on the [default ConTeXt template](https://github.com/jgm/pandoc-templates/blob/master/default.context) used by Pandoc version 2.14.

Since some may not be familiar with using TeX or ConTeXt like I was, I have included some resources below that helped me get started with making this template which may also be helpful to you:

- [The ConTeXt website](https://wiki.contextgarden.net) contains documentation and references to other documentation about how to use ConTeXt. The following pages from it may be of particular interest:
  - [Layout](https://wiki.contextgarden.net/Layout)
  - [Interactions such as links](https://wiki.contextgarden.net/Interaction)
  - [Color](https://wiki.contextgarden.net/Color)
  - [Font switching](https://wiki.contextgarden.net/Font_Switching)
  - [Information about the fonts that come with ConTeXt](https://wiki.contextgarden.net/ConTeXt_distribution%27s_Fonts)
  - [Using graphics such as images](https://wiki.contextgarden.net/Using_Graphics)
  - [Search](https://wiki.contextgarden.net/index.php?search) can help you find documentation about different ConTeXt commands.
- [Tobias Weh](https://github.com/tweh)'s [Units in TeX illustration](https://raw.githubusercontent.com/tweh/tex-units/49fbe7941e524a63f586e8df436c14a6bcaeb6ce/tex-units_preview.png) gives a good visual overview of TeX’s length units and their definitions.

**Note:** JPEG, PNG, and some [other image formats](https://wiki.contextgarden.net/Using_Graphics#File_Formats) are automatically supported by ConTeXt. However, SVG, GIF, and other media types are not. See their documentation about [image conversion](https://wiki.contextgarden.net/Using_Graphics#Image_Conversion) and [embedding videos](https://wiki.contextgarden.net/Using_Graphics#Movies) if you wish to use these other media formats in your documents.

### HTML

[`template.html`](templates/template.html) is based on the [default HTML5 template](https://github.com/jgm/pandoc-templates/blob/master/default.html5) used by Pandoc version 2.11.3.2.

The CSS within `template.html` is based on the [default styles](https://github.com/jgm/pandoc-templates/blob/master/styles.html) used by Pandoc version 2.14.1.

When converting to this format, emails are obfuscated by encoding them as decimal or hexadecimal, code is highlighted with the monochrome theme, and any inline or display math is styled using [KaTeX](https://katex.org).

### Front matter variables

I have removed most of the [configurable variables provided by Pandoc](https://pandoc.org/MANUAL.html#variables) in these templates as I did not see the need for them when generating resumes.

The following are the variables that I kept or added, which can be set in your Markdown file/s front matter. Of course, for your templates, you may modify these or add your own.

#### `lang`

Default: `en`

As per the [Pandoc documentation](https://pandoc.org/MANUAL.html#language-variables),

> identifies the main language of the document using IETF language tags ... affects most formats, and controls hyphenation in PDF output when using LaTeX ... or ConTeXt.

#### `pagetitle`

Default: None

Sets the value of the HTML `<title>` element and the PDF `Title` metadata. When converting to HTML and this is not set, Pandoc will set it to the base name of the file without its extension.

#### `author-meta`

Default: None

Sets the `content` of the HTML `<meta>` element with a `name` property of `author` and the PDF `Author` metadata.

#### `version-meta`

Default: None

Sets the `content` of the HTML `<meta>` element with a `name` property of `version` and the PDF `Version` metadata. `Version` is non-standard PDF metadata, so you may need specific tools like [this](https://products.groupdocs.app/metadata/pdf) to view this in a generated PDF file.

#### `description-meta`

Default: None

Sets the `content` of the HTML `<meta>` element with a `name` property of `description` and the PDF `Description` metadata. `Description` is also non-standard PDF metadata, so the same caveat noted in [`version-meta`](#version-meta) applies.

#### `papersize`

Default: letter

Sets the paper size of PDF outputs and the paper size when HTML outputs are printed. Typically, this only needs to be set to either letter or A4. However, if you wish to use a different paper size, it is best to use a value that is supported by both [ConTeXt](https://wiki.contextgarden.net/PaperSetup#Predefined_Paper_Sizes) and [CSS](https://developer.mozilla.org/en-US/docs/Web/CSS/@page/size#values).

## Formats without templates

### General

The ODT and RTF formats do not have templates, nor does the DOCX format have a reference document. I did not create any as I only included these formats for the sake of completeness. I think that 99% of the time, all you really need are PDF and HTML formats. PDF for job applications, and if you want to, HTML for your personal website.

I may create templates for these formats one day, but it is not really a priority.

### DOCX

When converting to this format, code is highlighted with the monochrome theme.

### RTF

This format does not seem to support TeX math well, so Pandoc shows a warning when converting a document that has TeX macros like `\sqrt{25}`. This happens when running `./generate.sh rtf sample` as `sample.md` contains that exact macro.

Additionally, this format does not seem to play well with [LibreOffice](https://en.wikipedia.org/wiki/LibreOffice), as an error occurs when I try to open a generated RTF file that contains embedded images.

## Contributing

If you find anything wrong or would like to suggest any improvements, issues and pull requests are welcome.

You might want to start with the following:

- Updating the templates
- Correcting any edge cases that I might have missed with the templates
- Creating templates for supported formats without templates (i.e., for DOCX, ODT, or RTF formats)
- Adding or suggesting other formats to support

## Third-party assets

- [`sample.jpg`](assets/sample.jpg) is a [photo by Cassie Boca](https://unsplash.com/photos/EiGCgdLd_C8).
- [`sample.png`](assets/sample.png) comes from the [finance icon set by Ruma Entertainment](https://www.iconfinder.com/iconsets/finance-152).

## License

Copyright 2021-present Matthew Espino

This project is licensed under the [Apache 2.0 license](LICENSE).
