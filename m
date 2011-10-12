Return-Path: <cygwin-patches-return-7527-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13389 invoked by alias); 12 Oct 2011 08:27:29 -0000
Received: (qmail 12829 invoked by uid 22791); 12 Oct 2011 08:27:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 12 Oct 2011 08:26:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5456B2CBDB1; Wed, 12 Oct 2011 10:26:43 +0200 (CEST)
Date: Wed, 12 Oct 2011 08:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add support for Windows 8, first step
Message-ID: <20111012082643.GA10913@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E949B40.20402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4E949B40.20402@gmail.com>
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
X-SW-Source: 2011-q4/txt/msg00017.txt.bz2

Hi Teemu,

First of all, we need a copyright assignment from you before we can
accept non-trivial patches to Cygwin, see http://cygwin.com/contrib.html,
the "Before you get started" section.

On Oct 11 22:38, Teemu NÃ¤tkinniemi wrote:
> Hello!
> 
> Here's a small patch that enables Cygwin to run on Windows 8 (tested
> on x64 build 8102, the Windows Developer Preview). Windows 8 does
> not seem to support FAST_CWD or the current implementation of
> FAST_CWD is not compatible with Windows 8 so it is disabled at the
> moment.

Windows 8 will very likely support the FAST_CWD stuff, the problem is
just to find out how to find the global pointer pointing to the current
FAST_CWD structure, and then, if the FAST_CWD structure changed.

Having this annoying message at startup was intentional, so that we
know that there's some work to do yet.  However, personally I don't plan
to look into W8 so soon.  Stuff like that is bound to change this early
in the release game anyway.

Therefore I don't want to disable this message.  If you're interested
to get rid of it, it would be most helpful trying to track down how to
find the global FAST_CWD pointer in W8.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
