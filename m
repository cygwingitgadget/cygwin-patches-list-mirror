Return-Path: <cygwin-patches-return-6381-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12570 invoked by alias); 9 Dec 2008 09:21:59 -0000
Received: (qmail 12555 invoked by uid 22791); 9 Dec 2008 09:21:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 09 Dec 2008 09:21:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7BF9C6D4356; Tue,  9 Dec 2008 10:23:02 +0100 (CET)
Date: Tue, 09 Dec 2008 09:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: <resolv.h> requires <netinet/in.h>
Message-ID: <20081209092302.GA31008@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <493DA370.30006@users.sourceforge.net> <024501c95989$2c07cc70$940410ac@wirelessworld.airvananet.com> <493DB346.2070909@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493DB346.2070909@users.sourceforge.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00025.txt.bz2

On Dec  8 17:52, Yaakov (Cygwin/X) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Pierre A. Humblet wrote:
> > Every version of man resolver that I have ever seen specifies:
> > 
> > SYNOPSIS 
> >      #include <sys/types.h>
> >      #include <netinet/in.h>
> >      #include <arpa/nameser.h>
> >      #include <resolv.h>
> > 
> > So it's up to the user to include the right files.
> 
> Perhaps so, but:
> 
> 1) <resolv.h> already #includes all of those headers *except* for
> <netinet/in.h>.
> 
> 2) this does not match Linux behaviour:
> 
> http://sourceware.org/cgi-bin/cvsweb.cgi/libc/resolv/resolv.h?cvsroot=glibc
> 
> As I stated, my STC was based on a configure test which works on other
> platforms; I don't see why we shouldn't match that.
> 
> > Sure we can make an exception for Cygwin, but the same program can then fail elsewhere.
> 
> I agree that for portability, a program should not assume that #include
> <resolv.h> automatically #include <netinet/in.h> and use the latter's
> functions or typedefs.  But the bottom line here is that <resolv.h>
> requires struct sockaddr_in, so it needs that #include.

Good point.  Pierre?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
