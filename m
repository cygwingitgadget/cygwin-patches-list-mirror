Return-Path: <cygwin-patches-return-7314-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21448 invoked by alias); 6 May 2011 07:14:51 -0000
Received: (qmail 21209 invoked by uid 22791); 6 May 2011 07:14:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 06 May 2011 07:14:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 601822C0578; Fri,  6 May 2011 09:14:07 +0200 (CEST)
Date: Fri, 06 May 2011 07:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)
Message-ID: <20110506071407.GG8245@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DC2D57C.7020009@t-online.de> <20110505172431.GI32085@calimero.vinschen.de> <4DC311C9.1030401@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DC311C9.1030401@t-online.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00080.txt.bz2

On May  5 23:08, Christian Franke wrote:
> Corinna Vinschen wrote:
> >On May  5 18:51, Christian Franke wrote:
> >>This patch fixes access("/proc/registry/HKEY_PERFORMANCE_DATA",
> >>R_OK) which always fails with EBADF.
> >>
> >>Christian
> >>
> >>2011-05-05  Christian Franke<...>
> >>
> >>	* security.cc (check_registry_access): Handle missing
> >>	security descriptor of HKEY_PERFORMANCE_DATA.
> >Do you have check in rights?  If so, please check in.
> >
> 
> No check in rights, sorry :-)

http://sourceware.org/cgi-bin/pdw/ps_form.cgi, project Cygwin, approver me.

However, I just had another look into your patch and I have a problem
here.  On what system and with what type of user account did you test?

Here's what I get on Windows 2008 and W7:

$ ~/tests/access /proc/registry/HKEY_PERFORMANCE_DATA
access (/proc/registry/HKEY_PERFORMANCE_DATA, F_OK) = 0
access (/proc/registry/HKEY_PERFORMANCE_DATA, R_OK) = -1 <Permission denied>
access (/proc/registry/HKEY_PERFORMANCE_DATA, W_OK) = -1 <Read-only file system>
access (/proc/registry/HKEY_PERFORMANCE_DATA, X_OK) = -1 <Bad file descriptor>

The result is the same on W7 and 2008.  I tried with a normal user
account, as well as with an admin account, with full rights as well as
UAC-restricted.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
