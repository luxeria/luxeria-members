luxeria-members
===============

Tools for the Luxeria membership database. For privacy reasons, the repository
does not contain the actual database. 
Replace `members.sql` and `photos/photo*.jpg` to use a different data set.

####  Makefile Commands

    make db    - populate a new database with data from 'members.sql'
    make csv   - create a csv table using primary contact information
    make json  - dump all data from the database as JSON
    make pdf   - generate a human readable PDF from database and photos
    make clean - remove all generated content

#### Requirements

 - SQLite3 for creating and querying the database
 - Python 3.x for exporting the data as JSON and generating TeX
 - [pyratemp](http://www.simple-is-better.org/template/pyratemp.html) for
   dynamic document generation (included)
 - TexLive and Ghostscript for compiling the generated TeX into PDF
