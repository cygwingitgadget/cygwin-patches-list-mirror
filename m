Return-Path: <cygwin-patches-return-2454-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6717 invoked by alias); 18 Jun 2002 02:46:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6622 invoked from network); 18 Jun 2002 02:46:17 -0000
Message-Id: <3.0.5.32.20020617224247.007faad0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 17 Jun 2002 19:46:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin() patch is in
In-Reply-To: <20020617133144.A30892@cygbert.vinschen.de>
References: <20020616051506.GA6188@redhat.com>
 <20020613052709.GA17779@redhat.com>
 <20020613052709.GA17779@redhat.com>
 <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
 <20020616051506.GA6188@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00437.txt.bz2

At 01:31 PM 6/17/2002 +0200, Corinna Vinschen wrote:
>The original reason was to speed up things in domain environments.
>The local machine has buffered the user information so it's called
>first.  Only if that fails we fallback to calling the logon server
>(a PDC probably).  This should avoid unnecessary net access.
>
>I'm curious, too, what you mean by "name aliasing".  Are you talking
>about having a local and a domain user of the same name?

Yes, precisely.

About caching, I did some experiments on NT.
The SID doesn't seem to be cached, in the sense that calling 
LookupAccountSid() twice in a row, with the Ethernet unplugged the 
second time, returns a failure after a very long delay.
I also tried calling NetUserGetInfo() with domain\user argument,
but that doesn't work.
I don't really see how Windows could cache the username (without 
knowing the domain), due to the aliasing problem. However
I haven't tried it.

Pierre
