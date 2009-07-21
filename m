Return-Path: <cygwin-patches-return-6576-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14139 invoked by alias); 21 Jul 2009 13:29:32 -0000
Received: (qmail 14103 invoked by uid 22791); 21 Jul 2009 13:29:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 21 Jul 2009 13:29:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CDD8B6D559F; Tue, 21 Jul 2009 15:29:14 +0200 (CEST)
Date: Tue, 21 Jul 2009 13:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: bug in dup2
Message-ID: <20090721132914.GA1739@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A65AFE8.1070903@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A65AFE8.1070903@byu.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00030.txt.bz2

On Jul 21 06:09, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> POSIX requires dup2(1,1) to return 1 (if stdout is open), not 0.  I wonder
> how long that bug has been present?  And the STC:
> 
> #include <unistd.h>
> int main() { return dup2 (1, 1); }
> 
> 2009-07-21  Eric Blake  <ebb9@byu.net>
> 
> 	* dtable.cc (dup2): Correct return value for no-op.

Applied.


Thanks for catching,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
