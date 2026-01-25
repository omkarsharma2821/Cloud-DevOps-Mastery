![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/5s1phtnkfb92352v8p3s.png)

## 1. What is a Version Control System (VCS)?

Version control, also known as source control, is a system that helps track and manage changes made to software code over time.

### Why is it required?

As a project grows, code is continuously updated—new features are added, bugs are fixed, and existing logic is modified. In such cases, it becomes difficult to answer questions like:

- Who made a specific change?
- When was the change made?
- Why was the change introduced?
- How can we revert to an older stable version?

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/by0tqcg9p3za9b7hfzkj.png)

A Version Control System solves this by maintaining a complete timeline (history) of code changes, making collaboration, tracking, and rollback easy and reliable.

### Famous VCS Tools
- **Git** (Most popular)
- **Apache Subversion (SVN)**
- **Piper** (Used internally by Google)

## 2. Introduction to Git VCS

Download Git from the official website:  
https://git-scm.com/install/

### Verify Installation

```bash
git
git -v
```

If Git is installed correctly, it will display the installed version.

![Omkar Sharma](https://eraser.imgix.net/workspaces/s013nvOz7IYira3OuWD2/n1edSXVxagZwG0BJM01i1cKgTsY2/image_zDptJqHPPzahC8aGPj_vc.png?ixlib=js-3.8.0)

### What is Git?

Git is a **distributed version control system** that allows multiple developers to work on the same project simultaneously while keeping track of all changes.

### Why Git Configuration is Required?

In an organization, multiple developers work on the same codebase. Git uses global configuration (username and email) to identify **who made which changes** in the commit history.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1mr5gb4euz0fozco6d9h.png)


### Setting Up Git Global Configuration

First let's create a folder where we keep our source code and config the user name and email to it.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/oonf06y7g0t9rpbzvuic.png)

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/gf6zxz862lnlfatpx02d.png)

## 3. Version Controlling with Git

### Initializing a Git Project

By default, a folder is **not Git-enabled**, and Git does not track it.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/wwexz5dn31e0oo2qxlml.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/j0vu0bevrzcddr0g2b3k.png)

To enable Git tracking:

```bash
git init
```
This initializes a Git repository in the folder.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hwncf6nc222qpksm8ci4.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4ksimaxnqmoj0qb6blyj.png)


### Tracking Files

* After initialization, files are still **untracked**
* You must explicitly add files to Git

```bash
git add index.js
git add <File Path Name>
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/w9qghno02qtz0di9u744.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/u1mxssb34w2bk7eketw7.png)


Once added, Git starts tracking changes to the file.

### Viewing Changes

```bash
git diff
```

Shows differences between the working directory and the staging area.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/11dcy4f03c5i0wsy9jb7.png)

### Add Multiple Files

```bash
git add .
```

Adds all modified and untracked files at once.

> By default, Git does not track any folder or file on your local machine unless you initialize it and add files manually.

### Removing Files from VCS

```bash
git rm <FILE_PATH>
```

## Introduction to Commits

### What is a Commit?

A commit is a snapshot of the staged changes at a specific point in time.

### Committing Files

```bash
git commit -m "commit message"
```


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/vu3dkey5r89wzk3p6rt8.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/yw36a4itbigdk4eca0a4.png)

### Staging Area

The staging area is an intermediate step where files are prepared before committing.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/vf75cste8ao7keehe8pk.png)

### Viewing Commit History

```bash
git log
git log --oneline
git diff <to see the changes in code file>
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/50est3wieqcb0kxokpxh.png)

```bash
git show <commit id> to see the changes made in particular commit
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/at538nbz8ui4ojr1e41c.png)

```bash
git blame <File Name> to see the changes made in particular file by whom
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/n7k1wtbd94i5ay89tts9.png)


### Reverting Back

```bash
git reset --hard <commit id>

here we are moving our head so we will loose the below commits
```

whenever we are saying VCS we should have something when we do any thing wrong we can revert back.....so Git allows reverting commits to return to a previous stable state when required.

In this feature we use the concept of Linked List head points to the latest commit.....so we just point our head where we want to revert.


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/3po86xpr8h1ceb89hb5r.png)


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/cbs8vnwc3m6iefswc9kg.png)

```bash
git revert <commit id>
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/cpcpciarw6cmg35ihzav.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ef8qyry76w8j18d3nbij.png)

---
✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)*