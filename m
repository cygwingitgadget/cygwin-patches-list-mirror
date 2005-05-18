Return-Path: <cygwin-patches-return-5458-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32297 invoked by alias); 18 May 2005 08:11:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31287 invoked from network); 18 May 2005 08:10:18 -0000
Received: from unknown (HELO calimero.vinschen.de) (84.148.23.119)
  by sourceware.org with SMTP; 18 May 2005 08:10:18 -0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 042AA6D4202; Wed, 18 May 2005 10:10:24 +0200 (CEST)
Date: Wed, 18 May 2005 08:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: [patch] update documentation Was: cygwin-host-setup does not install   sshd
Message-ID: <20050518081023.GN18174@calimero.vinschen.de>
Reply-To: cygwin@cygwin.com
Mail-Followup-To: cygwin@cygwin.com, cygwin-patches@cygwin.com
References: <200505171327.AA676593880@mail.rabinglove.com> <428AB86F.75BC27A0@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428AB86F.75BC27A0@dessent.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00054.txt.bz2

On May 17 20:37, Brian Dessent wrote:
> 2005-05-17  Brian Dessent  <brian@XXX.YYY>

http://cygwin.com/acronyms#PCYMTNQREAIYR ;-)

I'd send ChangeLogs always without the head line.

> 	* install.texinfo ("How do I uninstall..."): Rewrite to cover
> 	removing services, dealing with permissions, and other common
> 	tasks for removing Cygwin completely.

Sounds good to me.  It might just be better to move the point

"Close all Cygwin command prompts, xterms, etc. and stop the X11 server [...]"

one item up and then to begin the next item with

"Open a single Cygwin command promt, remove all mount information with
 @samp{umount -A} [...]"

Do you see why?


Corinna
