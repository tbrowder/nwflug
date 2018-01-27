title: FOSS: Road to a Quality Technical Resume
<!-- insert-file headers.md -->

## AUDIENCE EXPECTATIONS

**What do you expect from this presentation?**

## OBJECTIVE

My purpose is to give you an introduction to
collaboration with Free and Open Source Software (FOSS)
as a means of gaining real technical experience.

I hope the parents and grandparents of children
interested in a technical career can benefit from
the information and pass that on.

<!-- insert-file background.md -->

## FOSS: An alternative to internships

Software developers are in demand, as are other technical
positions.

An internship in an appropriate position is an ideal way
to see and be seen working in your desired field.

However, good internships are not easy to come by.

FOSS collaboration can be an alternative, or a supplement, to
an internship.

## FOSS Collaboration

There are many websites where one can find FOSS projects hosted,
but the ones I have used are:

- Github
- Bitbucket
- SourceForge

Github is my favorite, and it is one of the most popular sites.

Note they have been sponsoring a hackathon, called **Hacktoberfest**,
for the past several years, and you can win a T-shirt for participation.

Let's look at my home page there.

## FOSS Collaboration

My Github home screen...

![25%](pics/tbrowder-github-home.png)

## FOSS Collaboration

One of my repositories (*repos*)...

![25%](pics/tbrowder-github-one-repo.png)

## FOSS Participation

**Joining**

After finding a project you want to work with, you will have to join
that group's communication channels.  That may be one or more mailing
lists, wikis, Internet Relay Chat (IRC) channels, or forums. Some
projects also use Google Groups.

Some projects have multiple mailing lists with a special one
for newcomers.

## FOSS Participation

One of the *Rakudo Perl 6* group's page (*perl6*)...

![25%](pics/perl-6-github-home.png)

## FOSS Participation

The *github/perl6/nqp* repo...

![25%](pics/perl6-github-nqp-repo.png)

## FOSS Participation

**Newcomers**

Projects vary in reputation for friendliness, but don't be
put off if they are too impatient. It's a good idea to lurk
unnoticed for awhile so you can get a feeling for how
they treat *newbies* (aka *noobs*).

**Policies**

A good project will have documented policies and procedures. They may have
a formal management structure.

## FOSS Participation

**Procedures**

By procedures I mean documented methods for completing such regular tasks as:

- submitting a pull request (PR)

- reviewing and merging PR's (pull request)

- preparing a release

- publishing a releaee

## FOSS Participation

**Roles**

You may work at many roles on a project:

- project leader(s), release managers

    - usually a meritorious position, gained by experience
      and good work in the trenches

- tecnical writer

    - always needed (programmers are notorious for lack
      of documentation)

- programmer

    - submit code changes, often with PR's


## GITHUB

Github uses the **git** *distributed* version control system.  You
will have to learn how to use it and you can practice
with it on your own system, whether Windows, Mac, or Linux.
See the handout for the Git website where you can git for
your system and help for using git.

Github has a pretty good help section, but
it's much too fragmented IMHO (in my humble opinion).

The Git website has all its extensive documentation there,
and there are lots of ebook and printed books. I
have one here you're welcome to peruse.

## Git basics

Git can be used on Windows or Linux, and there are some good graphics
interfaces which really help on Windows where the CLI (command line
interface) is not so friendly IMHO.

For Windows I use the commercial program *SmartGit* (which is also
cross-platform), but I rarely use it on Linux.

Git is usually already installed on most Linux *distros* these days,
but you can alway install it from the website.

## Git basics

At the Linux CLI, initializing a git repo on your local host in a
non-existing subdirectory *foo*...

~~~
$ pwd
/path/to/dir
$ git init foo
Initialized empty Git /path/to/dir/foo/.git/
$ cd foo
$ echo "This is the home of the 'foo' project." > README.md
$ git add README.md
$ git commit README.md -m"initiate README.md"
[master (root-commit) 9160f05] initiate README.md
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
~~~

## Git basics

Continuing...

~~~
$ # edit README.md and add some text
$ echo "The lead developer is Joe." >> README.md
$ git commit -a -m"add lead developer's name."
[master 9501dbf] add lead developer's name.
 1 file changed, 1 insertion(+)
$ git status
On branch master
nothing to commit, working directory clean
~~~


## Git basics

Continuing...

~~~
$ git branch
On branch master
nothing to commit, working directory clean
$ git checkout -b fix-widget
Switched to a new branch 'fix-widget'
$ git branch
* fix-widget
  master
~~~

And so on as we work on branch *fix-widget* and eventually merge it
into the *master* branch.

Eventually you could link the local repo to your account on Github,
which will provide you a version controlled backup on Github
(but it will be public unless you pay for private repos).

## MY EXPERIENCES

**While Employed**

While still employed as an engineer, our company had to regularly
submit employee resumes with proposal packages.  My resume always
mentioned expertese with vulnerability analysis tools, one of which
the US DoD-supported, FOSS CAD program, BRL-CAD (hosted on
SourceForge).  I had significant contributions to that project that I
could reference in my resume and which could be viewed by anyone
interested in confirming that.

## MY EXPERIENCES

**While "Unemployed"**

Although officially retired, I'm actively supporting one major FOSS
project (**Rakudo Perk 6**), located on Github and consisting of three
major subprojects, each having its own Github project name:

- perl6 (you've already seen this one)
- rakudo
- moarvm

Also as you've seen, my Github user name is **tbrowder** and I have a
lot of *repos* there, including *repo forks*.

## SUMMARY

Github, as well as other such sites, are popular collaboration
platforms for thousands of FOSS projects of all kinds.

By working on one or more FOSS projects with publicly documented
contributions, you can have a powerful testament to
your technical or managerial skills.


<!-- insert-file closer-help.md -->
