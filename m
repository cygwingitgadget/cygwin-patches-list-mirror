Return-Path: <cygwin-patches-return-6898-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13890 invoked by alias); 10 Jan 2010 21:28:35 -0000
Received: (qmail 13878 invoked by uid 22791); 10 Jan 2010 21:28:35 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 10 Jan 2010 21:28:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id AE56C6D4190; Sun, 10 Jan 2010 22:28:20 +0100 (CET)
Date: Sun, 10 Jan 2010 21:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: making scanf byte-clean(er)
Message-ID: <20100110212820.GB14511@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <416096c61001101139s28d568f0x7ab944987d4dbff5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416096c61001101139s28d568f0x7ab944987d4dbff5@mail.gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00014.txt.bz2

On Jan 10 19:39, Andy Koppe wrote:
> Attached is a patch for making the scanf format string (more)
> byte-transparent. It actually couldn't deal with non-ASCII chars at
> all, even valid ones, due to comparing an 'unsigned char' with a
> (signed) 'char'. And when encountering an invalid byte, it would go
> backwards in the format string. Finally, it wrongly reset the
> multibyte conversion state for every character and used the same state
> object for the format string and %ls arguments.
> 
> I thought I'd send the patch here for review first before sending it
> upstream. Hope that makes sense.

Well... we're all reading newlib anyway and the code you're changing is
affecting all newlib targets, not just Cygwin.  If you remove the
vfprintf patch and add the missing ChangeLog entry before sending it to
the newlib list, we might better discuss it right there.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
