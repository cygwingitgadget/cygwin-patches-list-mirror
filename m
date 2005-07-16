Return-Path: <cygwin-patches-return-5572-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20038 invoked by alias); 16 Jul 2005 01:48:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19965 invoked by uid 22791); 16 Jul 2005 01:48:42 -0000
Received: from dessent.net (HELO dessent.net) (66.17.244.20)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 16 Jul 2005 01:48:42 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1Dtbn5-00048m-39
	for cygwin-patches@cygwin.com; Sat, 16 Jul 2005 01:48:33 +0000
Message-ID: <42D8681B.80836F15@dessent.net>
Date: Sat, 16 Jul 2005 01:48:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Changes to how-programming.texinfo
References: <1121451065.13490.13.camel@fulgurite> <20050715183012.GG13238@trixie.casa.cgf.cx> <1121453602.13490.24.camel@fulgurite> <20050715190853.GH13238@trixie.casa.cgf.cx> <1121455535.13490.28.camel@fulgurite> <20050715193900.GI13238@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Report: -5.9/5.0 ---- Start SpamAssassin results 
	* -3.3 ALL_TRUSTED Did not pass through any untrusted hosts
	* -2.6 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  0.0 AWL AWL: From: address is in the auto white-list
	---- End SpamAssassin results
X-SW-Source: 2005-q3/txt/msg00027.txt.bz2

Christopher Faylor wrote:

> Btw, the "other license" provision in the cygwin licensing web page was
> really meant as a way to accommodate other, already existing projects.

And it was very gracious of them to do that.  For an example of why this
makes life a lot easier, consider MySQL (GPL) and OpenSSL (BSD).  Now,
the MySQL license has an "OpenSSL exemption" which means it's fine to
link MySQL binaries against OpenSSL without forcing OpenSSL to the GPL. 
But, most GPL projects use the standard GPL with no execeptions.  This
means that if your distro packages ssl-enabled MySQL packages, including
libmysqlclient, then using -lmysqlclient with your pure-GPL program
violates a license because it pulls in the BSD OpenSSL code.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=283786
http://bugs.mysql.com/bug.php?id=6924

MySQL at some point figured out what kind of hell a widely used library
that is only licensed under pure GPL could cause, and added their "FLOSS
exception" which lists a number of acceptable licenses that can be used
as an exception, much like Cygwin.

http://www.mysql.com/company/legal/licensing/foss-exception.html

But I think that was a relatively new thing, and until recently most
distros were stuck with the prehistoric 3.23 version of mysql due to its
libmysqlclient being the last LGPL version available.  I presume this
was done so that e.g. BSD-licensed programs can still use
-lmysqlclient.  This really hurt MySQL adoption though because if the
vast majority of the world is still using 3.x then you really can't
write software that depends on the great features in 4.0 and 4.1 or even
5.0.  Last I checked RHEL and FC were *still* packaging this ancient
version as their default, though that might have finally changed in
RHEL4 and FC4, I don't know.

Brian
(sorry for the semi-off-topic rant.)
