From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Ronald Landheer" <info@rlsystems.net>, <cygwin-patches@cygwin.com>
Subject: Re: fhandlers codebase, magic dirs, etc.
Date: Sun, 30 Sep 2001 16:03:00 -0000
Message-id: <00d701c14a04$497f03f0$01000001@lifelesswks>
References: <NFBBLOMHALONCDMPGBLFCENKCCAA.info@rlsystems.net>
X-SW-Source: 2001-q3/msg00250.html

----- Original Message -----
From: "Ronald Landheer" <info@rlsystems.net>
To: "Robert Collins" <robert.collins@itdomain.com.au>;
<cygwin-patches@cygwin.com>
Sent: Monday, October 01, 2001 6:02 AM
Subject: RE: fhandlers codebase, magic dirs, etc.


Hi Robert,

> Ronald, if you are using a MS mailer, are you sending HTML mail? I
> notice that HTML mails that get stripped seem to confuse MS Outlook
> express, which is what I have open today :].
I am using M$ Outlook 2000 for mail, but I always send text-only (with
one minor exception in the last week).
I don't know what's confusing your mailer :(

* I'm trying to pin it down. I have Outlook2k in the office, I'll test
that tomorrow. Q: Are you sending via an exchange server, or are you in
"internet mode"?

> ah yes, on closer inspection I can see what you mean... and that does
> need to be thought through. The concept of special nodes is not
> currently clear in cygwin. That is, some files with special names get
> diverted to specific fhandlers - ie /dev/null - which is one of the
> things that this work promises to eliminate (or at least remove from
> the core code to a "devfs" fhandler. And files opened via specific
> system calls, such as bind, are diverted to different fhandlers via
> the internal fd table. But unless I've missed something, no file
> located by a path is diverted _based on the 'type' of the file_. The
> reason for that is that there is no mechanism to query the parent node
> of the file for it's fhandler type. (And that's how it should be done,
> rather than iterating through the fhandlers.) There are bits of code
> that resemble this - ie detecting /dev/null as mentioned before - but
> they only go so far. My 2c for this one is to leave it for another
> day. Simply consider all files as being 'owned' by the fhandler
> associated with the longest matching mount entry. Extend the
> build_fhandler (?? writing from memory) class factory to have that
> matching fhandler act as a factory for files located within its
> domain. If the file actually needs a different fhandler, then that
> matching fhandler's factory will return a fhandler of the appropriate
> type. Make that factory function a virtual, with the default to return
> "this" and for the general case, you will have no coding to do. Then
> for something like devfs, where the sub paths "null", "clipboard" and
> so on are different classes, the devfs factory creates instances of
> the appropriate fhandler. What we are really doing is federating the
> class factory. This, like the stat change to be similar to open is a
> fundamental change, but one that adds significant opportunities. (BTW:
> this particular change is probably about 50 lines of code in total -
> somewhat trivial).
The only problem I still see here is one of logic: handling any file as
owned by the fhandler that happens to be mounted at the longest matching
mountpoint means *every* fhandler should be able to handle *every* type
of file that *might* exist within the space of "owns". This means that

* Not quite. The fhandler needs to be able to _identify_ the appropriate
fhandler for every file. This is a very different thing.

handling *any* type of file that might occur anywhere must be a _very_
basic feature - i.e. a virtual method, part of the most common
denominator of inherited virtual methods. That may require some
explaining - which can be done, ofcourse, but IIRC, Li-Kai Liu had a
point in this direction to make on the original thread over at
cygwin@cygwin.com (the thread was called "[PATCH] ls & "magic" cygdrive
dir (was: RE: cygdrive stuff)").
Personally, I think the code will be a lot better off when the long-term
goal of splitting filesystem handling and file handling is what we shoot
for now: it will be clearer who gets to do what, and most of the actual
file handling stuff is already there anyway.

* Sure. No argument.

What would have to be done is design a good system of filesystem
handling - which is kinda what we're doing here anyway. To me, the logic
telling us to do that is a lot clearer than just leaving it for later.
Chris talked about small incremental steps for OpenSource software
development. I agree that that is better in most cases, but in this
case, redesigning the system is, IMHO, the way to go, as it repairs the
bug reported by Salvador earlier, reaches a goal that has been there for
some time, clears up the codebase, and makes it a lot easier to add new
functionalities later. (It would have to be branched off the main stream
Cygwin code, though, as replacing something is generally done by taking
it out and putting something in its place, and taking the current system
out would break Cygwin terribly..).

* Baby steps _can be done_. I'll draw up a new email on this.

One problem with this approach is that it will take a while, and I don't
know how stable the rest of the API: as all of Cygwin is changing
continually, hooking this into the rest of Cygwin may require different
hooks at different times..
Another problem is that I definitely have to get the sandpaper out and
grate the rust off my C++, but OK..

>> I hadn't decided between the two yet, but with a bit of thought -
>> i.e. the concept of mounting the fhandler for /dev at /dev settling
>> in my synapses - I agree with not having the "continue to" logic:
>> it's just a matter of who owns the directory, and asking him (the
>> proper fhandler) for the data.
> Yes exactly my point. You where correct however, in that there are two
> cases and both have to be addressed. So the solution is to *do both*.
> Pass the responsibility onto the proper fhandler (as determined by the
> mount table) and if it has special virtual stuff to do, it does it.)
Exactly: pass the responsability to the owner of the place. If, for
example, I want to open a _file_ in /dev, I call the handler (owner) of
/dev to open it, who sees it's a normal file and opens it accordingly -
whether opening a normal file should be part of the job of the handler
of /dev, or should be part of the job of a class that handles regular
files - I'd go for the second (i.e. mount an fhandler over each regular
file to handle those, and a file system handler over each part of the
file system).

** I'm a little confused my the term mount here. By mount I mean write
an entry into the registry to identify where different fhandlers take
over. i.e. devfs at /dev.

I.e. the open() function would pretty much do this:
* where is it? (who owns it?)
* ask the owner: what is it? (who should handle it)
* tell the handler: open it!
A call to stat() would just do the first two.

** I have a similar concept. BTW stat() looks inside the file on cygwin,
to see if it is executable by magic number on FAT where there is no
native win32 x bit. This can be skipped on NT when ntsec is on, and
obviously should not be done when we have direct support for other fs's
with a x bit.
My idea of stat looks like:
* owner = who 'owns' "filename";
* owner->stat().
Because its the owner of the file that knows how to retrieve metadata.
My idea of open for comparison:
* owner = who 'owns' "filename";
* handler = owner->makefhandler("filename");
* handler->open (parameters);

You'll note that the existing open looks very similar to this: create an
appropriate fhandler, and then get it to do the open.

Hopefully that shows why you want the longest mount point match. The
win32 filesystem handling code should never get asked _anything_ about
/registry/HKEY_LOCAL_MACHINE.

But likewise the device filesystem handler doesn't directly know how to
open the clipboard, so we pass the responsibility for identifying the
fhandler to the filesystem handler.

Rob
