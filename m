From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]List Categories and Requireds in setup.log.full
Date: Sat, 30 Jun 2001 20:17:00 -0000
Message-id: <20010630231734.A2590@redhat.com>
References: <016801c101b0$310b2390$6464648a@ca.boeing.com>
X-SW-Source: 2001-q2/msg00391.html

On Sat, Jun 30, 2001 at 02:59:33PM -0700, Michael A. Chase wrote:
>I don't know where to start, but perhaps the choose dialog box's
>horizontal size could be set dynamically.  We seem to go through having
>to re-size it by hand rather often.  In this case, I simply bumped the
>applicable x dimensions by 100.

I agree that the dialog box should be auto-resized.  I'd have to
research where to start with this.  I think I did this in a previous
life but I don't remember how.

>In do_choose(), I also re-restored the change that removed "\r" from
>messages sent to setup.log.full and again changed the source_exists
>logic so local copies of source archives are mentioned in
>setup.log.full.  I don't mention them in this ChangeLog entry since
>they are already in ChangeLog.

I checked in most of these.  I didn't checkin your changes to make the
log messages indicate the function where the error occurred.  I agree
that this is useful information but I don't think that we should be
adding it in only these two places.  I think that log() should probably
be a macro that passes __PRETTY_FUNCTION__ as the first argument to a
__log function.  Then every log message will have the function name
automatically.  This is basically how cygwin does it.

I also didn't check in your other changes to set_action.  I would rather
keep the tests all within one switch statement.

Thanks for the patch!
cgf
