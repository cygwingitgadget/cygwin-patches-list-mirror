From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Ronald Landheer" <info@rlsystems.net>, <cygwin-patches@cygwin.com>
Subject: Re: fhandlers codebase, magic dirs, etc.
Date: Sat, 29 Sep 2001 05:47:00 -0000
Message-id: <041101c148e5$16dfc940$01000001@lifelesswks>
References: <NFBBLOMHALONCDMPGBLFEEMHCCAA.info@rlsystems.net>
X-SW-Source: 2001-q3/msg00236.html

My mailer decided not to indent your email. (Thanks MS!!!) so I'll mark
my lines with *...


----- Original Message -----
From: "Ronald Landheer" <info@rlsystems.net>
To: <cygwin-patches@cygwin.com>
Sent: Saturday, September 29, 2001 9:04 PM
Subject: fhandlers codebase, magic dirs, etc.


Hello all,

As I'm going to be working on the opendir(), readdir() and stat()
problems with magic dirs, I just want to make sure I got some things
straight, and make some things clear, so here goes:

First off: as I understand it, the readdir() and opendir() code is not
part of the fhandlers, but should be, so should be migrated there, and
the existing opendir() and readdir() implementation should call the ones
in the fhandlers to take care of the dirty work, correct?

* check.

Each and every fhandler, all of which handle something different, should
have its own implementation of opendir() and readdir(), possibly
inherited from a parental class they're all based on (excuse me if the
jargon isn't right - I haven't done C++ in a while), which should resp.
make a list of the available stuff and return items on that list to the
wrapper, correct? (Or - which is probably a better idea - the opendir()
implementation should return a list, and the readdir() should simply
return the items on that list, which would not require a readdir()
implementation in each fhandler).

* the term is virtual method when you are referring to a class's
specific method implementation being inherited, with the _option_ to
override it when needed. As for opendir returning a list - I think thats
a possibility, as long as you make readdir virtual, so that
non-conforming fhandlers (say ones on _slow_ links.. ) can decide not to
do it that way.

Depending on the type of fhandler that finds stuff in the requested
opendir() call, the opendir() wrapper should or should not continue to
the other fhandler classes' opendir() implementations - e.g. in
/registry, only registry items will be listed, and no files, correct?

* the opendir wrapper will look very similar to the open wrapper. That
is to say that there is one and only one fhandler that matches a
specific path. So there is no "continue to" logic at all.

Time stuff: I will probably not have much time to work on this during
the weeks - this is an after-hours thing for me, so please don't expect
a full-time effort on my part :)

* sure :}. Same here by the way.

Codebase: I haven't gotten familiar with it yet - I'll be starting that
now. As a result, the above suggestions may be complete bullshit and
should be regarded with that possibility in mind. This is just what a
tired mind got from a discussion on the cygwin mailing list..

* fairly close. I have one thing to add and that is that the readdir
wrapper needs to add (and when necessary override) the fhandler returned
entries for mounted fhandlers below the open node. An example: in / we
mount a registry fhandler at /registry, and a devfs handler at /devfs.
Opendir (/) goes to the fhandler_base (which IMO should be split into
fhandler_win32 and a real fhandler_base that has almost no
functionality - different discussion though ;}).

* lets say that there is a dir called registry in the cygwin root, and
not one called dev. We want ls / to show both registry and dev.
* Now, special case 1: readdir (/ (fhandler_base)) returns a "registry"
entry. The readdir wrapper sees that "registry" conflicts with the mount
table entry /registry and replaces any relevant metadata in the response
to the calling app. Such metadata could be obtained by a call to stat
(/registry (which ends up going to fhandler_registry))
* Special case 2: (BTW: I'm assuming readdir() returns unsorted entries
here). readdir (/ (fhandler_base)) returns end-of-list, and the readdir
wrapper notices that "dev" has not been listed. So the wrapper adds
"dev" to the returned list.

Documentation: I have the tendency to document my source code
thouroughly, which generally provides enough technical documentation to
build a how-this-works document on, if needed, I'll be happy to make
such documentation too..

All that being said, I just have one question left: does it make sense
for me to checkout the CVS sources of the fhandler_*.cc, dir.cc,
syscalls.cc, etc. files, or are they not likely to have been changed
since 1.3.3-2?

* they change all the time. The best bet is to CVS checkout the lot. And
then either subscribe to cygwin-cvs and update as needed, or use cvs
diff a fair bit, or just get in the routine of doing cvs update -Pd
before you start hacking each evening/morning/whenever. Update regularly
so that incremental changes don't cause you merge nightmare. Also a good
idea if chris is willing, is for you to create a cvs branch for this
project, so you can be developing under change-control, which will give
you a bit more flexability. Then as things become stable, you can
produce specific patches for specific achievements/milestones.

Greetz!

Ronald

NB: I'll be starting on stat(), which should start returning information
    on magic directories. I will not change the output structure of
    stat(), ofcourse, but I might add an internal flag or something -
    something to let opendir() know that what we've just stat()ed was a
    magic dir, if it was..

* IMO that shouldn't be needed. opendir () will always resolve via the
mount table, and an item is a magic dir If and Only If it is listed in
the mount table. All other dirs are handled by the matching fhandler.
(magic dirs are also handled by the fhandler, the difference is that the
readdir wrapper has no special cases when there are no mount entries for
nodes below the opened one.

* Rob.
