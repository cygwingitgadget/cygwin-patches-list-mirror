From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin (solution?)
Date: Fri, 21 Sep 2001 17:43:00 -0000
Message-id: <20010921204429.A6761@redhat.com>
References: <20010921200803.A6636@redhat.com> <00c001c142fe$3a92a520$a300a8c0@nhv>
X-SW-Source: 2001-q3/msg00183.html

On Fri, Sep 21, 2001 at 08:33:40PM -0400, Norman Vine wrote:
>Christopher Faylor writes:
>>It just occurred to me that people who haven't been able to build
>>strace.exe may have an older Makefile that does not incorporate the
>>changes that I made to Makefile.in which add -I...mingw/include to
>>the mingw_getopt.o compilation.
>>
>>I'm not sure how that could happen since my Makefile is regenerated
>>automatically if the Makefile.in is newer but it sure sounds like
>>this is the problem.
>>
>>The __argv declarations should be coming from mingw's stdlib.h.  There
>>should be no way that this needs to declare this explicitly if the
>>right header file is being included.
>
>This is indeed my problem my make is picking up  stdlib.h from newlib
>and not the from the mingw tree

Ok.  It looks like this is a problem with the VERBOSE entry in
Makefile.in.  I only changed one part of the ifdef which outputs less
information in a build to exclude the newlib directories.

I've checked in a patch.

I'm not sure why you were executing the VERBOSE part of the Makefile by
default but that's a minor bug.  I doubt that anyone besides me really
wants the non-VERBOSE output anyway.

cgf
