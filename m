Return-Path: <cygwin-patches-return-7090-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11398 invoked by alias); 10 Sep 2010 17:23:30 -0000
Received: (qmail 11371 invoked by uid 22791); 10 Sep 2010 17:23:20 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-46-163.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.46.163)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 10 Sep 2010 17:23:14 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C188913C061	for <cygwin-patches@cygwin.com>; Fri, 10 Sep 2010 13:23:12 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id BB1832B352; Fri, 10 Sep 2010 13:23:12 -0400 (EDT)
Date: Fri, 10 Sep 2010 17:23:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100910172312.GA23015@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100910150840.GD16534@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00050.txt.bz2

On Fri, Sep 10, 2010 at 05:08:40PM +0200, Corinna Vinschen wrote:
>What I'm still mulling over is a good idea to re-use the results of a
>former call to readdir in a stat call.  One problem here is to make sure
>that a subsequent stat call is *really* accessing the same file as the
>former readdir returned.

I've considered that before but you really can't cheaply determine that
the file hasn't changed without going to the OS.  And, then it isn't cheap.

cgf
