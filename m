From: "Ronald Landheer" <info@rlsystems.net>
To: "Robert Collins" <robert.collins@itdomain.com.au>, <cygwin-patches@cygwin.com>
Subject: RE: fhandlers codebase, magic dirs, etc.
Date: Sat, 29 Sep 2001 14:14:00 -0000
Message-id: <NFBBLOMHALONCDMPGBLFAEMNCCAA.info@rlsystems.net>
References: <041101c148e5$16dfc940$01000001@lifelesswks>
X-SW-Source: 2001-q3/msg00238.html

Hi Robert,

> My mailer decided not to indent your email. (Thanks MS!!!) so I'll
> mark my lines with *...
You probably have the same mailer I do - I forget why I haven't changed everything to StarOffice yet..
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
Oh in any case, I will :) I was just hoping that someone would know very sure and fill in details..

>> Each and every fhandler, all of which handle something different,
>> should have its own implementation of opendir() and readdir(),
>> possibly inherited from a parental class they're all based on (excuse
>> me if the jargon isn't right - I haven't done C++ in a while), which
>> should resp. make a list of the available stuff and return items on
>> that list to the wrapper, correct? (Or - which is probably a better
>> idea - the opendir() implementation should return a list, and the
>> readdir() should simply return the items on that list, which would
>> not require a readdir() implementation in each fhandler).
> the term is virtual method when you are referring to a class's
> specific method implementation being inherited, with the _option_ to
> override it when needed. As for opendir returning a list - I think
> thats a possibility, as long as you make readdir virtual, so that
> non-conforming fhandlers (say ones on _slow_ links.. ) can decide not
> to do it that way.
Good idea - provides for flexibility as well as sturdiness..

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
Type flags from stat() are ORed, and only "understandable" types are 
returned to the callers (while the rest is remembered for further 
handling if need be.
IMHO, optimization of such code to get calls that would never return 
anything is of later concern: first be complete, then be optimal.

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

I've taken a look at the current stat() implementation. My guess is it 
can't stay: should be replaced by a call to the stat()s in the fhandlers 
asking "is this yours?", again, followed by some conflict resolution..

I'll start doing some sketches (on paper - when I say I'm going to the 
drawing boards, I actually mean it) and will get back to y'all :)

Greetz!

Ronald
