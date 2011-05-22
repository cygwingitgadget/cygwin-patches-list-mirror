Return-Path: <cygwin-patches-return-7386-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6493 invoked by alias); 22 May 2011 18:42:25 -0000
Received: (qmail 6483 invoked by uid 22791); 22 May 2011 18:42:25 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 22 May 2011 18:42:11 +0000
Received: (qmail 21784 invoked by uid 107); 22 May 2011 18:42:08 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Sun, 22 May 2011 20:42:08 +0200
Message-ID: <4DD958FE.5060208@cs.utoronto.ca>
Date: Sun, 22 May 2011 18:42:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110522014421.GB18936@ednor.casa.cgf.cx>
In-Reply-To: <20110522014421.GB18936@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2011-q2/txt/msg00152.txt.bz2

On 21/05/2011 9:44 PM, Christopher Faylor wrote:
> On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>> Hi all,
>>
>> This patch has the parent sort its dll list topologically by
>> dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling
>> in dependencies automatically, and the latter would then not benefit
> >from the code which "encourages" them to land in the right places.  The
>> dependency tracking is achieved using a simple class which allows to
>> introspect a mapped dll image and pull out the dependencies it lists.
>> The code currently rebuilds the dependency list at every fork rather
>> than attempt to update it properly as modules are loaded and unloaded.
>> Note that the topsort optimization affects only cygwin dlls, so any
>> windows dlls which are pulled in dynamically (directly or indirectly)
>> will still impose the usual risk of address space clobbers.
> This seems CPU and memory intensive during a time for which we already
> know is very slow.  Is the benefit really worth it?  How much more robust
> does it make forking?
Topological sorting is O(n), so there's no asymptotic change in 
performance. Looking up dependencies inside a dll is *very* cheap (2-3 
pointer dereferences per dep), and all of this only happens for 
dynamically-loaded dlls. Given the number of calls to 
Virtual{Alloc,Query,Free} and LoadDynamicLibraryEx which we make, I 
would be surprised if the topsort even registered.  That said, it is 
extra work and will slow down fork.

I have not been able to test how much it helps, but it should help with 
the test case Jon Turney reported with python a while back [1]. In fact, 
it was that example which made me aware of the potential need for a 
topsort in the first place.

In theory, this should completely eliminate the case where us loading 
one DLL pulls in dependencies automatically (= uncontrolled and at 
Windows' whim). The problem would manifest as a DLL which "loads" in the 
same wrong place repeatedly when given the choice, and for which we 
would be unable to VirtualAlloc the offending spot (because the dll in 
question has non-zero refcount even after we unload it, due to the 
dll(s) that depend on it. The currently checked-in code would not detect 
this case, because inability to VirtualAlloc just causes ReserveAt and 
ReserveUpto to skip that spot silently.

[1] http://cygwin.com/ml/cygwin/2011-04/msg00054.html

Ryan
