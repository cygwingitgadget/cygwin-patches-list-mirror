Return-Path: <cygwin-patches-return-5093-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14725 invoked by alias); 28 Oct 2004 11:39:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14613 invoked from network); 28 Oct 2004 11:39:50 -0000
Received: from unknown (HELO sccrmhc11.comcast.net) (204.127.202.55)
  by sourceware.org with SMTP; 28 Oct 2004 11:39:50 -0000
Received: from althea (pcp04242302pcs.eatntn01.nj.comcast.net[68.38.102.230])
          by comcast.net (sccrmhc11) with ESMTP
          id <2004102811394901100km513e>; Thu, 28 Oct 2004 11:39:50 +0000
Received: from [127.0.0.1] (helo=althea.tishler.net)
	by althea with smtp (Exim 4.30)
	id I6ALTF-0001N0-BD; Thu, 28 Oct 2004 07:41:39 -0400
Received: by althea.tishler.net (sSMTP sendmail emulation); Thu, 28 Oct 2004 07:41:39 -0400
Date: Thu, 28 Oct 2004 11:39:00 -0000
From: Jason Tishler <jason@tishler.net>
To: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] Deimpersonate while accessing HKLM
Message-ID: <20041028114138.GA2112@tishler.net>
Mail-Followup-To: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>,
	cygwin-patches@cygwin.com
References: <3.0.5.32.20041027203301.0081e7d0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041027203301.0081e7d0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00094.txt.bz2

Pierre,

On Wed, Oct 27, 2004 at 08:33:01PM -0400, Pierre A. Humblet wrote:
> This patch should fix the chdir problem reported by Jason Tishler.
> It deimpersonates while reading the mounts and cygdrive in HKLM.

I can confirm that the above solves the proftpd chdir problem.  I really
appreciate you tracking this down.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
