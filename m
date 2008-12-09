Return-Path: <cygwin-patches-return-6382-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10089 invoked by alias); 9 Dec 2008 15:13:49 -0000
Received: (qmail 10078 invoked by uid 22791); 9 Dec 2008 15:13:48 -0000
X-Spam-Check-By: sourceware.org
Received: from vms173003pub.verizon.net (HELO vms173003pub.verizon.net) (206.46.173.3)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 09 Dec 2008 15:12:59 +0000
Received: from PHUMBLETLAPXP ([70.88.219.194]) by vms173003.mailsrvcs.net  (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))  with ESMTPA id <0KBM00INZ7LG2VA4@vms173003.mailsrvcs.net> for  cygwin-patches@cygwin.com; Tue, 09 Dec 2008 09:12:52 -0600 (CST)
Date: Tue, 09 Dec 2008 15:13:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: <resolv.h> requires <netinet/in.h>
To: <cygwin-patches@cygwin.com>
Message-id: <028f01c95a10$9b232c80$940410ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <493DA370.30006@users.sourceforge.net>  <024501c95989$2c07cc70$940410ac@wirelessworld.airvananet.com>  <493DB346.2070909@users.sourceforge.net>  <20081209092302.GA31008@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00026.txt.bz2


----- Original Message ----- 
From: "Corinna Vinschen" <corinna-cygwin@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Tuesday, December 09, 2008 4:23 AM
Subject: Re: <resolv.h> requires <netinet/in.h>


| On Dec  8 17:52, Yaakov (Cygwin/X) wrote:
| > -----BEGIN PGP SIGNED MESSAGE-----
| > Hash: SHA256
| > 
| > Pierre A. Humblet wrote:
| > > Every version of man resolver that I have ever seen specifies:
| > > 
| > > SYNOPSIS 
| > >      #include <sys/types.h>
| > >      #include <netinet/in.h>
| > >      #include <arpa/nameser.h>
| > >      #include <resolv.h>
| > > 
| > > So it's up to the user to include the right files.
| > 
| > Perhaps so, but:
| > 
| > 1) <resolv.h> already #includes all of those headers *except* for
| > <netinet/in.h>.
| > 
| > 2) this does not match Linux behaviour:
| > 
| > http://sourceware.org/cgi-bin/cvsweb.cgi/libc/resolv/resolv.h?cvsroot=glibc
| > 
| > As I stated, my STC was based on a configure test which works on other
| > platforms; I don't see why we shouldn't match that.
| > 
| > > Sure we can make an exception for Cygwin, but the same program can then fail elsewhere.
| > 
| > I agree that for portability, a program should not assume that #include
| > <resolv.h> automatically #include <netinet/in.h> and use the latter's
| > functions or typedefs.  But the bottom line here is that <resolv.h>
| > requires struct sockaddr_in, so it needs that #include.
| 
| Good point.  Pierre?

I don't know why the original resolv.h didn't include netinet/in.h and 
I have no problem adding it in Cygwin, given it was added in Linux.
The minires package is nearing its life end, so I would make the change
starting with the built-in resolver.

Pierre
 
