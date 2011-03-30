Return-Path: <cygwin-patches-return-7223-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27479 invoked by alias); 30 Mar 2011 08:14:13 -0000
Received: (qmail 27418 invoked by uid 22791); 30 Mar 2011 08:13:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 30 Mar 2011 08:13:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4CD2A2C013A; Wed, 30 Mar 2011 10:13:41 +0200 (CEST)
Date: Wed, 30 Mar 2011 08:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] /proc/loadavg: add running/total processes
Message-ID: <20110330081341.GA28987@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301445133.756.11.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301445133.756.11.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00078.txt.bz2

On Mar 29 19:32, Yaakov (Cygwin/X) wrote:
> This patch adds the fourth component of Linux's /proc/loadavg[1], the
> current running/total processes count.  My only question is if states
> other than 'O' and 'R' should be considered "running" for this purpose.

That looks right.  But I don't see that get_process_state will ever
generate an 'O'.  Wouldn't that be the difference between StateReady (R)
and StateRunning (O)?

> -  return __small_sprintf (destbuf, "%u.%02u %u.%02u %u.%02u\n",
> -				    0, 0, 0, 0, 0, 0);
> +  return __small_sprintf (destbuf, "%u.%02u %u.%02u %u.%02u %u/%u\n",
> +				    0, 0, 0, 0, 0, 0, running, pids.npids);

What about the last column in /proc/loadavg, the last pid?  Shouldn't
this be added and set to 0 as well?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
