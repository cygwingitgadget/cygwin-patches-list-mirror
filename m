From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Ronald Landheer" <info@rlsystems.net>, <cygwin-patches@cygwin.com>
Subject: Re: fhandlers codebase, magic dirs, etc.
Date: Sat, 29 Sep 2001 15:45:00 -0000
Message-id: <047901c14938$9f0a67a0$01000001@lifelesswks>
References: <NFBBLOMHALONCDMPGBLFAEMNCCAA.info@rlsystems.net>
X-SW-Source: 2001-q3/msg00239.html

----- Original Message -----
From: "Ronald Landheer" <info@rlsystems.net>
To: "Robert Collins" <robert.collins@itdomain.com.au>;
<cygwin-patches@cygwin.com>
Sent: Sunday, September 30, 2001 7:13 AM
Subject: RE: fhandlers codebase, magic dirs, etc.


Hi Robert,

> My mailer decided not to indent your email. (Thanks MS!!!) so I'll
> mark my lines with *...
You probably have the same mailer I do - I forget why I haven't changed
everything to StarOffice yet..
I've done the indenting..

>> As I'm going to be working on the opendir(), readdir() and stat()
>> problems with magic dirs, I just want to make sure I got some things
>> straight, and make some things clear, so here goes:
>> First off: as I understand it, the readdir() and opendir() code is
>> not part of the fhandlers, but should be, so should be migrated
>> there, and the existing opendir() and readdir() implementation should
>> call the ones in the fhandlers to take care of the dirty work,
>> correct?
> check.
Oh in any case, I will :) I was just hoping that someone would know very
sure and fill in details..

* I meant this in the context of a checklist - "check" or "fail". You
had it right.


>> Depending on the type of fhandler that finds stuff in the requested
>> opendir() call, the opendir() wrapper should or should not continue
>> to the other fhandler classes' opendir() implementations - e.g. in
>> /registry, only registry items will be listed, and no files, correct?
> the opendir wrapper will look very similar to the open wrapper. That
> is to say that there is one and only one fhandler that matches a
> specific path. So there is no "continue to" logic at all.
That would depend on how they're implemented: if an fhandler handles
(and shows) a type of file, and that type of file can occur in different
types of directories (say: a real file can exist in /dev) that the
"continue to" logic is there. If the fhandler handles a type of
directory, and shows everything in it, then there's no "continue to"
logic to be followed.
I don't know what the best approach is yet - but I guess the second one
would seem most obvious..

* I disagree. If a "real" file can exist in /dev, that is the
responsibility of the dev fhandler to manage that. The dev fhandler will
still do all the grunt work. A directory is just a file that points to
other files. So the logic for what fhandler looks after a fiven
directory is _identical_ as for looking after files.

>> Codebase: I haven't gotten familiar with it yet - I'll be starting
>> that now. As a result, the above suggestions may be complete bullshit
>> and should be regarded with that possibility in mind. This is just
>> what a tired mind got from a discussion on the cygwin mailing list..
> fairly close. I have one thing to add and that is that the readdir
> wrapper needs to add (and when necessary override) the fhandler
> returned entries for mounted fhandlers below the open node. An
> example: in / we mount a registry fhandler at /registry, and a devfs
> handler at /devfs. Opendir (/) goes to the fhandler_base (which IMO
> should be split into fhandler_win32 and a real fhandler_base that has
> almost no functionality - different discussion though ;}).
> lets say that there is a dir called registry in the cygwin root, and
> not one called dev. We want ls / to show both registry and dev.
> Now, special case 1: readdir (/ (fhandler_base)) returns a "registry"
> entry. The readdir wrapper sees that "registry" conflicts with the
> mount table entry /registry and replaces any relevant metadata in the
> response to the calling app. Such metadata could be obtained by a call
> to stat (/registry (which ends up going to fhandler_registry))
> Special case 2: (BTW: I'm assuming readdir() returns unsorted entries
> here). readdir (/ (fhandler_base)) returns end-of-list, and the
> readdir wrapper notices that "dev" has not been listed. So the wrapper
> adds "dev" to the returned list.
Here, I would propose a "continue to" strategy - which leaves less real
work for the wrapper: just ask each of the classes whether they have
anything to add to the list: give them all the list - which starts empty
- and have them add to the end. Look for duplicates after the last one
et voilÃ .

* Again, I disagree. Remember that a class is simply code - no real
data. By asking all the classes you are making this entirely special
case, and not data driven. You are also making the fhandlers more
complex internally. By using the mount table, the system becomes data
driven, not code driven, and less code is needed in each fhandler.

Type flags from stat() are ORed, and only "understandable" types are
returned to the callers (while the rest is remembered for further
handling if need be.
IMHO, optimization of such code to get calls that would never return
anything is of later concern: first be complete, then be optimal.

* Huh? Not sure of the meaning of these two paragraphs. Time for me to
read susv2 on this I think.

>> Documentation: I have the tendency to document my source code
>> thouroughly, which generally provides enough technical documentation
>> to build a how-this-works document on, if needed, I'll be happy to
>> make such documentation too..
>> All that being said, I just have one question left: does it make
>> sense for me to checkout the CVS sources of the fhandler_*.cc,
>> dir.cc, syscalls.cc, etc. files, or are they not likely to have been
>> changed since 1.3.3-2?
> they change all the time. The best bet is to CVS checkout the lot. And
> then either subscribe to cygwin-cvs and update as needed, or use cvs
> diff a fair bit, or just get in the routine of doing cvs update -Pd
> before you start hacking each evening/morning/whenever. Update
> regularly so that incremental changes don't cause you merge nightmare.
> Also a good idea if chris is willing, is for you to create a cvs
> branch for this project, so you can be developing under change
> control, which will give you a bit more flexability. Then as things
> become stable, you can produce specific patches for specific
> achievements/milestones.
I'm already subscribed to the cygwin-cvs list - have been for about a
week now. I'll be downloading the CVS then..
As for making a branch in the repository and allowing me access - it
might be a good idea, but I don't know how necessary it will be: I have
my own repository here, in which I'll be putting whatever I do for
cygwin under version control as well, so making big patches should not
be a problem. A branch in the repository is only interesting if others
will be working on the same thing (i.e. fixing the magic dirs problems),
which is not current (I think?).

* I have some interest in this, and was planning on the occasional peek
:].

I've taken a look at the current stat() implementation. My guess is it
can't stay: should be replaced by a call to the stat()s in the fhandlers
asking "is this yours?", again, followed by some conflict resolution..

* NO!. Or rather "yes th current stat is win32 only and it has to go,
but this continuation meme you have will make your life very very hard".
Examine _open (). Examine it a little further with my mount table
alterations. Stat should look identical. There is _no_ continuation
issue or strategy involved in this architecture. _ever_. I'm happy to
draw up a how-fhandlers-work document if needed. (I think I grok them,
Chris or Corinna will probably want to confirm what I write :})

Cheers,
Rob
