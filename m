Return-Path: <cygwin-patches-return-3956-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30241 invoked by alias); 13 Jun 2003 03:16:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30222 invoked from network); 13 Jun 2003 03:16:09 -0000
Date: Fri, 13 Jun 2003 03:16:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFA] enable dynamic (thread safe) reents
Message-ID: <20030613031603.GA12302@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net> <3EC4D5A0.7020005@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC4D5A0.7020005@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00183.txt.bz2

On Fri, May 16, 2003 at 02:12:16PM +0200, Thomas Pfaff wrote:
>Thomas Pfaff wrote:
>
>>While single threaded apps should keep run without problems (_impure_ptr
>>is still used for the mainthread) multithreaded apps should be recompiled
>>to get the full power of the thread safe reents. This is due the
>>fact that _RRENT is used in some newlib headers directly. Unfortunately
>>this affects also static libs, therefore this is will be a longer
>>transition.
>>
>
>TTTT,
>
>this will only affect stdio
>
>stdio.h:147:#define     stdin   (_REENT->_stdin)
>stdio.h:148:#define     stdout  (_REENT->_stdout)
>stdio.h:149:#define     stderr  (_REENT->_stderr)
>
>and i consider this harmless.

Does this imply that using a DLL rebuilt like this will require recompilation
of static libraries using errno?

cgf
