Return-Path: <cygwin-patches-return-8382-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100955 invoked by alias); 10 Mar 2016 00:54:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100936 invoked by uid 89); 10 Mar 2016 00:54:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=DOT, Maintainer, columns, Geisert
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 10 Mar 2016 00:54:57 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u2A0sQFr073126	for <cygwin-patches@cygwin.com>; Wed, 9 Mar 2016 16:54:26 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 10 Mar 2016 00:54:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
In-Reply-To: <20160309224400.GA13258@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net>
References: <56DFE128.6080308@maxrnd.com> <20160309224400.GA13258@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00088.txt.bz2

On Wed, 9 Mar 2016, Corinna Vinschen wrote:
> Hi Mark,
>
> On Mar  9 00:39, Mark Geisert wrote:
>> This is Version 3 incorporating review comments of Version 2.  This is just
>> the code patch; a separate doc patch is forthcoming.
>
> The patch looks fine to me code-wise.  I just have a few style requests:
>
>> +	if ((prefix = getenv("GMON_OUT_PREFIX")) != NULL) {
>> +		char *buf;
>> +		long divisor = 1000*1000*1000;	// covers positive pid_t values
>
> Why "long"?  It's safe to use here, but it doesn't match the incoming
> datatype.  pid_t is 4 bytes, but long is 8 bytes on x86_64.  If you
> like it better that way we can keep it in but wouldn't, say, int32_t
> be a better match?  Also, can you convert the TAB to a space preceeding
> the comment so it's within 80 columns, please?

The "long" was a dumb mistake (and malingering 32-bit orientation) on my 
part.  It shall be made int32_t of course.

> I'm also a bit unhappy with some of the comments not trailing on a code
> line.  E.g.:
>
> // sample the pc of the thread indicated by thr, but bail if anything amiss
>
> // record profiling samples for other pthreads, if any
>
> Ideally that would be /**/ style comments, starting in uppercase and
> as full sentences ending with a dot, e.g.:
>
> /* Sample the pc of the thread indicated by thr, but bail if anything amiss. */
>
> /* Record profiling samples for other pthreads, if any. */

I'll go over the whole patch set to get rid of nonleading TABs and to fix 
the comments as you suggest.  The latter was just me not realizing there 
was a convention to follow so I didn't :-).  All shall be fixed.

gmon.c/.h need to be reformatted to GNU style like the rest of Cygwin but 
I'm leaving that to a future patch (NO I AM NOT COMMITTING TO THAT!! :-).

> With these changes I'll apply the patch.
>
>
> Thanks,
> Corinna
>
> -- 
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat
>

Cheers,

..mark
