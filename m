Return-Path: <cygwin-patches-return-7349-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28045 invoked by alias); 12 May 2011 16:37:35 -0000
Received: (qmail 27915 invoked by uid 22791); 12 May 2011 16:37:33 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 12 May 2011 16:37:19 +0000
Received: (qmail 29235 invoked by uid 107); 12 May 2011 16:37:17 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 12 May 2011 18:37:17 +0200
Message-ID: <4DCC0CBB.1030803@cs.utoronto.ca>
Date: Thu, 12 May 2011 16:37:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de>
In-Reply-To: <20110511193107.GF11041@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00115.txt.bz2

On 11/05/2011 3:31 PM, Corinna Vinschen wrote:
> On May 11 13:46, Ryan Johnson wrote:
>> Also, the cygheap isn't a normal windows heap, is it? I thought it
>> was essentially a statically-allocated array (.cygheap) that gets
>> managed as a heap. I guess since it's part of cygwin1.dll we already
>> do sort of report it...
> The cygheap is the last section in the DLL and gets allocated by the
> Windows loader.  The memory management is entirely in Cygwin (cygheap.cc).
> Cygwin can raise the size of the cygheap, but only if the blocks right
> after the existing cygheap are not already allocated.
Would it make sense to give that section, and the one(s) which 
immediately follow it, the tag "[cygheap]" rather than 
"/usr/bin/cygwin1.dll" and nothing? It would require struct pefile to 
identify the section, plus some trickery in format_process_maps to treat 
the cygwin dll and adjacent succeeding allocation(s) specially.

Ryan


