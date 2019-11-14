# EvoThesis 
## the idea

assuming that nobody can write a book in a couple of days, there are a number of things we should take into account. 
a thesis should grow, just like evolution didn't happen in one day. 
we don't know what is yet to come, so the framework whithin which the book is developed should provide maximum flexibility. we want

- to write piece by piece, one fragment at a time
- each fragment might contain different supporting data, e.g. pictures or pdfs
- we want to work from different locations, machines, and diverse operating systems
- we don't want a huge mess in the end
- we need to keep track of certain key features such as citations in a consistent manner

This project was designed to fulfill these requirements. it heavily relies on the markdown language
and pandoc to provide the freedom to switch between formats, whenever necessary.

## usage
### project structure
a project should come with a shallow structure containing a number of fragments.
each fragment is contained in a sub-folder. this sub-folder contains a single markdown
document as master source. it can also contain everything else related to the fragment,
e.g. pictures in subfolders or source information like audio recordings.

a centralized book-keeping system for citations is established by a bibtex file
`library.bib` in the main project folder. below structure is an example. it is 
important to have fragment master files suffixed with `.md`.

```
project main folder
│   Makefile (created by setup)
│   library.bib (export from e.g. Zotero)
│   index (automatically created by make update)   
│
└───fragment 1
│   │   fragment.md
│   │   Makefile (created by make update)
│   │
│   └───supporting information (optional)
│       │   picture.jpg
│       │   very_important_document.pdf
│       │   ...
│   
└───fragment 2
    │   master.md
    │   somebody_worked_on_this_document_in_a_shitty_format.docx
```


### general usage idea
the project can be converted into different formats on two levels. on the project level,
all existing fragments can be concatenated into one document, e.g. a pdf. this way,
the thesis will be build in the end. on the fragment level, we can convert to other
formats, too.


### fragment and thesis conversion
each fragment and the whole project come with a make file. to create a pdf, simply use
```bash
make help
```
to display all the available options. for example, `make pdf` will create a pdf
from the markdown source document.

as the thesis grows, more and more fragments might occumulate in the main project folder.
simply use `make update` in the main folder to get all of them ready to be converted.

## setup
tbc

## status
this project is growing with the people who use it. it thus provides functionality
that is needed during the process of writing a thesis from the beginning.
everything necessary for beautiful styling will be added once necessary.
