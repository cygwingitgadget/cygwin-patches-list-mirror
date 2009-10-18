Return-Path: <cygwin-patches-return-6784-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28157 invoked by alias); 18 Oct 2009 16:00:38 -0000
Received: (qmail 28144 invoked by uid 22791); 18 Oct 2009 16:00:36 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail.gmx.net (HELO mail.gmx.net) (213.165.64.20)     by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 18 Oct 2009 16:00:32 +0000
Received: (qmail invoked by alias); 18 Oct 2009 16:00:25 -0000
Received: from xdsl-87-78-65-75.netcologne.de (EHLO localhost.localdomain) [87.78.65.75]   by mail.gmx.net (mp020) with SMTP; 18 Oct 2009 18:00:25 +0200
Received: from ralf by localhost.localdomain with local (Exim 4.69) 	(envelope-from <Ralf.Wildenhues@gmx.de>) 	id 1MzYBE-0003Gh-Ci 	for cygwin-patches@cygwin.com; Sun, 18 Oct 2009 18:00:24 +0200
Date: Sun, 18 Oct 2009 16:00:00 -0000
From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
Message-ID: <20091018160022.GG2823@gmx.de>
References: <4AD78C5B.2080107@cwilson.fastmail.fm>  <4AD7C107.6000803@byu.net>  <4AD7D356.8030703@cwilson.fastmail.fm>  <4AD8DE16.3030506@cwilson.fastmail.fm>  <20091018084824.GA25560@calimero.vinschen.de>  <4ADB22B8.5060108@cwilson.fastmail.fm>  <4ADB3D80.4050108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ADB3D80.4050108@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-09)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00115.txt.bz2

* Dave Korn wrote on Sun, Oct 18, 2009 at 06:08:32PM CEST:
> 
>   Well, I can think of a possible counter-proposal: how about a patch that
> adds DESTDIR in the normal manner, but only on platforms that support DESTDIR
> correctly?  This could be done by testing the --host setting in the Makefile
> and either warning, erroring, or just silently overriding the definition of
> DESTDIR to empty on platforms that don't can't or won't honour it.  There
> shouldn't be anything particularly controversial about the concept of using a
> feature on some platforms where it's implemented and not on others where it isn't.

Except, of course, a string '$(DESTDIR)' that expands to an empty
string, doesn't really impact any platform on which DESTDIR support
doesn't work.

IOW, it's purely a "when users look at our makefiles, they might think
it could work" thing.

Cheers,
Ralf
