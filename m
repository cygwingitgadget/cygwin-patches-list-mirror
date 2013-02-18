Return-Path: <cygwin-patches-return-7812-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26932 invoked by alias); 18 Feb 2013 21:05:36 -0000
Received: (qmail 26703 invoked by uid 22791); 18 Feb 2013 21:05:18 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 18 Feb 2013 21:05:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1EA7F5205B0; Mon, 18 Feb 2013 22:05:11 +0100 (CET)
Date: Mon, 18 Feb 2013 21:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Qsort defects (in C-library)
Message-ID: <20130218210511.GA30648@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1361206282.74694.YahooMailNeo@web141004.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1361206282.74694.YahooMailNeo@web141004.mail.bf1.yahoo.com>
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
X-SW-Source: 2013-q1/txt/msg00023.txt.bz2

On Feb 18 08:51, Dennis de Champeaux wrote:
> 
> 
> // I hope this is the proper mailing list

Unfortunately it's not.  Qsort is not implemented in Cygwin itself, but
rather in newlib, the underlying C lib.  The right mailing list is
newlib AT sourceware DOT org.
It's also kind of good style not to send the entire code, but rather a
context diff relative to current CVS.  For anonymous CVS access, see the
"Download" link at http://sourceware.org/newlib/


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
