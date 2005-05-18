Return-Path: <cygwin-patches-return-5469-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8514 invoked by alias); 18 May 2005 18:42:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8444 invoked from network); 18 May 2005 18:42:19 -0000
Received: from unknown (HELO vms046pub.verizon.net) (206.46.252.46)
  by sourceware.org with SMTP; 18 May 2005 18:42:19 -0000
Received: from PHUMBLETLAP ([12.6.244.2])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IGP00BF17YDO9A8@vms046.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Wed, 18 May 2005 13:42:14 -0500 (CDT)
Date: Wed, 18 May 2005 18:42:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
To: <cygwin-patches@cygwin.com>
Reply-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Message-id: <007601c55bd9$4e8495f0$3e0010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
 <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
 <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
 <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net>
 <20050511085307.GA2805@calimero.vinschen.de>
 <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com>
 <20050512200222.GD5569@trixie.casa.cgf.cx>
 <20050513135745.GD10577@trixie.casa.cgf.cx>
 <loom.20050513T164025-465@post.gmane.org>
 <3.0.5.32.20050518082203.00b5ea78@incoming.verizon.net>
 <20050518164848.GA11455@calimero.vinschen.de>
X-SW-Source: 2005-q2/txt/msg00065.txt.bz2


----- Original Message ----- 
From: "Corinna Vinschen"
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, May 18, 2005 12:48 PM
Subject: Re: [Patch]: mkdir -p and network drives


> Hi Pierre,
>
> I don't see a reason why you moved telldir just a few lines up.
> Any reasoning, perhaps together with a ChangeLog entry?

Nope, it was an accidental cut and I pasted it back a few lines off.

>
> Why did you remove fhandler_cygdrive::telldir but not
> fhandler_cygdrive::seekdir?  Both are just calling their base class
> variants.

I am still working on  fhandler_cygdrive. I stopped to keep the size
of the patch small.

> > -  else if (isvirtual_dev (dev.devn) && fileattr ==
INVALID_FILE_ATTRIBUTES)
> > -    {
> > -      error = dev.devn == FH_NETDRIVE ? ENOSHARE : ENOENT;
> > -      return;
> > -    }
>
> I don't understand this one.  What's the rational behind removing
> these lines?

- They won't work the day we support writing to the registry.
- More generally, I think it's cleaner to do device specific error handling
in the fhandlers, instead of adding conditionals in path.cc
- In the case where one tries to create a file or directory on a virtual
device,
one gets EROFS with this patch, instead of ENOSHARE or ENOENT before.
That seems more logical.

Pierre


