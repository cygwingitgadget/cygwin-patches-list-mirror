From: Chris Faylor <cgf@redhat.com>
To: Dave Sainty <dave@dtsp.co.nz>
Cc: cygwin-patches@cygwin.com
Subject: Re: Patch to make setrlimit() more forgiving
Date: Fri, 05 Jan 2001 08:17:00 -0000
Message-id: <20010105111729.C1649@redhat.com>
References: <20010104214112.A32564@redhat.com> <200101050922.f059MVD30284@mail.redhat.com>
X-SW-Source: 2001-q1/msg00008.html

On Fri, Jan 05, 2001 at 10:23:28PM +1300, Dave Sainty wrote:
>Christopher Faylor writes:
>
>> It looks good but I need a ChangeLog.
>> 
>> cgf
>> 
>> On Fri, Jan 05, 2001 at 03:38:43PM +1300, David Sainty wrote:
>> >Attached is a simple patch that prevents setrlimit() failing with an error
>> >when the operation would not have changed anything.  This allows all
>> >resource types to be set, so long as the setting is identical to the current
>> >pseudo-settings.
>
>Certainly :)  Sorry, I'm sure there was some FAQ I was meant to read
>before posting patches :)
>
>Fri Jan 5 15:38:43 2001  Dave Sainty <david.sainty@dtsp.co.nz>
>
>	* resource.cc: Allow all null setrlimit() operations to succeed

I don't know if there is, but you should probably check the archives for
the correct format of a ChangeLog.  This is also mentioned at
www.gnu.org, somewhere.  Submitting a ChangeLog with a patch is a pretty
standard net procedure.

This is almost correct, but if you look at the current Cygwin ChangeLog,
you can see that it is missing a function name and a period.

I'll add those and check this in.

cgf
