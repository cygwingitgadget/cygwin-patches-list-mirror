From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Ronald Landheer" <info@rlsystems.net>, <cygwin-patches@cygwin.com>
Subject: Re: fhandlers codebase, magic dirs, etc.
Date: Sun, 30 Sep 2001 08:05:00 -0000
Message-id: <007501c149c1$867d29f0$01000001@lifelesswks>
References: <NFBBLOMHALONCDMPGBLFGENFCCAA.info@rlsystems.net>
X-SW-Source: 2001-q3/msg00245.html

More * lines :}.

Ronald, if you are using a MS mailer, are you sending HTML mail? I
notice that HTML mails that get stripped seem to confuse MS Outlook
express, which is what I have open today :].

----- Original Message -----
From: "Ronald Landheer" <info@rlsystems.net>



> I disagree. If a "real" file can exist in /dev, that is the
> responsibility of the dev fhandler to manage that. The dev fhandler
> will still do all the grunt work. A directory is just a file that
> points to other files. So the logic for what fhandler looks after a
> fiven directory is _identical_ as for looking after files.
Then you *do* agree - with the second option: if a fhandler handles a
type of directory - say, the /dev dir - the fhandler for it shows
everything in it, and there's no "continue to" logic to be followed.

* ah yes, on closer inspection I can see what you mean... and that does
need to be thought through. The concept of special nodes is not
currently clear in cygwin. That is, some files with special names get
diverted to specific fhandlers - ie /dev/null - which is one of the
things that this work promises to eliminate (or at least remove from the
core code to a "devfs" fhandler. And files opened via specific system
calls, such as bind, are diverted to different fhandlers via the
internal fd table. But unless I've missed something, no file located by
a path is diverted _based on the 'type' of the file_. The reason for
that is that there is no mechanism to query the parent node of the file
for it's fhandler type. (And that's how it should be done, rather than
iterating through the fhandlers.) There are bits of code that resemble
this - ie detecting /dev/null as mentioned before - but they only go so
far. My 2c for this one is to leave it for another day. Simply consider
all files as being 'owned' by the fhandler associated with the longest
matching mount entry. Extend the build_fhandler (?? writing from memory)
class factory to have that matching fhandler act as a factory for files
located within its domain. If the file actually needs a different
fhandler, then that matching fhandler's factory will return a fhandler
of the appropriate type. Make that factory function a virtual, with the
default to return "this" and for the general case, you will have no
coding to do. Then for something like devfs, where the sub paths "null",
"clipboard" and so on are different classes, the devfs factory creates
instances of the appropriate fhandler. What we are really doing is
federating the class factory. This, like the stat change to be similar
to open is a fundamental change, but one that adds significant
opportunities. (BTW: this particular change is probably about 50 lines
of code in total - somewhat trivial).

I hadn't decided between the two yet, but with a bit of thought - i.e.
the concept of mounting the fhandler for /dev at /dev settling in my
synapses - I agree with not having the "continue to" logic: it's just a
matter of who owns the directory, and asking him (the proper fhandler)
for the data.

* Yes exactly my point. You where correct however, in that there are two
cases and both have to be addressed. So the solution is to *do both*.
Pass the responsibility onto the proper fhandler (as determined by the
mount table) and if it has special virtual stuff to do, it does it.) <--
snapshot of my much longer paragraph above :].


> * Huh? Not sure of the meaning of these two paragraphs. Time for me to
> read susv2 on this I think.
Never mind - my mind was skipping over a rope while it should be
balancing a wire.. The "data driven" approach is better - doesn't
require as much special coding, and wouldn't require the "completeness
over optimisation" approach to coding. (Though that is generally a
reasonable approach to start out with).

* I agree with that. I usually find that a clear design with orthogonal
components leads to some serious optimisation down the track. I.e. the
design allows for greater optimisation _eventually_.

>> I've taken a look at the current stat() implementation. My guess is
>> it can't stay: should be replaced by a call to the stat()s in the
>> fhandlers asking "is this yours?", again, followed by some conflict
>> resolution..
> NO!. Or rather "yes th current stat is win32 only and it has to go,
> but this continuation meme you have will make your life very very
> hard".
With some more second though, I agree this would make my life harder.
Though the current stat() implementation should go, replaced by
something more general/generic.
I agree it should not be a "does this belong to you?" approach, but I
guess it should be done by the fhandler handling whatever
directory/mount point is being looked in..

* Yes, I think we're on the same wavelength now :}. Sorry for my slight
concept blindness before.

Please do - you probably know the layout already, which means that I
don't have to start at nothing figuring out how it works.

* Tomorrow I will knock something up.

Rob
