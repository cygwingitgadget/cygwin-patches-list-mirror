Return-Path: <cygwin-patches-return-5758-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31454 invoked by alias); 16 Feb 2006 16:06:55 -0000
Received: (qmail 31427 invoked by uid 22791); 16 Feb 2006 16:06:50 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 16 Feb 2006 16:06:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 2F009544001; Thu, 16 Feb 2006 17:06:37 +0100 (CET)
Date: Thu, 16 Feb 2006 16:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
Message-ID: <20060216160637.GQ26541@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0602131341020.17217@access1.cims.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0602131341020.17217@access1.cims.nyu.edu>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00067.txt.bz2

On Feb 13 13:44, Igor Peshansky wrote:
> As promised in <http://cygwin.com/ml/cygwin/2006-02/msg00071.html>, the
> attached patch teaches cygcheck to follow symlinks when looking for
> executables, and also flags scripts.  Sorry, had legal delays in sending
> this (as you can see, I had this working since 02/03).  Comments welcome.
> 	Igor

A few comments.

- Most of your patch should go into path.cc so it can be reused, for
  instance in strace.

- Your readlink lacks checking the file attributes.  Shortcut symlinks
  require a R/O attribute to be valid, old-style symlinks require the
  SYSTEM attribute.

- Couldn't you just reuse the readlink implementation in ../cygwin/path.cc
  as is, to avoid having to different implementations?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
