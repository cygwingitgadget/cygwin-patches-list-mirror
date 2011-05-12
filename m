Return-Path: <cygwin-patches-return-7359-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6506 invoked by alias); 12 May 2011 19:30:41 -0000
Received: (qmail 6495 invoked by uid 22791); 12 May 2011 19:30:40 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_DB
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 12 May 2011 19:30:26 +0000
Received: (qmail 15758 invoked by uid 107); 12 May 2011 19:30:24 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 12 May 2011 21:30:25 +0200
Message-ID: <4DCC354F.3030900@cs.utoronto.ca>
Date: Thu, 12 May 2011 19:30:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <4DCC1E7C.2060804@cs.utoronto.ca> <20110512184233.GE3020@calimero.vinschen.de>
In-Reply-To: <20110512184233.GE3020@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00125.txt.bz2

On 12/05/2011 2:42 PM, Corinna Vinschen wrote:
> On May 12 13:53, Ryan Johnson wrote:
>> On 12/05/2011 12:55 PM, Corinna Vinschen wrote:
>>>>>     heap *heaps;
>>>> This is a misnomer now -- it's really a list of heap regions/blocks.
>>> I don't think so.  The loop stores only the blocks which constitute
>>> the original VirtualAlloc'ed memory regions.  They are not the real
>>> heap blocks returned by Heap32First/Heap32Next.  These are filtered
>>> out by checking for flags&   2 (**).
>> Sorry, I cut too much context out of the diff. That's
>> heap_info::heaps, which indeed refers to heap regions which we
>> identified by checking flags&2 (that's why it needs the heap_id
>> inside it now, where it didn't before) (++)
> So you think something like heap_chunks is better?
Maybe. I actually only noticed because the code snippet you originally 
sent also used 'heaps' as an identifier and the two clashed when I 
pasted it in ;)

>>>>> +		heap *h = (heap *) cmalloc (HEAP_FHANDLER, sizeof (heap));
>>>>> +		*h = (heap) {heaps, hcnt, barray[bcnt].Address,
>>>>> +			     barray[bcnt].Address + barray[bcnt].Size,
>>>>> +			     harray->Heaps[hcnt].Flags};
>>>>> +		heaps = h;
>>>> Given that the number of heap blocks is potentially large, I think
>>> Not really.  See (**).  3 heaps ->   3 blocks, or only slightly more
>>> if a growable heap got expanded.
>> See (++). When I point my essentially-identical version of the code
>> at emacs, it reports 8 heaps, each with 2-4 regions. The list
>> traversed by fill_on_match has ~20 entries.
> Oh, ok.  From my POV 20 is not a large number.  Ordering might take
> more time than scanning.  I don't think it's worth the effort.
You might be right. I just threw my test case at Firefox, and even that 
memory hog generates < 50 entries. I guess it does some sort of manual 
memory management as well, because windbg reports waaaay more allocated 
address space regions than that...

Besides, you've shown that we potentially need each heap block multiple 
times, so delete-after-use isn't a good idea.

Ryan
