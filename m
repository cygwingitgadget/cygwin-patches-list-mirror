Return-Path: <cygwin-patches-return-7330-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11563 invoked by alias); 11 May 2011 12:53:47 -0000
Received: (qmail 11363 invoked by uid 22791); 11 May 2011 12:53:44 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 12:53:30 +0000
Received: (qmail 8234 invoked by uid 107); 11 May 2011 12:53:27 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 14:53:27 +0200
Message-ID: <4DCA86C5.7070207@cs.utoronto.ca>
Date: Wed, 11 May 2011 12:53:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511103149.GA11041@calimero.vinschen.de>
In-Reply-To: <20110511103149.GA11041@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00096.txt.bz2

On 11/05/2011 6:31 AM, Corinna Vinschen wrote:
> Hi Ryan,
>
> On May 11 01:27, Ryan Johnson wrote:
>> Hi all,
>>
>> Please find attached three patches which extend the functionality of
>> /proc/*/maps.
> Thanks!
>
> I applied youyr two first patches with a couple of changes:
>
> - Formatting: Setting of curly braces in class and method defintions,
>    a lot of missing spaces, "int *foo" instead of "int* foo", stuff
>    like that.  Please compare what I checked in against your patch.
>    That doesn't mean I always get it right myself, but basically that's
>    how it should be.
Sorry... I did my best to match the surrounding code but didn't notice 
the '* ' vs ' *' thing.

> - NT_MAX_PATH is the maximum size of a path including the trailing \0,
>    so a buffer size of NT_MAX_PATH + 1 isn't required.
Good to know. Thanks.

> - I replaced the call to GetMappedFileNameEx with a call to
>    NtQueryVirtualMemory (MemorySectionName).  This avoids to add another
>    dependency to psapi.  I intend to get rid of them entirely, if
>    possible.
Nice. One issue: I tried backporting your change to my local tree, and 
the compiler complains that PMEMORY_SECTION_NAME isn't defined; the 
changelog says you updated ntdll.h to add it, but the online definition 
in w32api was last updated 9 months ago by 'duda.' Did it perhaps slip 
past the commit?

>> NOTE 1: I do not attempt to identify PEB, TEB, or thread stacks. The
>> first could be done easily enough, but the second and third require
>> venturing into undocumented/private Windows APIs.
> Go ahead!  We certainly don't shy away from calls to
> NtQueryInformationProcess or NtQueryInformationThread.
Ah. I didn't realize this sort of thing was encouraged. The MSDN docs 
about them are pretty gloomy.

The other things that discouraged me before were:
- the only obvious way to enumerate the threads in a process is to 
create a snapshot using TH32CS_SNAPTHREAD, which enumerates all threads 
in the system. This sounds expensive.
- it's not clear whether GetThreadContext returns a reasonable stack 
pointer if the target thread is active at the time.

However, assuming the above do not bother folks, they should be pretty 
straightforward to use. I won't have time to code this up in the 
immediate future, though. My real goal was to make fork bearable on my 
machine and that ended up sucking away all the time I had and then some...

>> NOTE 2: If desired, we could easily extend format_process_maps
>> further to report section names of mapped images (linux does this
>> for .so files), [...]
> Sorry if I'm dense, but isn't that exactly what GetMappedFileNameEx or
> NtQueryVirtualMemory (MemorySectionName) do?  I also don't see any extra
> information for .so files in the Linux maps output.  What detail am I
> missing?
Interesting... the machine I used for reference a couple weeks ago was 
running a really old debian, and for each allocation entry of a mapped 
image it gave the corresponding section name (.text, .bss, .rdata, etc):
3463600000-346362c000 r-xp 00000000 08:01 2097238                        
/lib64/libpcre.so.0.0.1 .text
346362c000-346382b000 ---p 0002c000 08:01 2097238                        
/lib64/libpcre.so.0.0.1
346382b000-346382c000 rw-p 0002b000 08:01 2097238                        
/lib64/libpcre.so.0.0.1 .bss

However, the machine was upgraded to a newer kernel this week and the 
extra information no longer appears.

In any case, should somebody want to report section names within a 
mapped image, that information can be had easily enough using the pefile 
struct from my fork patches.

Ryan
