Return-Path: <cygwin-patches-return-7204-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20062 invoked by alias); 15 Mar 2011 07:53:31 -0000
Received: (qmail 20037 invoked by uid 22791); 15 Mar 2011 07:53:20 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 15 Mar 2011 07:53:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A97DE2C00B5; Tue, 15 Mar 2011 08:53:13 +0100 (CET)
Date: Tue, 15 Mar 2011 07:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Message-ID: <20110315075313.GA5722@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D7CDDC7.5060708@dronecode.org.uk> <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D7E908B.4010004@dronecode.org.uk>
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
X-SW-Source: 2011-q1/txt/msg00059.txt.bz2

On Mar 14 22:02, Jon TURNEY wrote:
> On 13/03/2011 15:21, Corinna Vinschen wrote:
> > Thanks for the patch, but afaics you don't have a copyright assignment
> > on file with Red Hat.  It's unfortunately required for substantial
> > patches.  Please see http://cygwin.com/contrib.html, especially the
> > "Before you get started" section.
> 
> No problem, I have signed and posted an assignment, although I'm not sure I
> consider this patch 'substantial' :-)

Thanks.  I'm looking forward to get it.

I think your patch is a good idea, but apart from the fact that I have
to wait for your copyright assignment, I'm reluctant to add it to 1.7.9.
As you probably have seen in CVS, I'm adding new stuff only to a
post-1.7.9 branch right now.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
