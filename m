Return-Path: <cygwin-patches-return-4942-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11972 invoked by alias); 10 Sep 2004 17:33:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11948 invoked from network); 10 Sep 2004 17:33:39 -0000
Date: Fri, 10 Sep 2004 17:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040910173500.GA9110@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040910090123.GV17670@cygbert.vinschen.de> <20040910155505.48E86E538@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910155505.48E86E538@carnage.curl.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00094.txt.bz2

On Fri, Sep 10, 2004 at 11:55:05AM -0400, Bob Byrnes wrote:
>It's not obvious to me why socketpairs would be inherently faster
>than pipes.  Maybe my latest patch exacerbated a longstanding but
>not-fully-appreciated performance problem ... I'd certainly be
>interested in improving that.

I wonder if sshd is receiving a lot of signals.  The method for
dealing with signals when blocking on pipes is pretty fragile and
I could see it causing slowdowns.

cgf
