From: "Ronald Landheer" <info@rlsystems.net>
To: <cygwin-patches@cygwin.com>
Subject: fhandlers codebase, magic dirs, etc.
Date: Sat, 29 Sep 2001 04:05:00 -0000
Message-id: <NFBBLOMHALONCDMPGBLFEEMHCCAA.info@rlsystems.net>
X-SW-Source: 2001-q3/msg00235.html

Hello all,

As I'm going to be working on the opendir(), readdir() and stat() 
problems with magic dirs, I just want to make sure I got some things 
straight, and make some things clear, so here goes:

First off: as I understand it, the readdir() and opendir() code is not 
part of the fhandlers, but should be, so should be migrated there, and 
the existing opendir() and readdir() implementation should call the ones 
in the fhandlers to take care of the dirty work, correct?

Each and every fhandler, all of which handle something different, should 
have its own implementation of opendir() and readdir(), possibly 
inherited from a parental class they're all based on (excuse me if the 
jargon isn't right - I haven't done C++ in a while), which should resp. 
make a list of the available stuff and return items on that list to the 
wrapper, correct? (Or - which is probably a better idea - the opendir() 
implementation should return a list, and the readdir() should simply 
return the items on that list, which would not require a readdir() 
implementation in each fhandler).

Depending on the type of fhandler that finds stuff in the requested 
opendir() call, the opendir() wrapper should or should not continue to 
the other fhandler classes' opendir() implementations - e.g. in 
/registry, only registry items will be listed, and no files, correct?

Legal stuff: I should fill out the form and send it to RedHat by 
snailmail, signing over the copyrights of whatever I'll be doing, 
correct?

Time stuff: I will probably not have much time to work on this during 
the weeks - this is an after-hours thing for me, so please don't expect 
a full-time effort on my part :)

Codebase: I haven't gotten familiar with it yet - I'll be starting that 
now. As a result, the above suggestions may be complete bullshit and 
should be regarded with that possibility in mind. This is just what a 
tired mind got from a discussion on the cygwin mailing list..

Documentation: I have the tendency to document my source code 
thouroughly, which generally provides enough technical documentation to 
build a how-this-works document on, if needed, I'll be happy to make 
such documentation too..

All that being said, I just have one question left: does it make sense 
for me to checkout the CVS sources of the fhandler_*.cc, dir.cc, 
syscalls.cc, etc. files, or are they not likely to have been changed 
since 1.3.3-2?

Greetz!

Ronald

NB: I'll be starting on stat(), which should start returning information 
    on magic directories. I will not change the output structure of
    stat(), ofcourse, but I might add an internal flag or something -
    something to let opendir() know that what we've just stat()ed was a
    magic dir, if it was..
