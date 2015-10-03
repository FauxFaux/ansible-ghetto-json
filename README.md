ghetto_json
===========

Need a quick way to edit a JSON file in Ansible?  Ansible has great built-in support for
 ini files, but a number of more modern applications are using JSON for config files.

ghetto_json lets you make some types of edits to JSON files, and remains simple enough that
  it's hopefully easier just to extend than to switch to a different module, and you won't feel
  too guilty just copy-pasting it into your codebase.

If [commentjson](https://pypi.python.org/pypi/commentjson/) is available, it will be used to
 *read* the file, but comments will be lost on save.  This is useful for making edits to default
 configurations shipped with some applications; where the application itself supports comments in
 JSON, but they're not required.


Installation
------------

Drop ``ghetto_json`` into your playbook's ``library`` folder,
 which can be [configured](https://docs.ansible.com/ansible/intro_configuration.html#library)
 but defaults to ``./library`` inside a playbook.

Synopsis
--------

Make in-place changes to simple JSON documents,
 without having to resort to ``replace``.


Requirements
------------

[commentjson](https://pypi.python.org/pypi/commentjson/) will be used, if available,
 but is explictly not required.

Python 2.7 may be required for some ``shlex`` functionality
 (like working Unicode), which you probably don't care about.


Options
-------

#### path:

The file on the target to edit.

#### all other options:

A very simple object notation for the location of the property to edit,
 and its new value.

Mandatory automatic conversion will be applied. Supported conversions are
listed below.  Everything else will be left as a string:

 * integers (``5``, ``-17``)
 * ``true`` / ``false``
 * ``null``
 * ``unset`` will delete the key


Examples
--------

For the example JSON document ``/foo/bar.json`` containing:
````
{ "a": 5, "b": {"c": 6, "d": "hello" } }
````

...you can run an invocation like:
````
 - ghetto_json:
     path=/foo/bar.json
     a=7
     b.c=yellow
     b.d=unset
````

...and the file will be left looking like:

````
{
  "a": 7,
  "b": {
    "c": "yellow"
  }
}
````
