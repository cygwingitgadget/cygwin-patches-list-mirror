Return-Path: <cygwin-patches-return-6749-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27532 invoked by alias); 8 Oct 2009 07:54:11 -0000
Received: (qmail 27522 invoked by uid 22791); 8 Oct 2009 07:54:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Oct 2009 07:53:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BD0ED6D5598; Thu,  8 Oct 2009 09:53:48 +0200 (CEST)
Date: Thu, 08 Oct 2009 07:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fd leak in utimensat
Message-ID: <20091008075348.GB28936@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACD56AF.7080905@byu.net> <4ACD59D2.6010302@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACD59D2.6010302@byu.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00080.txt.bz2

On Oct  7 21:17, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Eric Blake on 10/7/2009 9:04 PM:
> > I haven't spent time trying to locate where the leak is happening, but
> > process explorer confirms that this STC leaves a handle open to the file,
> > preventing further re-creation of a new file by the same name.
> 
> Found it.  OK to apply?  In case it wasn't obvious, the leak only happens

Sure!


Thanks for catching,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
