From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]Write Mount Commands
Date: Mon, 03 Sep 2001 15:03:00 -0000
Message-id: <20010903180302.A3225@redhat.com>
References: <000c01c134af$0f165ed0$200a0a0a@us.oracle.com>
X-SW-Source: 2001-q3/msg00093.html

On Mon, Sep 03, 2001 at 12:31:25PM -0700, Michael A. Chase wrote:
>Here's the patch to mount to tell it to write the commands needed to
>re-create the current mount table.
>
>Users of Win9x might be confused if they create the commands from a bash
>prompt and then try to run the resulting file from command.com.  In my
>system (which has binary mount points),
>   mount -m > file
>produced a file with NL line endings which command.com chokes on.  Running
>the same command from the MSDOS prompt produced a file with CRLF line
>endings.

That's what I would expect.

I've checked this in.  It looks very nice, with one exception.

I don't think you should be displaying mount commands for the default drive
stuff, i.e. mount -f -u -t "u:" "/cygdrive/u"

Also, I wonder if it would be nicer only to quote the path specs which contain
spaces?

Thanks for doing this.  I've wanted something like this for a long time.

There are obviously ways to write a script to do what you've done here and
maybe that would be better unix philosophy but I still think making this
a mount option will be easier to explain to people who are interested in
this option.

cgf
