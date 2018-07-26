Return-Path: <cygwin-patches-return-9153-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81154 invoked by alias); 26 Jul 2018 08:52:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81133 invoked by uid 89); 26 Jul 2018 08:52:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=online
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Jul 2018 08:51:59 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id w6Q8pvUU013239	for <cygwin-patches@cygwin.com>; Thu, 26 Jul 2018 01:51:57 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Date: Thu, 26 Jul 2018 08:52:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Update _PC_ASYNC_IO return value
In-Reply-To: <20180726082000.GA6175@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1807260140390.12009@m0.truegem.net>
References: <20180725200643.10750-1-yselkowi@redhat.com> <20180726082000.GA6175@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00048.txt.bz2

Hi Corinna,

On Thu, 26 Jul 2018, Corinna Vinschen wrote:
> On Jul 25 15:06, Yaakov Selkowitz wrote:
>>> From discussion on IRC:
>>
>> <yselkowitz> corinna, just sent a patch for _POSIX_ASYNCHRONOUS_IO as a
>> 	  follow-up to the AIO feature, but am still wondering about
>> 	  _[POSIX|PC]_ASYNC_IO
>> [snip]
>> <corinna> in terms of _PC_ASYNC_IO, the test might be a bit tricky
>> <corinna> let me check
>> <corinna> actually, no
>> <corinna> it's easy
>> <corinna> Mark implemented the stuff with pread/pwrite only on disk files
>> <corinna> but otherwise it's device independent in that he implemented a
>> 	  workaround for pipes and stuff
>> <corinna> so, in theory we can just return 1
>>
>> I'm not sure how to test this atm, but based on the above I have made
>> the following patch so this doesn't get lost.
>>
>> Yaakov Selkowitz (1):
>>   Cygwin: fpathconf: update _PC_ASYNC_IO return value
>>
>>  winsup/cygwin/fhandler.cc | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> --
>> 2.17.1
>
> Mark?  Any comment you want to make?

Thanks for asking.  Your characterization of my implementation is correct. 
The intent is for aio_* async I/O to be supported on all descriptors.  On 
the most useful case of binary local disk files, inline pread|pwrite is 
used.  But I wanted to make sure the AIO interface would do the right 
thing on other kinds of descriptors without bothering the user about it.

So if the intent of the _PC_ASYNC_IO flag is to say that async I/O is 
supported generally, I do think setting it to 1 is appropriate.  That is,
if it's talking about the aio_* interfaces.  If there's an O_ASYNC defined 
for app coders, my recent contribution doesn't address that at all.

Is there a reference I could check for the meaning of the flag?  I'll do 
an online search in the meantime.
Thanks again,

..mark
