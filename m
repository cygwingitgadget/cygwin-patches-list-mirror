From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 28 Dec 2001 04:22:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKGEBKCIAA.g.r.vansickle@worldnet.att.net>
References: <06d901c18f92$6209ef60$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00361.html
Message-ID: <20011228042200.kGewaOGyXNOF-2Zl6lmCvinH2_5Z6oJiFAOorUFmHVg@z>

> Thanks. BTW: If you can identify what made that huge patch (my money is
> on indent 2.2.7 inserting ^M's)'s that would be handy.
>
> Rob

It's highly bizarre, but AFAICT it's not indent but rather something wrong with
"cvs diff".  Here's my investigation so far, I'm on all text mounts:

Experiment 1:
- mv my altered, indented "window.h" to "window.h.temp".  A hex editor shows it
to have the correct CRLF line endings (i.e. no extra CRs or something like
that).
- do a clean checkout of cvs's window.h.  The file on my system also shows
correct CRLF line ends.
- A "cvs diff" on the clean, just-checked-out source shows no differences.
- Do a "diff window.h window.h.temp" (not "cvs diff").  Shows only the actual
changes, not the entire file as being different.
- Replace the unaltered "window.h" with my "window.h.temp", and the "cvs
diff -pu" shows every line of the file to be different.
- Run "d2u" on my local "window.h", which is now the altered one.  "cvs
diff -pu" *still* shows every line to be different!  (so does a plain "cvs
diff", no -pu).

Experiment 2:
- Take a clean window.h, mv it to a new name, indent.
- Recheck out a clean window.h.
- Both show the same valid CRLF line endings.
- "cvs diff", every line is different.  "diff", nothing is different (even
though two lines are in fact indented differently - I thought you had to
"diff -b" to ignore WS changes?).

So I guess I'm out of WAGes now, unless cvs is tracking the file-moving and
claiming that a file with, say, the same contents but a different creation date
or something is completely different, regardless of contents.  But I don't think
that would explain the initial problem because I never moved any files.

--
Gary R. Van Sickle
Brewer.  Patriot.
