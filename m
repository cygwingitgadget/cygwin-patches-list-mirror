Return-Path: <cygwin-patches-return-7202-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10661 invoked by alias); 13 Mar 2011 15:21:28 -0000
Received: (qmail 10629 invoked by uid 22791); 13 Mar 2011 15:21:19 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 13 Mar 2011 15:21:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0C04A2C0243; Sun, 13 Mar 2011 16:21:12 +0100 (CET)
Date: Sun, 13 Mar 2011 15:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Message-ID: <20110313152111.GA7064@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D7CDDC7.5060708@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D7CDDC7.5060708@dronecode.org.uk>
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
X-SW-Source: 2011-q1/txt/msg00057.txt.bz2

Hi Jon,

On Mar 13 15:07, Jon TURNEY wrote:
> 
> Attached is a patch which avoids a fork failure due to remap error in the
> specific circumstances described in my email [1], by adding an additional pass
> to load_after_fork() which forces the DLL to be relocated by VirtualAlloc()ing
> a block of memory at the load address as well.
> 
> Hopefully it can be seen by inspection that this code doesn't change the
> behaviour of the first two passes, and so will only be changing the behaviour
> in what was an fatal error case before.

Thanks for the patch, but afaics you don't have a copyright assignment
on file with Red Hat.  It's unfortunately required for substantial
patches.  Please see http://cygwin.com/contrib.html, especially the
"Before you get started" section.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
