From: DJ Delorie <dj@delorie.com>
To: juliano@cs.unc.edu
Cc: cygwin-patches@sources.redhat.com
Subject: Re: cinstall contribution
Date: Fri, 14 Jul 2000 15:22:00 -0000
Message-id: <200007142222.SAA16834@envy.delorie.com>
References: <Pine.SGI.4.10.10007111450500.361924-100000@cystine.cs.unc.edu> <396B7FC4.188536DC@delorie.com> <200007112129.RAA03821@envy.delorie.com> <396F377E.F3ADDEF6@cs.unc.edu> <200007141712.NAA14485@envy.delorie.com> <396F9057.83997899@cs.unc.edu>
X-SW-Source: 2000-q3/msg00015.html

> Did that, but I additionally patched concat to prevent a crash when
> root_mount remained unset.

Others have suggested that, but in all the cases where that patch
would help, what you *really* need is a test for root_dir==NULL
elsewhere to change the logic so that concat isn't calles.  Otherwise,
you end up passing an null pointer as a filename, which is a bad idea.

> Changed it.  I was trying to emulate your conventions elsewhere in that
> file.

Yeah, well, different code needs different style.  My preference is to
design my functions so that I can abort them (by returning) when
errors are encountered, but there are times when I'm just trying
something to see if it works and, if so, doing a little extra
processing.  That's when you see the reverse test.

> "line" is for catching the case where the URL in the file is longer than
> 1000 characters.  Something that's automatically handled by:
> 
> How else do you do that in C?

With fgets.  One of the parameters is the size of the buffer.  If the
url exceeds 1000 characters, it just gets truncated.  Otherwise, you
could stat() the file and allocate a buffer.

> But, I exposed a function in site.cc to other.cc, through a new file
> site.h.  It's kind of ugly, but I didn't know where else to put it. 

site.h is correct.  I prefer that each "foo.cc" has a "foo.h" that
describes the interface to that file.  Obvious exception: dialog.h
prototypes all the dialog entries, because using a macro to do that
makes it easier to maintain, and it also removes the need for a lot of
trivial *.h files.
