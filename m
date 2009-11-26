Return-Path: <cygwin-patches-return-6857-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25889 invoked by alias); 26 Nov 2009 12:47:06 -0000
Received: (qmail 25879 invoked by uid 22791); 26 Nov 2009 12:47:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Nov 2009 12:47:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 16A9E6D4481; Thu, 26 Nov 2009 13:46:51 +0100 (CET)
Date: Thu, 26 Nov 2009 12:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] override-able installation_root
Message-ID: <20091126124650.GS29173@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B0D3920.3020907@shaddybaddah.name>  <20091126112042.GO29173@calimero.vinschen.de>  <4B0E6D0B.8070501@shaddybaddah.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B0E6D0B.8070501@shaddybaddah.name>
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
X-SW-Source: 2009-q4/txt/msg00188.txt.bz2

On Nov 26 22:56, Shaddy Baddah wrote:
> Hi,
> 
> Corinna Vinschen wrote:
> >Sorry, but no.  We won't accept this patch.  We have deliberately chosen
> >to get away from the dependency to the Windows registry, and we really
> >don't want to add it back again.
> Thank you for the response. Fair enough. But is it no to the idea of
> an overridable installation_root, or to doing by way of a registry
> setting? Is there another way to do this that would be reasonable?
> Say the use of an environment variable? Other?

Don't know yet, but certainly not an environment variable since these
are read after the installation root has been handled.  And again, this
isn't something for 1.7.1.

> >Btw., for a non-trivial patch like this you need to file a copyright
> >assignment.  See http://cygwin.com/contrib.html, the "Before you get
> >started" section.
> Fair enough. I estimated that it was trivial, but I accept that it isn't.

Trivial are very small patches, usually < 10 lines.  They also should
only fix something, not add new features.

> >That's on my TODO list and PTC.  It will have to wait until after 1.7.1
> >as well, though.
> I'll ask around about copyright assignment. If I can get that
> sorted, I'll try and help with that effort.

Just use the copyright asignment form at http://cygwin.com/assign.txt


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
