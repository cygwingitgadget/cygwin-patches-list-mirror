Return-Path: <cygwin-patches-return-2855-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26314 invoked by alias); 22 Aug 2002 11:54:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26298 invoked from network); 22 Aug 2002 11:54:57 -0000
Date: Thu, 22 Aug 2002 04:54:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Wu Yongwei <adah@netstd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: timezonevar in time.h
Message-ID: <20020822135440.D26346@cygbert.vinschen.de>
Mail-Followup-To: Wu Yongwei <adah@netstd.com>, cygwin-patches@cygwin.com
References: <3D645438.D18ECE5@netstd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D645438.D18ECE5@netstd.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00303.txt.bz2

On Thu, Aug 22, 2002 at 11:02:16AM +0800, Wu Yongwei wrote:
> The current /usr/include/time.h requires people to use
> "#define timezonevar 1" instead of just "#define timezonevar" before
> including <time.h>:
> [...]

Hi,

time.h is in newlib, exactly newlib/libc/include/time.h.  Please send
the patch to the newlib mailing list newlib@sources.redhat.com.

> Maybe I still have something wrong here, say, not diffing from the CVS
> version (but I really did not find it). I am already struggling to do things
> right. :-)

http://cygwin.com/cvs.html

newlib is part of the cvs tree.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
