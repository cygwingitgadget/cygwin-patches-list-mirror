From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup Makefile.common ChangeLog
Date: Wed, 21 Feb 2001 17:04:00 -0000
Message-id: <20010221200320.B7330@redhat.com>
References: <20010221214650.16935.qmail@sourceware.cygnus.com> <3A9456C7.2677485F@yahoo.com>
X-SW-Source: 2001-q1/msg00103.html

On Wed, Feb 21, 2001 at 07:01:11PM -0500, Earnie Boyd wrote:
>corinna@sourceware.cygnus.com wrote:
>> 
>> CVSROOT:        /cvs/src
>> Module name:    src
>> Changes by:     corinna@sources.redhat.com      2001-02-21 13:46:49
>> 
>> Modified files:
>>         winsup         : Makefile.common ChangeLog
>> 
>> Log message:
>>         * Makefile.common: Add `-fvtable-thunks' to COMPILE_CXX.
>> 
>
>
>Are you positive about this patch?  I thought that problems existed
>unless all libraries were compiled -fvtable-thunks.

Huh.  I just asked Corinna to discuss this here to see if anyone had
any idea if this would cause problems.  It sounds like it might be
a potential speedup for cygwin, though?

cgf
