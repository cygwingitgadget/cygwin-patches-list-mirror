From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@Cygwin.Com
Subject: Re: _ANONYMOUS_STRUCT (again)
Date: Mon, 10 Sep 2001 13:24:00 -0000
Message-id: <20010910162415.A17101@redhat.com>
References: <20010910044816.4205.qmail@web14509.mail.yahoo.com> <20010910135122.A13759@redhat.com> <20010910135605.A15863@redhat.com> <3B9D03AC.4E648C07@yahoo.com> <20010910143015.A16107@redhat.com>
X-SW-Source: 2001-q3/msg00121.html

On Mon, Sep 10, 2001 at 02:30:15PM -0400, Christopher Faylor wrote:
>On Mon, Sep 10, 2001 at 02:17:16PM -0400, Earnie Boyd wrote:
>>Christopher Faylor wrote:
>>> >I'm not wild about using something called NONAMELESSUNION to control
>>> >whether a nameless *structure* is defined but I guess it's ok.
>>
>>Never the less, the MSDN will have the control on how this is
>>implemented if it applies in this case.  Or is NONAMELESSUNION something
>>we've made up along the way?
>
>I just checked.
>
>It's a Microsoft invention and the use it the same way, so I guess
>we're "good company".

Are you going to check this in, Earnie?  It seems like it should go into
the (mythical?) 1.3.3 cygwin release.

cgf
