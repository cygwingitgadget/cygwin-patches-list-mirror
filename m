Return-Path: <cygwin-patches-return-7399-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23212 invoked by alias); 24 May 2011 16:47:58 -0000
Received: (qmail 23202 invoked by uid 22791); 24 May 2011 16:47:57 -0000
X-SWARE-Spam-Status: No, hits=0.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 24 May 2011 16:47:40 +0000
Received: (qmail 25782 invoked by uid 107); 24 May 2011 16:47:37 -0000
Received: from dhcphost-ic216.utsc.utoronto.ca (HELO discarded) (142.1.102.216) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Tue, 24 May 2011 18:47:37 +0200
Message-ID: <4DDBE128.8090907@cs.utoronto.ca>
Date: Tue, 24 May 2011 16:47:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110522014421.GB18936@ednor.casa.cgf.cx> <4DD958FE.5060208@cs.utoronto.ca> <20110524161428.GA16774@calimero.vinschen.de>
In-Reply-To: <20110524161428.GA16774@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00165.txt.bz2

On 24/05/2011 12:14 PM, Corinna Vinschen wrote:
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
> Btw., isn't the resulting dependency list identical to the list
> maintained in the PEB_LDR_DATA member InInitializationOrderModuleList?
> Or, in other words, can't we just use the data which is already
> available?
I read somewhere that dll initialization is not guaranteed to happen in 
any particular order, and from what I've seen so far I believe it.

I think that's one reason (among many) why cygwin has to factor the 
user's initialization routines out from normal dll init function: they 
might call functions in other dlls which might not have been initialized 
yet. From what I can tell, though, mapping of all dlls in a batch 
completes before any initialization routines run.

Even assuming I'm wrong and dependency order === initialization order, 
we'd still have to find a way to isolate those dlls which are both 
cygwin-aware and dynamically loaded, because those are the only ones we 
care about. Doing that would also be expensive because we'd be searching 
the cygwin dll list for each dll in the PEB's list.

The best way to improve performance of this part of fork() would be to 
figure out how to force a dll to load in the right place on the first 
try. Achieving this admittedly "difficult" task would eliminate multiple 
syscalls per dll, the aggregate cost of which dominates the topsort into 
oblivion unless I'm very mistaken.

Ryan
