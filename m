From: Christopher Faylor <cgf@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>, newlib@sources.redhat.com
Subject: Re: [PATCH]: (f)pathconf/unistd.h, _PC_POSIX_PERMISSIONS and _PC_POSIX_SECURITY
Date: Sat, 17 Mar 2001 12:05:00 -0000
Message-id: <20010317150539.A9057@redhat.com>
References: <20010317192444.R20900@cygbert.vinschen.de> <20010317132837.A9098@redhat.com> <20010317195753.S20900@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00201.html

On Sat, Mar 17, 2001 at 07:57:53PM +0100, Corinna Vinschen wrote:
>On Sat, Mar 17, 2001 at 01:28:37PM -0500, Christopher Faylor wrote:
>> On Sat, Mar 17, 2001 at 07:24:44PM +0100, Corinna Vinschen wrote:
>> >I have added two new values to the Cygwin pathconf and fpathconf system
>> >calls.
>> >
>> >	pathconf (filename, _PC_POSIX_PERMISSONS)
>> >	fpathconf (fd, _PC_POSIX_PERMISSONS)
>> 
>> Cool! Thanks.  Out of curiousity, are these standard arguments for
>> pathconf or did you have to invent them?
>
>I searched for appropriate constants in X/Open, SUSv2 and Linux
>but I didn't find any. So I had to invent them, unfortunately.

Well, they look official, anyway.  :-)

cgf
