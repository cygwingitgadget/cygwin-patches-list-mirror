From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: RFP : shell defaults
Date: Sat, 15 Dec 2001 23:32:00 -0000
Message-ID: <104801c18603$c811fb10$0200a8c0@lifelesswks>
References: <m33d2pam3l.fsf@appel.lilypond.org> <00d501c17d93$1936c990$0200a8c0@lifelesswks> <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <20011213215355.GA20040@redhat.com>
X-SW-Source: 2001-q4/msg00319.html
Message-ID: <20011215233200.2GbLEOt32a1NiRNyLx8bD3AkAOm1jvhmIPuQ4_57474@z>

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>

> I believe that the prompt reflects DJ Delorie's prompt preference,
which
> was, apparently, two lines.
>
> *I'd* prefer no prompt setting at all, actually.  I think that prompt
> setting should be up to the user or the local sysadmin.  AFAICT, even
> Red Hat doesn't try to make a prompt decision for you.

If someone wants to follow my notes in reply to Corinna and create a
shell defaults package, that would be great. AFAIK all distro's generate
a very simply prompt for you, and then leave it up to you.

Setup.exe can leave this aside for the moment (see the other email), and
once a package is in place we can strip out the etc_profile code.

Rob
