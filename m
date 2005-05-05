Return-Path: <cygwin-patches-return-5423-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26782 invoked by alias); 5 May 2005 16:40:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26390 invoked from network); 5 May 2005 16:40:09 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 5 May 2005 16:40:09 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DTjH6-0006B4-Ln
	for cygwin-patches@cygwin.com; Thu, 05 May 2005 18:32:32 +0200
Received: from nat.electric-cloud.com ([63.82.0.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Thu, 05 May 2005 18:32:32 +0200
Received: from foo by nat.electric-cloud.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Thu, 05 May 2005 18:32:32 +0200
To: cygwin-patches@cygwin.com
From:  "Usman Muzaffar" <foo@muzaffar.org>
Subject:  Re: [PATCH] fix startup race in shared.cc
Date: Thu, 05 May 2005 16:40:00 -0000
Message-ID: <d5dhoi$c8k$1@sea.gmane.org>
References:  <d593nc$uam$1@sea.gmane.org> <20050504012015.GE23476@trixie.casa.cgf.cx>
Reply-To:  "Usman Muzaffar" <foo@muzaffar.org>
X-SW-Source: 2005-q2/txt/msg00019.txt.bz2


"Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com> wrote in message
> I don't believe that your patch goes far enough to ensure the
> consistency of the shared memory before checking things.  I've checked
> in a change which should ensure that the area has been initialized
> before it is used.

That's great, thanks. Will there be a snapshot that includes the
next patch? The cygwin.com/snapshots page says both that snapshots are
generated "on a period basis" and "sporadically" - wasn't sure if that
meant I should request one or just be patient. :)

Thanks again for the prompt attention.
-Usman


