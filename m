Return-Path: <cygwin-patches-return-1768-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19510 invoked by alias); 23 Jan 2002 19:37:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19493 invoked from network); 23 Jan 2002 19:37:35 -0000
Date: Wed, 23 Jan 2002 11:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fwd: [MinGW-patches] Patch for GPROF runtime on Win32
Message-ID: <20020123193734.GD18042@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020123172312.GD6765@redhat.com> <20020123192408.7414.qmail@web14508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020123192408.7414.qmail@web14508.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00125.txt.bz2

On Thu, Jan 24, 2002 at 06:24:08AM +1100, Danny Smith wrote:
> --- Christopher Faylor <cgf@redhat.com> wrote: > On Wed, Jan 23, 2002 at
>07:22:38PM +1100, Danny Smith wrote:
>> >This patch was submitted for mingw runtime. It may also be applicable to
>> >cygwin. Any comments (apart from formatting)?
>> >
>> >Here is the Changelog entry:
>> >
>> >2002-01-22  Pascal Obry  <obry@gnat.com>
>> >
>> >	* profile/profil.h (PROFADDR): Cast idx to unsigned long long to
>> >	avoid overflow.
>> >	* profile/gmon.c: Define bzero as memset if mingw32.
>> >	(monstartup): Use it.
>> >
>> 
>> Is this part of the sources in winsup?
>> 
>> cgf
>
>Yes.
>
>Pascal's patch is against files in mingw SF CVS  but the same files exist
>in winsup/mingw/profile _and_ in winsup/cygwin.  In winsup the cygwin and
>mingw versions differ slightly, but except for copyright date, most of the
>diffs are guarded by ifdef __MINGW32__. 
>
>The mingw versions have this comment:
>
>/*
> * This file is taken from Cygwin distribution. Please keep it in sync.
> * The differences should be within __MINGW32__ guard.
> */
>
>Hence my original question.  Even if I do not apply Pascal's patch it may
>be a good idea  to resync the two versions.

Ok.  You said it "may be applicable" so I was testing.

Could you check in appropriate fixes?

cgf
