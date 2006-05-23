Return-Path: <cygwin-patches-return-5864-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3582 invoked by alias); 23 May 2006 15:31:29 -0000
Received: (qmail 3571 invoked by uid 22791); 23 May 2006 15:31:28 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 23 May 2006 15:31:25 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 2CCCD13C01F; Tue, 23 May 2006 11:31:24 -0400 (EDT)
Resent-From: Christopher Faylor <me@cgf.cx>
Resent-Date: Tue, 23 May 2006 11:31:24 -0400
Resent-Message-ID: <20060523153124.GA24425@trixie.casa.cgf.cx>
Resent-To: cygwin-patches@cygwin.com
Date: Tue, 23 May 2006 15:31:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Using newer autoconf in src/winsup directory
Message-ID: <20060523145159.GB9036@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000001c67e3c$dfb77e80$9d6d65da@anykey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c67e3c$dfb77e80$9d6d65da@anykey>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00052.txt.bz2

On Tue, May 23, 2006 at 07:45:32PM +1200, Danny Smith wrote:
>RE: http://cygwin.com/ml/cygwin-patches/2006-q2/msg00051.html
>
>I am not subscribed to cygwin-patches so I'm posting here.  Forgive me
>if I've transgressed boundares, but I've always considered mingw as a
>cygwin-dependent app.
>
>Applying the above patch, running aclocal and then autoconf-2.5x, then
>./configure ---host=mingw32 --target=mingw32 works for mingw and w32api
>subdirs from a cygwin bash shell.
>
>I haven't tried with msys tools since I don't have them.

Didn't you notice some problems with AC_CONFIG_AUX_DIR being set
incorrectly, Danny?

I found this and a few problems with the patch, where Cygwin is
concerned.  I'm testing some changes now and hope to have something
checked in soon.

cgf
