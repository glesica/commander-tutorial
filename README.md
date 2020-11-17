# Commander Tutorial

There are a number of ways we can test our software. You may be familiar with
unit tests, which attempt to verify that small pieces of the software work
correctly in isolation. This is great, but how do we know that our entire
program works correctly? This is where functional tests come in. Functional
tests attempt to verify that the software works correctly from the point of view
of a user, usually by simply running it.

This is actually the first kind of testing we learn, though we first learn to do
it manually. When you wrote your first "Hello, world" program how did you know
that you'd done it correctly? You ran it and verified that the famous string was
printed to your terminal. This process can get cumbersome for larger
applications, however, so we tend to automate it. Commander is a tool that helps
us do exactly that for command line applications.

Imagine that we are working on the "ls" command. We don't want to break anything
as we go about making changes, so we'd like to create a test suite that we can
run after each major code change. See the file "commander.yaml" for the final
result, or continue reading for some explanation and simpler examples.

## YAML

Commander uses YAML, a simple markup syntax, to define tests. YAML is
semantically similar to JSON and organizes information as key-value maps (or
dictionaries, if you prefer) and lists. See the examples below.

```yaml
# A dictionary with one key, foo, that stores a list of two items, the strings
# "bar" and "baz".
foo:
    - bar
    - baz

# A nested dictionary where the foo key contains another dictionary with bar and
# baz as its keys which contain the numbers 5 and 10, respectively.
foo:
    bar: 5
    baz: 10
```

## Tests

A test verifies that one command, including flags and arguments, behaves
correctly. It does this by making "assertions" about the output produced by the
command, either to standard error, standard output, or the exit code set when
the program stops.

Commander tests appear under the "tests" key, which resides at the top level of
the YAML file.

```yaml
tests:
    ls should run successfully:
        command: ls
        exit-code: 0
```

This is just about the simplest useful test. It runs `ls` and verifies that it
exits successfully (with an exit code of 0). We can also verify output. For
example, the test below is identical to the one above except that it also
ensures that "README.md" appears somewhere in the output of the command.

```yaml
tests:
    ls should run successfully:
        command: ls
        exit-code: 0
        stdout:
            contains:
              - README.md
```

We might also want to split this up into multiple tests so that what went wrong
is more obvious when one of them fails. The test suite below also uses the
"not-contains" assertion to verify that ".gitignore" (a hidden file) is absent
from the output.

```yaml
tests:
    ls should run successfully:
        command: ls
        exit-code: 0
    ls should list files:
        command: ls
        stdout:
            contains:
              - README.md
    ls should not list hidden files:
        command: ls
        stdout:
            not-contains:
              - .gitignore
```

