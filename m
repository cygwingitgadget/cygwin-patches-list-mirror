Return-Path: <cygwin-patches-return-1767-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9467 invoked by alias); 23 Jan 2002 19:24:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9443 invoked from network); 23 Jan 2002 19:24:08 -0000
Message-ID: <20020123192408.7414.qmail@web14508.mail.yahoo.com>
Date: Wed, 23 Jan 2002 11:24:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: Fwd: [MinGW-patches] Patch for GPROF runtime on Win32
To: cygwin-patches@cygwin.com
In-Reply-To: <20020123172312.GD6765@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00124.txt.bz2

 --- Christopher Faylor <cgf@redhat.com> wrote: > On Wed, Jan 23, 2002 at
07:22:38PM +1100, Danny Smith wrote:
> >This patch was submitted for mingw runtime. It may also be applicable to
> >cygwin. Any comments (apart from formatting)?
> >
> >Here is the Changelog entry:
> >
> >2002-01-22  Pascal Obry  <obry@gnat.com>
> >
> >	* profile/profil.h (PROFADDR): Cast idx to unsigned long long to
> >	avoid overflow.
> >	* profile/gmon.c: Define bzero as memset if mingw32.
> >	(monstartup): Use it.
> >
> 
> Is this part of the sources in winsup?
> 
> cgf

Yes.

Pascal's patch is against files in mingw SF CVS  but the same files exist
in winsup/mingw/profile _and_ in winsup/cygwin.  In winsup the cygwin and
mingw versions differ slightly, but except for copyright date, most of the
diffs are guarded by ifdef __MINGW32__. 

The mingw versions have this comment:

/*
 * This file is taken from Cygwin distribution. Please keep it in sync.
 * The differences should be within __MINGW32__ guard.
 */

Hence my original question.  Even if I do not apply Pascal's patch it may
be a good idea  to resync the two versions.

Danny

http://my.yahoo.com.au - My Yahoo!
- It's My Yahoo! Get your own!
