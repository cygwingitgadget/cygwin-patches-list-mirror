Return-Path: <cygwin-patches-return-8353-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2443 invoked by alias); 23 Feb 2016 06:58:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2428 invoked by uid 89); 23 Feb 2016 06:58:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=caution, PID, H*r:8.12.11, 100000
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Tue, 23 Feb 2016 06:58:33 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u1N6wDaC094775	for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2016 22:58:13 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Tue, 23 Feb 2016 06:58:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
In-Reply-To: <20160222101224.GA29199@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1602222243530.88046@m0.truegem.net>
References: <56C820D8.4010203@maxrnd.com> <20160222101224.GA29199@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00059.txt.bz2

On Mon, 22 Feb 2016, Corinna Vinschen wrote:
> One is, for completeness it would be nice if you could add a
> description to the git comment along the lines of your original
> comment so we have a description in the log.

Sorry, can't parse this; git newbie here.  Did you mean the 'git commit' 
I'm doing to my private repository and the message associated with the 
commit?  And by "original comment" do you mean what I called the change 
log in the text of my v2 email we're discussing (i.e., not the patch 
attachment but the email body)?

> The other point is:
>> +		long divisor = 100000;	// the power of 10 bigger than PID_MAX
>
> I've seen 6 digit PIDs.  In fact, we're not that tight on space here
> so we should err on the side of caution and leave room for the entire
> possible size of a Windows PID.  That's a LONG, 32 bit, 10 decimal
> digits.

Yikes.  I'd seen large 5-digit pids but could not find a definitive symbol 
defining Windows' maximum pid value.  So I will change divisor's init 
value to 1000*1000*1000 which will allow the conversion loop to support 
10-digit pids.

> Other than that, the patch looks good to me.

Great!  I'll follow up with Jon separately (to the list) on his comments.

..mark
