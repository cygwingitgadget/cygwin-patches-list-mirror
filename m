Return-Path: <cygwin-patches-return-5157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16750 invoked by alias); 22 Nov 2004 15:48:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16706 invoked from network); 22 Nov 2004 15:48:41 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 22 Nov 2004 15:48:41 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I7L7WY-00009V-20
	for cygwin-patches@cygwin.com; Mon, 22 Nov 2004 10:48:34 -0500
Message-ID: <41A20A4E.C4A20EC6@phumblet.no-ip.org>
Date: Mon, 22 Nov 2004 15:48:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading the registry hive on Win9x (part 2)
References: <3.0.5.32.20041121215538.008217f0@incoming.verizon.net> <20041122152518.GD25781@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00158.txt.bz2


Christopher Faylor wrote:
> 
> On Sun, Nov 21, 2004 at 09:55:38PM -0500, Pierre A. Humblet wrote:
> >-  got_something_from_registry = regopt ("default");
> >   if (myself->progname[0])
> >-    got_something_from_registry = regopt (myself->progname) || got_something_from_registry;
> >+    got_something_from_registry = regopt (myself->progname);
> >+  got_something_from_registry =  got_something_from_registry || regopt ("default");
> 
> Doesn't this change the sense of the "default" key so that it will never
> get used if a key exists for myself->progname rather than always get
> used, regardless?  Maybe I'm the only person in the world who relies on
> that behavior, but I do rely on it.

Hmm, I thought that what went on before was that the "default"
key was always read, but that it was overwritten if the other key
existed. Is it the case that there is no complete overwriting,
it's the union that counts? If so, I will put it back that way.

I didn't know that every program was trying to read 4 items in the
registry. Wouldn't it make sense to keep inheritable keys to the Cygwin
registry branches on the cygheap, instead of walking down the hierarchy
four times?

By the way, perhaps others in the world would also find that feature
useful, but AFAIK it's a well kept secret. FAQ or users' guide alert?
 
Pierre
