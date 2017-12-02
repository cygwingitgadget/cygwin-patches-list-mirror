Return-Path: <cygwin-patches-return-8959-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103963 invoked by alias); 2 Dec 2017 22:32:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103924 invoked by uid 89); 2 Dec 2017 22:32:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=wake, Hx-languages-length:1568, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 02 Dec 2017 22:32:36 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vB2MWZin093244	for <cygwin-patches@cygwin.com>; Sat, 2 Dec 2017 14:32:35 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Sat, 02 Dec 2017 22:32:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
In-Reply-To: <20171202104609.GC4325@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1712021418210.91733@m0.truegem.net>
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <20171201093754. <20171202104609.GC4325@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00089.txt.bz2

On Sat, 2 Dec 2017, Corinna Vinschen wrote:
> On Dec  1 13:46, Mark Geisert wrote:
>> I'm open to using overlapped I/O for the usual read & write cases of aio but
>> there are some extensions I have in mind that don't allow for overlapped so
>> I think I need to have threads handle them.  I might combine the two.
>
> I'm just a bit concerned in terms of calling lots of aio_read/write at
> the same time or lio_listio with lots of entries.  One thread for each
> entry?

No, first use of aio_* or lio_* causes a pool of AIO_MAX worker threads to 
be created.  The actual request(s) is/are placed on a FIFO queue.  Each 
enqueue bumps a semaphore to wake up a worker thread to dequeue and 
process a request.  More requests than threads?  It's OK, requests are
queued until there's a worker thread available to field it.

>> Using
>> overlapped for the common case would, I think, allow me to reduce the number
>> of worker threads hanging around.  Thanks for the input!
>
> I wonder if APCs are the way to go for this use case.  As you might
> know, Nt{Read,Write}File provide a way to specify an APC routine and a
> APC context pointer (struct aiocb *?), so instead of waiting actively
> for the event, you could just lean back and wait for the APC routine to
> be called.
>
> As a sidenote, I think we could use APCs in other scenarios, too, but
> somehow we never got around to it.

Good points.  Requires a little architecting.  Have to wait in an 
interruptible wait.  Hmm.  I could consider this direction too.

..mark
