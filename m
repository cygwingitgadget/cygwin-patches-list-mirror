Return-Path: <cygwin-patches-return-2456-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1994 invoked by alias); 18 Jun 2002 11:39:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1980 invoked from network); 18 Jun 2002 11:39:37 -0000
Message-ID: <3D0F1B8A.DE385130@yahoo.com>
Date: Tue, 18 Jun 2002 04:39:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Accept-Language: en
MIME-Version: 1.0
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
CC: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin() patch is in
References: <3.0.5.32.20020617213433.007fcca0@mail.attbi.com>
	 <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
	 <20020613052709.GA17779@redhat.com>
	 <20020613052709.GA17779@redhat.com>
	 <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
	 <3.0.5.32.20020617213433.007fcca0@mail.attbi.com> <3.0.5.32.20020617223823.00808640@mail.attbi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00439.txt.bz2

"Pierre A. Humblet" wrote:
> 
> At 10:00 PM 6/17/2002 -0400, Christopher Faylor wrote:
> >>>I don't understand what you mean by "env" and "/bin/env".  The type command
> >>>in bash tells me that env == /bin/env.
> >I'm sorry but I'm still not getting it.  "type bin" returns "command not
> >found" on my system.  AFAIK, I only have one "env" command and it is
> >"/usr/bin/env".
> 
> Dyslexia, I meant "type env" returns /usr/bin/env, which is on a cygexec
> drive. So your optimization kicks in when I type "env".
> /bin/env invokes exactly the same program, but somehow it's not recognized
> as being on a cygexec drive and your optimization does not kick in.
> 

You must mount the /bin as a cygexec mount point for that to work.

Earnie.
