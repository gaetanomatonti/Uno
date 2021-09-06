# Contributing to Uno
## Code Guidelines
We believe in the power of sharing knowledge with other members of the community, so writing clean code is a crucial part of getting a point across in a clear manner.

### Indentation
Code is indented using 2 spaces or tabs in order to use less space and to be more readable on smaller screens.

### Order
The order of your code is very important. This may also very depending on the situation.
Each type or extension should be split up in the following blocks:
- Constants (or static properties)
- Stored properties/variables
- Computed properties
- Init
- Functions

Each of these blocks should be marked with the correspond mark:
- `// MARK: Constants`
- `// MARK: Stored Properties`
- `// MARK: Computed Properties`
- `// MARK: Init`
- `// MARK: Functions`

Marks are not necessary in protocols – as long as they are short and concise – or in types if only one type of block is present.

Additional marks can be added for `Error` types definitions and `Helper` properties or functions.

Additionally, the content of each block should be sorted by access control: public at the top, private at the bottom.

## Documentation
Documentation is a very important part of your code and is needed for others to properly understand how to use it.
As such we write documentation for every single component of our code.

Functions require a description of what it does, what its parameters are and, if it returns a value, a description of its return type.

## Comments
Comments in code are really useful to explain your intentions and the reason why something has been done – they are also reminders for our future selves.

There may be some occasions when our code might get complicated. In those occasions comments are strongly encouraged – although we prefer our code to be self explanatory.

Commented code is prohibited – if you don't need it delete it.

## Git
The preferred workflow when working with git is [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow).

- The `main` branch mirrors the current release version.
- The `develop` branch is the main working branch. You do not work directly on this branch.

#### Task branches
The following branches should always be created from `develop` and should be merged into `develop` when work is done.
- The `feature` branches contain code for a new feature. These branches are prefixed with `feature/`.
- The `bugfix` branches contain code for bug fixes.

The `realease` branches contain code for a new release. This is the only instance when a branch should be merged into `main`.

## Pull Requests
When work on a `feature` or `bugfix` is completed a new pull request should be opened.
Pull request should be assigned to the person who mainly worked on the code, tagged with the correct tag, and linked to the corresponding issue (if any).
Make sure to write a good description of the goal of the pull request.

Code review is required from at least one of the code owners.
Each time a pull request is open, a Github Action will build and test the code – this check must be successful in order for the pull request to be approved.

Lastly, pull requests should be reasonably sized – limit is around 600 changes. If you can't fit into this limit, more than a pull request is required. In this case work should be split up in subtasks.

### Example
The `Task` feature will be split up into two subtask called `Subtask 1` and `Subtask 2`.

```
Feature: Task
         -- Subtask 1
         -- Subtask 2
```

You should create a first branch for the task `feature/task` and  two for the subtasks – `feature/task@subtask-1` and `feature/task@subtask-2`. A pull request should be opened for each subtask feature and should be marked with the `subtask` tag.
Subtasks pull requests will be merged into the `feature/task` branch. Once every subtask is merged a pull request for the task should be opened. This pull request should reference all its subtask pull request in the description.