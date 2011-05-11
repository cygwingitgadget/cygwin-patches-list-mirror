Return-Path: <cygwin-patches-return-7332-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30167 invoked by alias); 11 May 2011 14:15:25 -0000
Received: (qmail 30154 invoked by uid 22791); 11 May 2011 14:15:24 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 14:15:10 +0000
Received: (qmail 13871 invoked by uid 107); 11 May 2011 14:15:07 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 16:15:07 +0200
Message-ID: <4DCA99E9.9090902@cs.utoronto.ca>
Date: Wed, 11 May 2011 14:15:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511103149.GA11041@calimero.vinschen.de> <4DCA86C5.7070207@cs.utoronto.ca> <20110511132038.GD11041@calimero.vinschen.de>
In-Reply-To: <20110511132038.GD11041@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00098.txt.bz2

On 11/05/2011 9:20 AM, Corinna Vinschen wrote:
> On May 11 08:53, Ryan Johnson wrote:
>> On 11/05/2011 6:31 AM, Corinna Vinschen wrote:
>>> - I replaced the call to GetMappedFileNameEx with a call to
>>>    NtQueryVirtualMemory (MemorySectionName).  This avoids to add another
>>>    dependency to psapi.  I intend to get rid of them entirely, if
>>>    possible.
>> Nice. One issue: I tried backporting your change to my local tree,
>> and the compiler complains that PMEMORY_SECTION_NAME isn't defined;
>> the changelog says you updated ntdll.h to add it, but the online
>> definition in w32api was last updated 9 months ago by 'duda.' Did it
>> perhaps slip past the commit?
> The compiler shouldn't complain because we only use the definitions
> from ntdll.h and nothing else from w32api/include/ddk (except in rare
> cases, see fhandler_tape.cc, fhandler_serial.cc).
>
> Sometimes I apply new stuff to w32api as well on an "as it comes along"
> base, but usually it's not the Cygwin project which maintains these
> files.
Ah... there are two ntdll.h, and I looked at the one in w32api/include 
instead of cygwin. All is well.

Ryan
