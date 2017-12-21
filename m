Return-Path: <cygwin-patches-return-8983-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45854 invoked by alias); 21 Dec 2017 08:29:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45837 invoked by uid 89); 21 Dec 2017 08:29:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=newbie, belatedly, air, H*Ad:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 21 Dec 2017 08:29:43 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vBL8TgxJ023541	for <cygwin-patches@cygwin.com>; Thu, 21 Dec 2017 00:29:42 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 21 Dec 2017 08:29:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_internal methods to get/set thread name
In-Reply-To: <20171220115122.GF19986@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1712202346060.17134@m0.truegem.net>
References: <20171220080832.2328-1-mark@maxrnd.com> <20171220115122.GF19986@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00113.txt.bz2

On Wed, 20 Dec 2017, Corinna Vinschen wrote:
> Hi Mark,
>
> A lot to discuss here.

Yes, but first let me say I'd call these "speculative" patches, things I 
found necessary during aio library development.  I had an incorrect mental 
picture of the Cygwin DLL: I was treating it as just a user-space DLL 
where, for an add-on library, one was free to use Cygwin constructs or 
pthread constructs, or even Win32 constructs for that matter.

I've now updated that mental picture of the Cygwin DLL to treat it as a 
kernel, where one can only use constructs provided by Cygwin.  So, in the 
aio library there will be cygthreads only and no pthreads or Win32 
threads.  (So I should also separately update the gmon profiler to use a 
cygthread rather than a Win32 thread ;-)).

So these patches reflect the earlier mental picture.  Maybe none of the 
code makes sense in an accurate mental picture.  I wanted to at least air 
the code to see if some use might be made of it before discarding it.

I think most if not all of this stuff wouldn't have been needed if I had 
started with cygthreads at the beginning of aio library development, but I 
was testing a lot of different scenarios and didn't want to have to build 
a Cygwin DLL each time.

> First of all, can you please describe the scenario in which you'd want
> to give a cygthread another name?  Why is the one given at
> cygthread::create time not sufficient?

I wasn't thinking about cygthreads.  I did the pthread-related methods 
first, then noticed the ENOSYS error being done for setting a cygthread 
name.  It was easy to supply a ::setname method.  It didn't occur to me 
that all the cygthread creation methods allow specification of a name.

> Also, why should we need another, non-standard way to read/write a
> pthread name, other than pthread_getname_np/pthread_setname_np?  What is
> that supposed to accomplish?  Is there really any real-world scenario
> which you can't handle with the official entry points?

I was using strace and getting annoyed with it displaying "unknown thread 
0x###" for my aio threads.  At that point they were pthreads and not 
cygthreads.  So that was the impetus for the name-getting additions. 
Name-setting, that's another story.  I thought that perhaps a debugging 
app might want to tag threads of a subject process with names if they 
don't already have names.  But I concede there is no such app at present.

> We really don't want to add more non-standard entry points than
> absolutely necessary.  There are too many already, partially for
> historic reasons.

I can easily agree with this.  If my original use of pthreads for a core 
Cygwin service was the wrong way to go (I think it was) and we would 
rather not encourage that kind of thing, then the pthread-related methods 
should not be implemented.  The cygthread name-setting method can go away 
too.

I do think the "courtesy" added code on the cygthread name-getting method 
has a use: stracing a user program whose pthreads are making Cygwin 
syscalls.  The code in this block allows to get the user-supplied pthread 
name for use in strace logging, rather than having "unknown thread 0x###"
displayed.

> On Dec 20 00:08, Mark Geisert wrote:
>> Add support to cygwin_internal() for setting a cygthread name and getting or setting a pthread name.  Also add support for getting the internal i/o handle for a given file descriptor.
>
> Can you please break the log message in lines <= 72 chars?

Yes; git newbie error.  I belatedly discovered 'git commit --amend' so I 
can add a proofreading step between 'git format-patch' and 'git 
send-email'.

>
>> @@ -710,6 +743,14 @@ cygwin_internal (cygwin_getinfo_types t, ...)
>>  	}
>>  	break;
>>
>> +      case CW_GET_IO_HANDLE_FROM_FD:
>> +	{
>> +	  int fd = va_arg(arg, int);
>> +	  fhandler_base *fh = cygheap->fdtab[fd];
>> +	  res = (uintptr_t) (fh->get_io_handle ());
>> +	}
>> +	break;
>> +
>>        default:
>>  	set_errno (ENOSYS);
>>      }
>
> Nope, we won't do that.  The functionality is already available via
> _get_osfhandle included via <io.h>.

Argh; My search for an existing facility wasn't wide enough.

> Also, note that this is, and always will be a kludge.  There are
> scenarios in which more than one handle is attached to a descriptor
> (e.g., ptys) and the function will return only one.

Understood.  For the testcase scenarios I was/am running, the limited 
functionality of _get_osfhandle() is sufficient.

Thanks for looking the code over.  If there's anything left to resubmit 
after all the whittling to be done, I'll happily do that.
Regards,

..mark
