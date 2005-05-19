Return-Path: <cygwin-patches-return-5472-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15027 invoked by alias); 19 May 2005 05:06:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14977 invoked from network); 19 May 2005 05:06:27 -0000
Received: from unknown (HELO smtp815.mail.sc5.yahoo.com) (66.163.170.1)
  by sourceware.org with SMTP; 19 May 2005 05:06:27 -0000
Received: from unknown (HELO JAKE) (vance.turner@sbcglobal.net@67.100.79.252 with login)
  by smtp815.mail.sc5.yahoo.com with SMTP; 19 May 2005 05:06:26 -0000
From: "Vance Turner" <vance.turner@sbcglobal.net>
To: "'Pierre A. Humblet'" <Pierre.Humblet@ieee.org>,
	<cygwin-patches@cygwin.com>
Subject: RE: [Patch]: mkdir -p and network drives
Date: Thu, 19 May 2005 05:06:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <007601c55bd9$4e8495f0$3e0010ac@wirelessworld.airvananet.com>
X-SW-Source: 2005-q2/txt/msg00068.txt.bz2
Message-ID: <20050519050600.x2J9LoYSP0ZaHMiLX3bR5KuYMiYnldTiljfN4bNsK5Y@z>

I usually don't write you guys, I follow the thread to see how development
is going.

Just a note. The ls command is't quite right.

 Ls -lRC wil not recursively list the files and directories in verbose mode.
The l flag seems to be ignored.

-----Original Message-----
From: cygwin-patches-owner@cygwin.com
[mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Pierre A. Humblet
Sent: Wednesday, May 18, 2005 11:42 AM
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives


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




