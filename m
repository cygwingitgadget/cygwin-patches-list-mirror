Return-Path: <cygwin-patches-return-3147-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29654 invoked by alias); 10 Nov 2002 08:25:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29643 invoked from network); 10 Nov 2002 08:25:36 -0000
Date: Sun, 10 Nov 2002 00:25:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Alexander Gottwald <Alexander.Gottwald@s1999.tu-chemnitz.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: SIOCGIFCONF patch
Message-ID: <20021110092533.D10395@cygbert.vinschen.de>
Mail-Followup-To: Alexander Gottwald <Alexander.Gottwald@s1999.tu-chemnitz.de>,
	cygwin-patches@cygwin.com
References: <Pine.LNX.4.44.0211092028130.23266-200000@lupus.ago.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211092028130.23266-200000@lupus.ago.vpn>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00098.txt.bz2

On Sat, Nov 09, 2002 at 08:28:39PM +0100, Alexander Gottwald wrote:
> Hi,
> 
> A user of Cygwin/Xfree86 reported that cygwin did not report an interface
> for his wireless network adapter. It seems that the GetIfTable function
> did not return all network adapters on his computer. As a workaround to
> this problem i changed the code to use GetIfEntry for each configured
> address. 
> 
> I also had to change the algorithm for finding all addresses configured
> for one network adapter and changed the previous code which could only
> enumerate 10 addresses per adapter to use sprintf and raised that limit too.

This part of the patch is fine.

> I also added code for getting the device metric for an interface. I'm 
> not sure if this is correctly solved and I have no problems with removing 
> this part again. 

As I wrote in PM yesterday, I think it's incorrect to get the IF metric
from the routing entry.  It's the other way around according to the
doc excerpt which you did friendly send to me.  So, I actually would like
to ask you to take this part out.  As soon as you send the tweaked patch,
I'll check it in.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
