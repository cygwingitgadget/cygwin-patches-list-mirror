From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]Write Mount Commands
Date: Mon, 03 Sep 2001 17:54:00 -0000
Message-id: <004801c134db$72b7b9d0$200a0a0a@us.oracle.com>
References: <000c01c134af$0f165ed0$200a0a0a@us.oracle.com> <20010903180302.A3225@redhat.com>
X-SW-Source: 2001-q3/msg00096.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Monday, September 03, 2001 15:03
Subject: Re: [PATCH]Write Mount Commands


> On Mon, Sep 03, 2001 at 12:31:25PM -0700, Michael A. Chase wrote:
> >Here's the patch to mount to tell it to write the commands needed to
> >re-create the current mount table.
> >
> >Users of Win9x might be confused if they create the commands from a bash
> >prompt and then try to run the resulting file from command.com.  In my
> >system (which has binary mount points),
> >   mount -m > file
> >produced a file with NL line endings which command.com chokes on.
Running
> >the same command from the MSDOS prompt produced a file with CRLF line
> >endings.
>
> That's what I would expect.
>
> I've checked this in.  It looks very nice, with one exception.
>
> I don't think you should be displaying mount commands for the default
drive
> stuff, i.e. mount -f -u -t "u:" "/cygdrive/u"

I didn't realize I was.  In my system, all the potential /cygdrive/u entries
are already explicitly mounted which hides the feature of getmntent() which
returns the /cygdrive/u entries along with the explicit mounts.  I'll see if
there is some way I can filter those out.  If you can give me a hint, that
would make my work quicker.

> Also, I wonder if it would be nicer only to quote the path specs which
contain
> spaces?

I decided it was safer to quote regardless.  There are more than just spaces
that could cause problems and I didn't want to take the chance of missing a
couple.  I guess I could check for (") and escape it, but that would
probably break calling the output script from MSDOS.

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

