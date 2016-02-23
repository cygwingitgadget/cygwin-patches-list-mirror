Return-Path: <cygwin-patches-return-8354-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68311 invoked by alias); 23 Feb 2016 07:36:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68297 invoked by uid 89); 23 Feb 2016 07:36:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=UD:cygwin1.dll, cygwin1.dll, cygwin1dll, H*r:8.12.11
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Tue, 23 Feb 2016 07:36:51 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u1N7aV7S010747;	Mon, 22 Feb 2016 23:36:31 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Tue, 23 Feb 2016 07:36:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
In-Reply-To: <56CAF4A3.5060806@dronecode.org.uk>
Message-ID: <Pine.BSF.4.63.1602222322100.88046@m0.truegem.net>
References: <56C820D8.4010203@maxrnd.com> <56CAF4A3.5060806@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00060.txt.bz2

Hi Jon,

On Mon, 22 Feb 2016, Jon Turney wrote:
> Thanks for this.  A few comments inline.
>
> On 20/02/2016 08:16, Mark Geisert wrote:
>> +/* Called from profil.c to sample all non-main thread PC values for 
>> profiling */
>> +extern "C" void
>> +cygheap_profthr_all (void (*profthr_byhandle) (HANDLE))
>> +{
>> +  for (uint32_t ix = 0; ix < nthreads; ix++)
>> +    {
>> +      _cygtls *tls = cygheap->threadlist[ix].thread;
>> +      if (tls->tid)
>> +	profthr_byhandle (tls->tid->win32_obj_id);
>> +    }
>> +}
>
> There doesn't seem to be anything specific to profiling about this, so it 
> could be written in a more generic way, as "call a callback function for each 
> thread".

I saw your later conversation with Corinna on the list re why 
cygwin_internal() is involved now.  (I too had stumbled over the 
cygwin1.dll/libgmon.a gap when I started this work.)  Given the necessity 
of the separation, does it still make sense to write a generic per-thread 
callback mechanism and then make use of it for this patch, or is that 
overkill?  I can't tell.

>> +	if ((prefix = getenv("GMON_OUT_PREFIX")) != NULL) {
>
> setup-env.xml might be an appropriate place to mention this environment 
> variable.

I am now writing a gprof.xml that will be tied into the existing 
programming.xml.  I plan to document GMON_OUT_PREFIX in gprof.xml.  Do you 
think that's sufficient?

..mark
