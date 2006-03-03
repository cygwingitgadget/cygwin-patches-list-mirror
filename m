Return-Path: <cygwin-patches-return-5792-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32701 invoked by alias); 3 Mar 2006 17:42:06 -0000
Received: (qmail 32691 invoked by uid 22791); 3 Mar 2006 17:42:05 -0000
X-Spam-Check-By: sourceware.org
Received: from zipcon.net (HELO zipcon.net) (209.221.136.5)     by sourceware.org (qpsmtpd/0.31) with SMTP; Fri, 03 Mar 2006 17:42:03 +0000
Received: (qmail 6637 invoked from network); 3 Mar 2006 09:44:56 -0800
Received: from unknown (HELO efn.org) (209.221.136.22)   by mail.zipcon.net with SMTP; 3 Mar 2006 09:44:56 -0800
Received: by efn.org (sSMTP sendmail emulation); Fri, 3 Mar 2006 09:41:57 -0800
Date: Fri, 03 Mar 2006 17:42:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: Dave Korn <dave.korn@artimi.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
Message-ID: <20060303174157.GA3704@efn.org>
References: <20060303094621.GP3184@calimero.vinschen.de> <03f701c63ec4$0eee53d0$a501a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f701c63ec4$0eee53d0$a501a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.4.2.1i
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00101.txt.bz2

On Fri, Mar 03, 2006 at 01:12:01PM -0000, Dave Korn wrote:
> On 03 March 2006 09:46, Corinna Vinschen wrote:
> 
> > 
> > Btw., since you seem to be interested in hacking the registry...  would
> > you also be interested to introduce registry write access below
> > /proc/registry inside of the Cygwin DLL?  That would be extra cool.
> > I'm not quite sure how to handle the mapping from file types to
> > registry key types, but there might be some simple way which I'm just
> > too blind to see.
> 
> 
>   Hey, how about using pseudo filename-extensions on the pseudo-files that
> represent registry keys?

As long as we are how-bouting, I'm looking at

http://search.cpan.org/~tyemq/Win32-TieRegistry-0.24/TieRegistry.pm

as another example of non-traditional access to the registry.  How
about /proc/registry//machinename/... to access the registry of other
computers on the network?  Or is // not at the beginning a no-no?
