From: Christopher Faylor <cgf@redhat.com>
To: Earnie Boyd <earnie_boyd@yahoo.com>, Danny Smith <danny_r_smith_2001@yahoo.co.nz>, newlib@sources.redhat.com
Cc: cygwin-patches@cygwin.com
Subject: Re: Collisions between newkib and w32api sockets
Date: Tue, 20 Mar 2001 11:32:00 -0000
Message-id: <20010320143258.A9325@redhat.com>
References: <20010311010816.26058.qmail@web6405.mail.yahoo.com> <20010316231749.B4403@redhat.com> <3AB4EFE1.107885B@yahoo.com> <20010318124432.K12880@redhat.com>
X-SW-Source: 2001-q1/msg00214.html

On Sun, Mar 18, 2001 at 12:44:32PM -0500, Christopher Faylor wrote:
>On Sun, Mar 18, 2001 at 12:26:57PM -0500, Earnie Boyd wrote:
>>Chris,
>>
>>If you can affect the newlib change today, I'll take care of the w32api
>>changes.  If not it'll have to wait toward the end of next week.
>
>Unfortunately, I think that parts of this are outside of my
>maintainership authority so I can't check this stuff in until
>Jeff Johnston gives the go-ahead.

I have checked this into both the newlib and w32api directories.

I did add a guard against the warning for cases that include sys/types.h
and winsock*.h and know what they are doing.

Thanks.
cgf
