Return-Path: <cygwin-patches-return-8329-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77545 invoked by alias); 18 Feb 2016 10:59:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77533 invoked by uid 89); 18 Feb 2016 10:59:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=behavioral, replaces, exits, HTo:U*cygwin-patches
X-HELO: out3-smtp.messagingengine.com
Received: from out3-smtp.messagingengine.com (HELO out3-smtp.messagingengine.com) (66.111.4.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 18 Feb 2016 10:59:23 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])	by mailout.nyi.internal (Postfix) with ESMTP id D44B7208E3	for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 05:59:21 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute1.internal (MEProxy); Thu, 18 Feb 2016 05:59:21 -0500
Received: from [192.168.1.102] (host86-141-131-217.range86-141.btcentralplus.com [86.141.131.217])	by mail.messagingengine.com (Postfix) with ESMTPA id 5F52D68009A;	Thu, 18 Feb 2016 05:59:21 -0500 (EST)
Subject: Re: gprof profiling of multi-threaded Cygwin programs
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <56C404FF.502@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: Mark Geisert <mark@maxrnd.com>
Message-ID: <56C5A401.8060604@dronecode.org.uk>
Date: Thu, 18 Feb 2016 10:59:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56C404FF.502@maxrnd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00035.txt.bz2


Thanks for this.

On 17/02/2016 05:28, Mark Geisert wrote:
> There is a behavioral change that ought to be documented somewhere:  If
> a gmon.out file exists when a profiled application exits, the app will
> now dump its profiling info into another file gmon.outXXXXXX where
> mkstemp() replaces the Xs with random alphanumerics.  I added this
> functionality to allow a profiled program to fork() yet retain profiling
> info for both parent and child.  The old behavior was to simply
> overwrite any existing gmon.out file.

Did you consider making the filename deterministic (e.g. based on pid or 
such) rather than random?

With a random filename, if you have a process which forks more than 
once, working out which gmon.out* file corresponds to which process 
could be tricky.

A brief search tells me that apparently glibc supports the 
(undocumented) GMON_OUT_PREFIX env var which enables a similar behaviour.
