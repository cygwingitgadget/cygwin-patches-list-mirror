Return-Path: <cygwin-patches-return-7371-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28784 invoked by alias); 17 May 2011 11:14:30 -0000
Received: (qmail 28773 invoked by uid 22791); 17 May 2011 11:14:29 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 17 May 2011 11:14:14 +0000
Received: (qmail 2473 invoked by uid 107); 17 May 2011 11:14:12 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Tue, 17 May 2011 13:14:12 +0200
Message-ID: <4DD25884.4070406@cs.utoronto.ca>
Date: Tue, 17 May 2011 11:14:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (1/5)
References: <4DCAD5FB.9050508@cs.utoronto.ca>
In-Reply-To: <4DCAD5FB.9050508@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00137.txt.bz2

Any feedback on these patches?

On 11/05/2011 2:31 PM, Ryan Johnson wrote:
> Hi all,
>
> This is the first of a series of patches, sent in separate emails as 
> requested.
>
> The first patch allows a child which failed due to address space 
> clobbers to report cleanly back to the parent. As a result, DLL_LINK 
> which land wrong, DLL_LOAD whose space gets clobbered, and failure to 
> replicate the cygheap, generate retries and dispense with the terminal 
> spam. Handling of unexpected errors should not have changed. Further, 
> the patch fixes several sources of access violations and crashes, 
> including:
> - accessing invalid state after failing to notice that a 
> statically-linked dll loaded at the wrong location
> - accessing invalid state while running dtors on a failed forkee. I 
> follow cgf's approach of simply not running any dtors, based on the 
> observation that dlls in the parent (gcc_s!) can store state about 
> other dlls and crash trying to access that state in the child, even if 
> they appeared to map properly in both processes.
> - attempting to generate a stack trace when somebody in the call chain 
> used alloca(). This one is only sidestepped here, because we eliminate 
> the access violations and api_fatal calls which would have triggered 
> the problematic stack traces. I have a separate patch which allows 
> offending functions to disable stack traces, if folks are interested, 
> but it was kind of noisy so I left it out for now (cygwin uses alloca 
> pretty liberally!).
>
> Ryan
