Return-Path: <cygwin-patches-return-7400-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27959 invoked by alias); 24 May 2011 17:01:51 -0000
Received: (qmail 27929 invoked by uid 22791); 24 May 2011 17:01:48 -0000
X-SWARE-Spam-Status: No, hits=-0.2 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 24 May 2011 17:01:34 +0000
Received: (qmail 23917 invoked by uid 107); 24 May 2011 17:01:31 -0000
Received: from dhcphost-ic216.utsc.utoronto.ca (HELO discarded) (142.1.102.216) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Tue, 24 May 2011 19:01:31 +0200
Message-ID: <4DDBE46B.1090700@cs.utoronto.ca>
Date: Tue, 24 May 2011 17:01:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110522014421.GB18936@ednor.casa.cgf.cx> <4DD958FE.5060208@cs.utoronto.ca> <20110523073139.GA17244@calimero.vinschen.de> <4DDB9631.30904@cs.utoronto.ca> <20110524130536.GE848@calimero.vinschen.de>
In-Reply-To: <20110524130536.GE848@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00166.txt.bz2

On 24/05/2011 9:05 AM, Corinna Vinschen wrote:
> On May 24 07:27, Ryan Johnson wrote:
>> On 23/05/2011 3:31 AM, Corinna Vinschen wrote:
>>> On May 22 14:42, Ryan Johnson wrote:
>>>> In theory, this should completely eliminate the case where us
>>>> loading one DLL pulls in dependencies automatically (= uncontrolled
>>>> and at Windows' whim). The problem would manifest as a DLL which
>>>> "loads" in the same wrong place repeatedly when given the choice,
>>>> and for which we would be unable to VirtualAlloc the offending spot
>>>> (because the dll in question has non-zero refcount even after we
>>>> unload it, due to the dll(s) that depend on it.
>>> There might be a way around this.  It seems to be possible to tweak
>>> the module list the PEB points to so that you can unload a library
>>> even though it has dependencies.  Then you can block the unwanted
>>> space and call LoadLibrary again.  See (*) for a discussion how
>>> you can unload the exe itself to reload another one.  Maybe that's
>>> something we can look into as well.  ObNote:  Of course, if we
>>> could influnce the address at which a DLL gets loaded right from the
>>> start, it would be the preferrable solution.
>>>
>>>
>>> Corinna
>>>
>>> (*) http://www.blizzhackers.cc/viewtopic.php?p=4332690
>> After poking around at (*) a bit, it looks like NtMapViewOfSection
>> does more than I would have expected wrt dll loading. However, when
>> I tried to fire up a toy program to test it, NtOpenSection always
>> returns C0000024, regardless of whether I pass OBJ_KERNEL_HANDLE to
>> it.
>>
>> Does anybody have experience with those two functions?
> The Cygwin source code, for instance, is using this function, see
> fhandler_mem.cc.
>
> C0000024 is STATUS_OBJECT_TYPE_MISMATCH.  I didn't see the error before,
> but I have a vague idea why you get it.  Are you by any chance trying to
> call NtOpenSection with the OBJECT_ATTRIBUTES set to the file?  If so,
> that's wrong.  The OBJECT_ATTRIBUTES names the attributes of the section,
> including its name if it has one.  It does not specify the file you're
> trying to map.  What you're looking for is NtCreateSection.  It has an
> extra parameter to specify the handle to an open file.
Bingo. That was indeed it.

So, playing with NtMapViewOfSection (code below) shows that it knows how 
to map a .dll properly (with appropriate permissions for the various 
sections), and you can force it to map to a given address, but the 
resulting image is not considered a proper .dll -- it doesn't show up in 
the dll list and initialization routines don't run (I haven't checked 
dependency loading  yet). Most likely, this is roughly equivalent to 
LoadLibraryEx+DONT_RESOLVE_DLL_REFERENCES.

Another issue arises if the file is mapped to somewhere other than its 
preferred image base. In this case the mapping succeeds but returns 
STATUS_IMAGE_NOT_AT_BASE, in which case LdrRelocateImage and its friends 
need to be called.

An additional difficulty: trying to CreateFile a well-known dll like 
psapi returns STATUS_WAIT_3, so file locking seems to be an issue. This 
happens even if I pass all possible sharing flags (0x7).

Overall, it looks like going this route would strongly resemble the 
custom loader option. There Be Dragons...

Meanwhile, the forced unload of the .exe is really tantalizing, but it 
sounds there's a lot of messiness trying to clean up the mess and load 
the new image. Granted, this would be simpler since we're trying to 
reload the same image (after loading its dependent dlls properly), and 
we already know what dlls need to be loaded by looking at the parent 
process. However, we'd have to do this without unloading cygwin1.dll 
(maybe calling LoadLibrary on it would bump the refcount and protect it?).

On the other hand, if we could get that forced unload to work reliably, 
we'd almost have a true exec() on our hands and could use that to 
implement fork: run a stub process, load the dlls we know we'll need, 
then replace the stub with the actual image we want to run and clean up 
the mess we left in the PEB... that would let us control nearly all 
dlls, even windows ones.

Ryan
