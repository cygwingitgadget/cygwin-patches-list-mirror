Return-Path: <cygwin-patches-return-8954-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85639 invoked by alias); 1 Dec 2017 08:44:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85610 invoked by uid 89); 1 Dec 2017 08:44:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD autolearn=no version=3.3.2 spammy=remembered, messing, understanding, H*Ad:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Dec 2017 08:44:03 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vB18i2Zh026383	for <cygwin-patches@cygwin.com>; Fri, 1 Dec 2017 00:44:02 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Fri, 01 Dec 2017 08:44:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
In-Reply-To: <20171130103440.GA14313@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1712010030250.24559@m0.truegem.net>
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <20171129123806. <20171130103440.GA14313@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00084.txt.bz2

On Thu, 30 Nov 2017, Corinna Vinschen wrote:
> On Nov 30 01:50, Mark Geisert wrote:
>> Yes, I believe that's correct.  But in my aio implementation for Cygwin, I'm
>> not using overlapped I/O or any kind of async or nonblocking write. I'm
>> using separate threads to do plain vanilla blocking writes (via pwrite if
>> able).  I'm doing this because I'm operating with user-supplied file
>> descriptors that might or might not be underlain with async-capable Windows
>> handles.
>>
>> (It's my understanding that if one wants to do overlapped I/O on a Windows
>> handle, one has to request that explicitly when creating the handle.  I
>> don't think Cygwin does this by default.  Corrections welcome.)
>
> Right, Cygwin opens files with FILE_SYNCHRONOUS_IO_NONALERT by default,
> unless it's a handle for meta operations only.
>
> But then I don't understand in what situation you see pwrite return a
> STATUS_PENDING.  This should only occur with async I/O.
>
>> So in this environment seeing pwrite() return with a short write count, even
>> though it's understandable that the underlying Windows write might still be
>> underway, is a real problem.
>
> Something's really fishy here.  A synchronous write should *never*
> return with STATUS_PENDING.  This breaks so many assumptions, Cygwin
> wouldn't practically work at all.
>
>> A blocking pwrite() (i.e., not overlapped or async in any way) has to wait
>> for the underlying NtWriteFile() to complete in order to get a correct write
>> count and/or correct final status code, doesn't it?
>
> Yes, in theory, but if you use the default handles opened by
> fhandler_base::open, pwrite should wait as is because NtWriteFile
> doesn't return prematurely.

I'd better take this info back to "the lab" and do some more digging. 
Thanks very much for these details and your earlier replies.  When I saw 
FILE_SYNCHRONOUS_IO_NONALERT in your reply, I remembered that I'm not 
using a Cygwin-supplied handle but rather a handle returned by Win32 
CreateFile().  Not only that, but using cygwin_attach_handle_to_fd() to 
get an fd to work with.  And then pwrite() creates its own handle (or 
reuses one (!)) to avoid messing up the seek pointer of the fd passed in.

I'm not specifying FILE_FLAG_OVERLAPPED, which is the only control one has 
over async- or sync-ness in Win32.  But maybe it's getting added somewhere 
on the way through these layers.  Is there a way to query handle 
attributes in order to find out if a handle is sync or async?  I'll dig.
Thanks again,

..mark
