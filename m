Return-Path: <cygwin-patches-return-8952-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111764 invoked by alias); 30 Nov 2017 09:50:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111754 invoked by uid 89); 30 Nov 2017 09:50:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD autolearn=no version=3.3.2 spammy=egg, afford, underway, understanding
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 Nov 2017 09:50:24 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vAU9oNqg061799	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 01:50:23 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 30 Nov 2017 09:50:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
In-Reply-To: <20171129123806.GF547@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1711300129090.59306@m0.truegem.net>
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <e7c6061c-be0e-5 <20171129123806.GF547@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00082.txt.bz2

On Wed, 29 Nov 2017, Corinna Vinschen wrote:
> On Nov 29 13:36, Corinna Vinschen wrote:
>> On Nov 29 13:04, Corinna Vinschen wrote:
>>> - If you do async IO, you have to handle STATUS_PENDING gracefully:
>>>
>>>   - The IO_STATUS_BLOCK given to NtWriteFile *must* exist for the
>>>     entire time the operation takes after NtWriteFile returned
>>>     STATUS_PENDING.  An IO_STATUS_BLOCK fhandler member comes to mind,
>>>     maybe fhandler_base_overlapped::io_status can be reused.
>>
>> No, wait.  There can be more than one outstanding aio operations on the
>> same descriptor.  Therefore the IO_STATUS_BLOCK must be connected to the
>> aiocb struct one way or the other, becasue only that struct is local to
>> the aio operation.
>
> I guess that's what the Linux man page aio(7) subsumes under
>
>  struct aiocb {
>    [...]
>
>    /* Various implementation-internal fields not shown */
>  };

Yes, I believe that's correct.  But in my aio implementation for Cygwin, 
I'm not using overlapped I/O or any kind of async or nonblocking write. 
I'm using separate threads to do plain vanilla blocking writes (via pwrite 
if able).  I'm doing this because I'm operating with user-supplied file 
descriptors that might or might not be underlain with async-capable 
Windows handles.

(It's my understanding that if one wants to do overlapped I/O on a Windows 
handle, one has to request that explicitly when creating the handle.  I 
don't think Cygwin does this by default.  Corrections welcome.)

So in this environment seeing pwrite() return with a short write count, 
even though it's understandable that the underlying Windows write might 
still be underway, is a real problem.  Because, if I use the short count 
to determine that I need to write the remainder of a buffer, it'll have 
been written twice: once by the late-finishing pwrite and again by the
recovery code.

A blocking pwrite() (i.e., not overlapped or async in any way) has to wait 
for the underlying NtWriteFile() to complete in order to get a correct 
write count and/or correct final status code, doesn't it?

..mark

P.S. I'll look into IRC clients.  You've suggested it before and I just 
recall the wild IRC days in the 90s with egg drops and bots and bans and 
it seemed like a time sink I couldn't afford.  Maybe #cygwin-developers
on freenode is more civilized :-)).
