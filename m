Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id DD3503858D39
	for <cygwin-patches@cygwin.com>; Tue,  7 Mar 2023 09:22:29 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZk5x-1q2TJ51Csx-00WjwU for <cygwin-patches@cygwin.com>; Tue, 07 Mar 2023
 10:22:28 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AEC49A80721; Tue,  7 Mar 2023 10:22:27 +0100 (CET)
Date: Tue, 7 Mar 2023 10:22:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: type mismatch on cpuset.h
Message-ID: <ZAcCU8+KL4MMq26k@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41f9bb68-d5e0-58d7-701f-a84b9db6b9a9@gmail.com>
 <ZAWqmGwaqbDtwNF8@calimero.vinschen.de>
 <cbc6009b-6aa0-69bd-e264-05e616f3721e@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbc6009b-6aa0-69bd-e264-05e616f3721e@maxrnd.com>
X-Provags-ID: V03:K1:NWoj1zM1OfO2kTk22PE7eFPM/QpARNaKQHV3+Yr+g13M5jluwng
 N7um3N3l+zFBAKVJ03w14LGhK74v66wlAL6wisfae0r9wNQ6+vGBu+fFJriO3W8fCNrW1N1
 NR4Jy27nj6cbLz3/0UQvbpk5bsJ5OC1ml5vPfnQxshavc4kMHzGL+KwlxZSjI6+FZOszag2
 4A7SXijRN6Lj5QyEkPu4w==
UI-OutboundReport: notjunk:1;M01:P0:f5JF4sAjdLw=;v0Ka2oVVIxwGxNFNkqGPiLXbAhs
 l31pVRNLIHmgOqk1Q1bkbwgV0vtUGmONwwipIrNJuiCQo98m5blinQy0WhJdWdUG81JleiAfC
 iH2WRKGy27ZzXm1pKL3XAsAn9GlojC5AeTXm96TgshZ0nqn1ImGlzRS0ltzgKZCnf1Mh14KzN
 Ni/gfCdMxgPhS43q2xLXQjBxp6b92fHp9lJ9FvR58MB+SHPFe66uHXZ739PcyjgdW/aoVXpgG
 3y6aeaSLYPRV3xGvrlv4vyzYlSZ3+y1pKGh+XvxdNS8+WYapKIqScTKqS7n2R6U3B1C4w3Eas
 0PbqwE14vyVDz05jdLKYEEkDh7tM4Xa8Q3I6y8vukymCg7GhPWyLOuLlJJhOjcwpQeJdaASXm
 kVQZwc/M+DPxDEONn6OdI8BwtYXpy0G4HQnBLvrz+g/+IKMiwstE68uwx0NU7cTRjdrTCbeds
 0AVl/rrdGYt+uityEOb25KwyGLN77BpfE1XSLyVQpOsniwhLdoPn3zAmKcxtEMzi/mzkTVaxa
 Trtw877PpHT8yjKXXkNMH/ZkRAkA5H8tdY8MNe/G3Vncbz+G8CrGvMORQJgMq9C0F72Hobhku
 sJzI2yh8yPSTTRCiFmAy8BAy/QM9kyfbiFLg9onzqzhiE66YA7u1QcTKSSYp1ZHL9+p9stfPe
 78QQEfoCqAvEzfYx+pkZxaV/a0lpCV+Dx7XdBJfNtg==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Mar  7 00:09, Mark Geisert wrote:
> [Redirected here from the main mailing list...]
> 
> Hi Corinna,
> 
> Corinna Vinschen via Cygwin wrote:
> > Hi Mark,
> > 
> > On Mar  6 07:57, Marco Atzeri via Cygwin wrote:
> > > Hi,
> > > 
> > > building latest gdal I noticed a type mismatch, that forced me to build
> > > with "-fpermissive"
> > > 
> > > on /usr/include/sys/cpuset.h
> > > 
> > >   #define CPU_ALLOC(num)      __builtin_malloc (CPU_ALLOC_SIZE(num))
> > > 
> > > 
> > > but on
> > > https://linux.die.net/man/3/cpu_alloc
> > > 
> > >   cpu_set_t *CPU_ALLOC(int num_cpus)
> > > 
> > > 
> > > so void* versus cpu_set_t*
> > 
> > Marco is correct.  cpuset.h was your pet project a while back.  Would
> > you like to pick it up?  Maybe we should convert all the macros into
> > type-safe inline functions, or macros calling type-safe (inline)
> > functions, as on Linux as well as on BSD?
> 
> As far as I can tell from online docs, the CPU_SET(3) macros are still
> macros on Linux, though they are documented with prototypes as if they were
> functions.
> 
> I don't immediately see a need to change our cpuset.h for this.
> 
> I'm also uncertain what exactly you mean by "type-safe" in this context.
> Could you please give me an example for one of the macros?

Marco gave a good example.  Projects expect to be able to do

   cpuset_t *set = CPU_ALLOC(42);

without warnings, especially if -Werror is set in the project.
However, given the malloc call isn't casted to (cpu_set_t *),
you'll get matching warnings.

Look at FreeBSD:

  #define CPU_ALLOC(_s)  __cpuset_alloc(_s)
  extern cpuset_t *__cpuset_alloc(size_t set_size);

or Linux:

  # define CPU_ALLOC(count) __CPU_ALLOC (count)
  #define __CPU_ALLOC(count) __sched_cpualloc (count)
  extern cpu_set_t *__sched_cpualloc (size_t __count);

This is type-safe, because it redirects the macros to functions
taking typed parameters and returning the correct, expected type.

You can combine this with inline definitions, so you get this
all inside the header:

  #define CPU_ALLOC(_s)  __cpuset_alloc(_s)
  static inline cpuset_t *__cpuset_alloc(size_t _size)
  {
    return (cpuset_t *) __builtin_malloc (CPU_ALLOC_SIZE(num));
  }

> I desk-checked all the macros vs their prototypes and I believe CPU_ALLOC
> that Marco ran into is the only faulty one.  It could be fixed with a cast.
> CPU_FREE's result is void so I should make sure __builtin_free()
> corresponds. CPU_ALLOC_SIZE's result is size_t and I believe the macro is
> correct as-is because it is an expression using untyped integers and
> sizeof()s, the latter are size_t-returning.
> 
> The other few macros that return results return int, and those are precisely
> the ones whose inline code uses an int variable to accumulate a result.
> 
> If there is some other consideration I'm not seeing, e.g. readability,
> please let me know.  Otherwise I don't really see a need for changes here
> (modulo casting return values properly where needed).

That's ok, make your own judgement call.  I don't expect you to
implement this in a certain style, but looking at FreeBSD headers is
often a good idea.


Corinna
