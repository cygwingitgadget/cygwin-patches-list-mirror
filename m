Return-Path: <cygwin-patches-return-8332-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45236 invoked by alias); 18 Feb 2016 11:30:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45098 invoked by uid 89); 18 Feb 2016 11:30:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*r:8.12.11, Hx-languages-length:1963, exits, H*Ad:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 18 Feb 2016 11:30:12 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u1IBTuuR059967;	Thu, 18 Feb 2016 03:29:56 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 18 Feb 2016 11:30:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: gprof profiling of multi-threaded Cygwin programs
In-Reply-To: <56C5A401.8060604@dronecode.org.uk>
Message-ID: <Pine.BSF.4.63.1602180309170.49755@m0.truegem.net>
References: <56C404FF.502@maxrnd.com> <56C5A401.8060604@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00038.txt.bz2

On Thu, 18 Feb 2016, Jon Turney wrote:
> Thanks for this.
>
> On 17/02/2016 05:28, Mark Geisert wrote:
>> There is a behavioral change that ought to be documented somewhere:  If
>> a gmon.out file exists when a profiled application exits, the app will
>> now dump its profiling info into another file gmon.outXXXXXX where
>> mkstemp() replaces the Xs with random alphanumerics.  I added this
>> functionality to allow a profiled program to fork() yet retain profiling
>> info for both parent and child.  The old behavior was to simply
>> overwrite any existing gmon.out file.
>
> Did you consider making the filename deterministic (e.g. based on pid or 
> such) rather than random?

Yes, I considered using pid and/or exename to avoid collisions.  There was 
an issue with Cygwin long ago about pids being reused too quickly 
(actually Windows reusing pids too quickly) but that's been cured?

Maybe something like what's used to name core files on Linux would be 
preferable to using mkstemp().  IIRC that's core.exename.pid.

> With a random filename, if you have a process which forks more than once, 
> working out which gmon.out* file corresponds to which process could be 
> tricky.

Acknowledged.  Even with pids it may not be easy.. the files are created 
and written to at process exit so one is always going to be a bit lost 
working out which file belongs to which process.  But the pid values are 
certainly easier to type than six random alphanumerics :).

> A brief search tells me that apparently glibc supports the (undocumented) 
> GMON_OUT_PREFIX env var which enables a similar behaviour.

Ah, I did not know about that.  It would be easy to implement.

So I'm leaning towards choosing file name as GMON_OUT_PREFIX.exename.pid 
with GMON_OUT_PREFIX defaulting to "gmon.out" if unspecified.

Do you think the expanded name should be used in all cases, or only when 
there's a gmon.out already present?

..mark
