---
lang: en-US
pagetitle: My Awesome Resume
author-meta: Devon Developer
version-meta: 1.0.0
description-meta: This is my awesome resume.
papersize: A4
---

# Devon Developer

<devon@example.com>

[Website](https://example.com) | [GitHub](https://example.com) | [Other Relevant Link](https://example.com)

---

## Part 1: Sample resume structure

This first part shows _one_ way you can arrange your resume based on the default styles of this project. As you can see from above, the level-one heading and its contents are center-aligned for formats with custom templates. That first section is meant to hold the resume owner's name and relevant contact information and links.

### Summary

The summary section usually contains text about you that is relevant to the job/s you are applying for, such as your specialties or interests as a developer. It is a good idea to make this section brief and engaging.

### Skills

In this section, you can list your skills and knowledge that will most likely be relevant to the job/s you are applying for:

- Computer languages: C#, Java, C++, Rust, HTML, CSS
- Frameworks: ASP.NET, Spring, Qt
- Servers: Apache, Nginx, Microsoft IIS
- OSes: Ubuntu, Windows Server

### Experience

Here you can list the companies you have worked for or the freelance projects you have worked on.

#### Name of company or project

You can put a short text about what you did, what the results were, what you learned, and anything else that could be relevant.

- Maybe you would like to use bullet points to state the responsibilities you had;
- Or add some [links](https://example.com) to the projects you created on the job.

#### Name of other company or project

[View the project](https://example.com)

You might even want to highlight a specific deployed project by putting its link front and center like above.

#### Name of another company or project

You can pretty much put anything really and structure it in any way you want, but it is a good idea to be consistent and only include relevant information.

### Projects

Here you can opt to put some side projects that you created or even projects of others that you have helped with.

#### Name of side project

You can include some information about why you created it, what it is about, what problems it solves, why it is useful, your learnings, etc.; its [main repository](https://example.com) and where it is [deployed](https://example.com) should probably be linked too.

#### Open source contributions

- [Project 1](https://example.com)
  - State what the project is,
  - what it does,
  - what your contribution was,
- [Project 2](https://example.com)
  - how you helped the community,
  - and anything else that is relevant.

### Education

#### Name of bootcamp

2021 | Name of course

#### Name of university

1970 | Degree | Minor

## Part 2: Other structures

This second part shows examples of other structures that [Pandoc's Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown) supports that you may want to use for your resume.

### Inline formatting

This paragraph contains some _inline_ **formatting** ~~that~~ ^yo^u m~ay~ `want` [to]{.underline} [use]{.smallcaps}.

### Block quotations

> Any fool can write code that a computer can understand. Good programmers write code that humans can understand.
>
> ― Martin Fowler

\*Quote taken from [Goodreads](https://www.goodreads.com/author/quotes/25215.Martin_Fowler)

### Fenced code blocks

```python
# Strategy: Iterate over a copy
for user, status in users.copy().items():
  if status == 'inactive':
    del users[user]

# Strategy: Create a new collection
active_users = {}
for user, status in users.items():
  if status == 'active':
    active_users[user] = status
```

\*Example taken from the [Python Documentation](https://docs.python.org/3/tutorial/controlflow.html#for-statements)

### Line blocks

| 4779 Forest Avenue
| New York, NY 11530
| USA

\*Example generated from [Fake Address Generator](https://www.fakeaddressgenerator.com)

### Ordered lists

1. One
2. Two
3. Three

### Definition lists

Programming
: The designing, scheduling, or planning of a program, as in broadcasting.
: Broadcast programs considered as a group.
: The writing of a computer program.

\*Definition taken from [Wordnik](https://www.wordnik.com/words/programming)

### Numbered example lists

(@) My first example will be numbered (1).
(@) My second example will be numbered (2).

Explanation of examples.

(@) My third example will be numbered (3).

\*Example taken from the [Pandoc User’s Guide](https://pandoc.org/MANUAL.html#numbered-example-lists)

### Simple tables

: Simple table caption

  Right    Left        Center      Default
-------    ------    ----------    -------
Cell1      Cell2     Cell3         Cell4
Cell5      Cell6     Cell7         Cell8

### Multiline tables

: Multiline table caption

---------------------------------------
    Right Left        Center    Default
  Aligned Aligned     Aligned   Aligned
--------- --------- ----------- -------
Cell1     Cell2     Cell3       Cell4

Multi     Multi     Multi       Multi
Line      Line      Line        Line
Cell1     Cell2     Cell3       Cell4
---------------------------------------

### Grid tables

: Grid table caption

+-------+-------+--------+---------+
| Right | Left  | Center | Default |
+======:+:======+:======:+=========+
| Cell1 | Cell2 | Cell3  | Cell4   |
+-------+-------+--------+---------+
| Multi | Multi | Multi  | Multi   |
| Line  | Line  | Line   | Line    |
| Cell1 | Cell2 | Cell3  | Cell4   |
+-------+-------+--------+---------+

### Pipe tables

: Pipe table caption

| Right | Left  | Center | Default |
| ----: | :---- | :----: | ------- |
| Cell1 | Cell2 | Cell3  | Cell4   |
| Cell5 | Cell6 | Cell7  | Cell8   |

### Math

This is an example of some inline TeX math $5 + 5 = 5$. You can also use display math:

$$x^2 = 25$$
$$x = \sqrt{25}$$
$$x = 5$$

### Images

This is an example of an inline image, ![A PNG icon from the `assets` directory](sample.png). You can also use block images which are rendered as figures with their alt text as their caption:

![A JPEG image from [Unsplash Source](https://source.unsplash.com)](https://source.unsplash.com/random/500x500)

![A JPEG image from the `assets` directory](sample.jpg)

### Footnotes

This is an example of a footnote reference,[^1] and here is another.[^other-footnote]

[^1]: Here is the footnote.
[^other-footnote]: Here is the other footnote.
