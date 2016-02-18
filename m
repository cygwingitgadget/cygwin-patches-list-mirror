Return-Path: <cygwin-patches-return-8336-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2924 invoked by alias); 18 Feb 2016 20:26:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2913 invoked by uid 89); 18 Feb 2016 20:26:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*r:8.12.11, Hx-languages-length:1425, H*Ad:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 18 Feb 2016 20:26:28 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u1IKQCkG099150;	Thu, 18 Feb 2016 12:26:12 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 18 Feb 2016 20:26:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: gprof profiling of multi-threaded Cygwin programs
In-Reply-To: <56C5BC87.7070705@dronecode.org.uk>
Message-ID: <Pine.BSF.4.63.1602181217020.94849@m0.truegem.net>
References: <56C404FF.502@maxrnd.com> <56C5A401.8060604@dronecode.org.uk> <Pine.BSF.4.63.1602180309170.49755@m0.truegem.net> <56C5BC87.7070705@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00042.txt.bz2

On Thu, 18 Feb 2016, Jon Turney wrote:
> On 18/02/2016 11:29, Mark Geisert wrote:
>>> A brief search tells me that apparently glibc supports the
>>> (undocumented) GMON_OUT_PREFIX env var which enables a similar behaviour.
>> 
>> Ah, I did not know about that.  It would be easy to implement.
>> 
>> So I'm leaning towards choosing file name as GMON_OUT_PREFIX.exename.pid
>> with GMON_OUT_PREFIX defaulting to "gmon.out" if unspecified.
>
> I think if you are going to implement GMON_OUT_PREFIX, you should make the 
> behaviour the same as glibc.
>
>> Do you think the expanded name should be used in all cases, or only when
>> there's a gmon.out already present?
>
> I don't think you should be checking for an existing gmon.out file.  In the 
> simple case where the program doesn't fork, it's expected that gmon.out will 
> get overwritten.

OK, so the file name would be "gmon.out" if GMON_OUT_PREFIX is not 
specified, and $GMON_OUT_PREFIX.$pid if it is.  And don't check for 
existing files in either case.

I was also worried about a profiled program fork/exec'ing a different 
profiled program and so I considered having $exename be part of the 
file name.  But I now think following the undocumented glibc behavior is 
better in the long run.  One can arrange a different GMON_OUT_PREFIX for 
the execee if that's truly necessary.

Thanks; I appreciate the feedback.

..mark
