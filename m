Return-Path: <cygwin-patches-return-3286-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14023 invoked by alias); 8 Dec 2002 01:44:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14014 invoked from network); 8 Dec 2002 01:44:52 -0000
Date: Sat, 07 Dec 2002 17:44:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
Message-ID: <20021208014554.GC10595@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DEB8ABD.80309@ece.gatech.edu> <3DEE0B91.4070208@ece.gatech.edu> <3DF2947F.8010308@ece.gatech.edu> <20021208014438.GB10595@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021208014438.GB10595@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00237.txt.bz2

On Sat, Dec 07, 2002 at 08:44:38PM -0500, Christopher Faylor wrote:
>On Sat, Dec 07, 2002 at 07:38:23PM -0500, Charles Wilson wrote:
>>Charles Wilson wrote:
>>
>>>I've tested Egor's patch and it seems to work just fine, as demonstrated 
>>>by the two test cases he posted last week, AND as demonstrated by the 
>>>test case posted to the binutils list some months ago (it tested 
>>>pseudo-reloc behavior in the child after a fork).
>>>
>>>I've also tested Egor's runtime reloc support with Ralf's binutils "use 
>>>the DLL as the import lib" and it ALSO works fine in all three cases.
>>>
>>>I'm going to continue using ld.exe-ralf and 
>>>cygwin1.dll-egor/libcygwin.a-egor for my day-to-day use, just to see if 
>>>something wacky crops up...
>>[snip]
>>>On balance, I agree that #1 is the best option.  Unless I run afoul of 
>>>some unforseen wackiness in the next few days, recommend inclusion as is 
>>>(in the most recent iteration, e.g. no cygwin.sc changes)
>>
>>So far, no problems.  I'm gonna go on record in favor of this patch, in 
>>its 4th incarnation 
>>(http://cygwin.com/ml/cygwin-patches/2002-q4/msg00222.html).
>>
>>given that winsup/cygwin/lib/getopt.c(*) still retains its BSD licensing 
>>and comments, there's no reason to change the (non-)license/public 
>>domain attribution in egor's pseudo-relocs.c file.  Egor's patch #4 
>>should be able to be committed as-is.
>
>You know, I don't recall asking for legal opinions.  There is absolutely
>no reason why I should trust the legal analysis of anyone who is not a
>lawyer.
>
>If public domain of Berkeley licensing was a huge win, then I really
                  or
>wouldn't be asking anyone to fill out cygwin assignments, would I?

cgf
