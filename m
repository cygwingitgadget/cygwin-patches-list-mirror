Return-Path: <cygwin-patches-return-4937-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9628 invoked by alias); 9 Sep 2004 18:14:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9582 invoked from network); 9 Sep 2004 18:14:13 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Thu, 09 Sep 2004 18:14:00 -0000
In-Reply-To: <20040909140656.GE27325@trixie.casa.cgf.cx>
       from Christopher Faylor (Sep  9, 10:06am)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] implementation of nonblocking writes on pipes
Message-Id: <20040909181407.ECB49E598@wildcard.curl.com>
X-SW-Source: 2004-q3/txt/msg00089.txt.bz2

On Sep 9, 10:06am, cgf-no-personal-reply-please@cygwin.com (Christopher Faylor) wrote:
-- Subject: Re: [Patch] implementation of nonblocking writes on pipes
>
> Before we start adding more patches which are based on your previous work,
> could you reply to some of the problems raised in the cygwin mailing list?

Sure, I'll do that now (I've fallen a few days behind reading that list).

> There was one problem with Windows 95 which Corinna fixed but now there
> is another problem with using rsync, which I thought was one of the
> impetuses for your patch.
>
-- End of excerpt from Christopher Faylor

The win95 problem was unfortunate ... I don't have a win95 system here
to test.  I'll look more closely at the patch, but I think it is correct.

The rsync problem (I assume you are talking about "rsync + xp sp2 failing")
appears to be unrelated to my patch, because I think the failure is reported
for file desriptors from a socketpair, not a pipe.  I'll try to confirm that.

In each case, I'll send a follow up message to the cygwin mailing list.

It's important to realize that my first patch does not fix all hangs
related to rsync or ssh.  I've identified and fixed at least three
distinct deadlock scenarios, and I'm submitting separate patches for each.

--
Bob
