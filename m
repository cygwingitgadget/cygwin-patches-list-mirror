Return-Path: <cygwin-patches-return-6770-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8785 invoked by alias); 14 Oct 2009 12:02:53 -0000
Received: (qmail 8688 invoked by uid 22791); 14 Oct 2009 12:02:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 14 Oct 2009 12:02:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A59756D5598; Wed, 14 Oct 2009 14:02:37 +0200 (CEST)
Date: Wed, 14 Oct 2009 12:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges  with CYGWIN=noroot
Message-ID: <20091014120237.GA27964@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <20091013102502.GG11169@calimero.vinschen.de> <4AD4E38A.2050301@t-online.de> <20091014104003.GA24593@calimero.vinschen.de> <1My1yO-0KvdnE0@fwd09.aul.t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1My1yO-0KvdnE0@fwd09.aul.t-online.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00101.txt.bz2

On Oct 14 13:24, Christian Franke wrote:
> Corinna Vinschen wrote:
> > 
> > Cool.  Another interesting option could be to remove the domain admins
> > group as well, if the user is a domain user and, of course, removing
> > any single user right, similar to the "capsh" tool under SELinux.
> > 
> 
> Yes, makes sense.
> 
> 
> > I'm just not sure if that tool should be part of the Cygwin package or
> > a package of its own right.  I'm leaning towards the latter choice.
> > 
> > 
> 
> ... or add it to the cygutils package ?

Sure, if Chuck likes the idea.

> Is there any tool to print the info provided by GetTokenInformation() ?
> 
> I have a preliminary version of such a tool and can contribute it later
> if desired.

I have a self-hacked version of such a tool which you can download
from here: http://cygwin.de/gettokinfo/

  `gettokinfo' prints everything except for the list of user rights.
  `gettokinfo foo' prints everything including the user rights.

The tool does not print the session ID, nor the new stuff introduced
with Windows Vista yet.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
