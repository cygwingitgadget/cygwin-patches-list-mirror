Return-Path: <cygwin-patches-return-7321-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25537 invoked by alias); 7 May 2011 19:00:06 -0000
Received: (qmail 25185 invoked by uid 22791); 7 May 2011 18:59:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 07 May 2011 18:59:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4953B2C0578; Sat,  7 May 2011 20:59:29 +0200 (CEST)
Date: Sat, 07 May 2011 19:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)
Message-ID: <20110507185929.GA2948@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DC2D57C.7020009@t-online.de> <20110505172431.GI32085@calimero.vinschen.de> <4DC311C9.1030401@t-online.de> <20110506071407.GG8245@calimero.vinschen.de> <4DC42FB2.2090302@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DC42FB2.2090302@t-online.de>
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
X-SW-Source: 2011-q2/txt/msg00087.txt.bz2

On May  6 19:28, Christian Franke wrote:
> Corinna Vinschen wrote:
> >On May  5 23:08, Christian Franke wrote:
> >>
> >>No check in rights, sorry :-)
> >http://sourceware.org/cgi-bin/pdw/ps_form.cgi, project Cygwin, approver me.
> >
> 
> Done - Thanks!
> 
> 
> >However, I just had another look into your patch and I have a problem
> >here.  On what system and with what type of user account did you test?
> >
> >Here's what I get on Windows 2008 and W7:
> >
> >$ ~/tests/access /proc/registry/HKEY_PERFORMANCE_DATA
> >access (/proc/registry/HKEY_PERFORMANCE_DATA, F_OK) = 0
> >access (/proc/registry/HKEY_PERFORMANCE_DATA, R_OK) = -1<Permission denied>
> >access (/proc/registry/HKEY_PERFORMANCE_DATA, W_OK) = -1<Read-only file system>
> >access (/proc/registry/HKEY_PERFORMANCE_DATA, X_OK) = -1<Bad file descriptor>
> >
> 
> Hmm....
> 
> >The result is the same on W7 and 2008.  I tried with a normal user
> >account, as well as with an admin account, with full rights as well as
> >UAC-restricted.
> >
> >
> 
> Couldn't test new code in Win7 yet.
> 
> Test results:
> 
> Current code on XP SP3 and cygwin-5.7.9-1 on WIn7:
> 
> access("/proc/registry/HKEY_PERFORMANCE_DATA", F_OK)=0
> access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)=-1 <Bad file
> descriptor>
> access("/proc/registry/HKEY_PERFORMANCE_DATA", W_OK)=-1 <Read-only
> file system>
> access("/proc/registry/HKEY_PERFORMANCE_DATA", X_OK)=-1 <Bad file
> descriptor>
> 
> Current code + patch on XP
> 
> access("/proc/registry/HKEY_PERFORMANCE_DATA", F_OK)=0
> access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)=0
> access("/proc/registry/HKEY_PERFORMANCE_DATA", W_OK)=-1 <Read-only
> file system>
> access("/proc/registry/HKEY_PERFORMANCE_DATA", X_OK)=0

Yeah, right.  On second thought that looks much better.  Please
check in.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
