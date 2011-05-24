Return-Path: <cygwin-patches-return-7396-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27521 invoked by alias); 24 May 2011 11:28:25 -0000
Received: (qmail 27509 invoked by uid 22791); 24 May 2011 11:28:24 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 24 May 2011 11:27:51 +0000
Received: (qmail 22781 invoked by uid 107); 24 May 2011 11:27:46 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Tue, 24 May 2011 13:27:47 +0200
Message-ID: <4DDB9631.30904@cs.utoronto.ca>
Date: Tue, 24 May 2011 11:28:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110522014421.GB18936@ednor.casa.cgf.cx> <4DD958FE.5060208@cs.utoronto.ca> <20110523073139.GA17244@calimero.vinschen.de>
In-Reply-To: <20110523073139.GA17244@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00162.txt.bz2

On 23/05/2011 3:31 AM, Corinna Vinschen wrote:
> On May 22 14:42, Ryan Johnson wrote:
>> On 21/05/2011 9:44 PM, Christopher Faylor wrote:
>>> On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>>>> Hi all,
>>>>
>>>> This patch has the parent sort its dll list topologically by
>>>> dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling
>>>> in dependencies automatically, and the latter would then not benefit
>>> >from the code which "encourages" them to land in the right places.  The
>>>> dependency tracking is achieved using a simple class which allows to
>>>> introspect a mapped dll image and pull out the dependencies it lists.
>>>> The code currently rebuilds the dependency list at every fork rather
>>>> than attempt to update it properly as modules are loaded and unloaded.
>>>> Note that the topsort optimization affects only cygwin dlls, so any
>>>> windows dlls which are pulled in dynamically (directly or indirectly)
>>>> will still impose the usual risk of address space clobbers.
>>> This seems CPU and memory intensive during a time for which we already
>>> know is very slow.  Is the benefit really worth it?  How much more robust
>>> does it make forking?
>> Topological sorting is O(n), so there's no asymptotic change in
>> performance. Looking up dependencies inside a dll is *very* cheap
>> (2-3 pointer dereferences per dep), and all of this only happens for
>> dynamically-loaded dlls. Given the number of calls to
>> Virtual{Alloc,Query,Free} and LoadDynamicLibraryEx which we make, I
>> would be surprised if the topsort even registered.  That said, it is
>> extra work and will slow down fork.
>>
>> I have not been able to test how much it helps, but it should help
>> with the test case Jon Turney reported with python a while back [1].
>> In fact, it was that example which made me aware of the potential
>> need for a topsort in the first place.
>>
>> In theory, this should completely eliminate the case where us
>> loading one DLL pulls in dependencies automatically (= uncontrolled
>> and at Windows' whim). The problem would manifest as a DLL which
>> "loads" in the same wrong place repeatedly when given the choice,
>> and for which we would be unable to VirtualAlloc the offending spot
>> (because the dll in question has non-zero refcount even after we
>> unload it, due to the dll(s) that depend on it.
> There might be a way around this.  It seems to be possible to tweak
> the module list the PEB points to so that you can unload a library
> even though it has dependencies.  Then you can block the unwanted
> space and call LoadLibrary again.  See (*) for a discussion how
> you can unload the exe itself to reload another one.  Maybe that's
> something we can look into as well.  ObNote:  Of course, if we
> could influnce the address at which a DLL gets loaded right from the
> start, it would be the preferrable solution.
>
>
> Corinna
>
> (*) http://www.blizzhackers.cc/viewtopic.php?p=4332690
After poking around at (*) a bit, it looks like NtMapViewOfSection does 
more than I would have expected wrt dll loading. However, when I tried 
to fire up a toy program to test it, NtOpenSection always returns 
C0000024, regardless of whether I pass OBJ_KERNEL_HANDLE to it.

Does anybody have experience with those two functions?

Ryan

