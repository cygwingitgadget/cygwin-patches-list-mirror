Return-Path: <cygwin-patches-return-2081-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9243 invoked by alias); 19 Apr 2002 01:20:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9207 invoked from network); 19 Apr 2002 01:19:59 -0000
Message-ID: <026601c1e740$4832b350$2000a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<bkeener@thesoftwaresource.com>,
	<cygwin-patches@cygwin.com>
References: <FC169E059D1A0442A04C40F86D9BA7600C5E6D@itdomain003.itdomain.net.au>
Subject: Re: [PATCH]setup.exe mklink2.cc some function arguments need to be pointers
Date: Thu, 18 Apr 2002 18:20:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0263_01C1E705.75FD93D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00065.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0263_01C1E705.75FD93D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2288

It looks like you are building in a branch.  The version of mklink2.cc I
have from the main branch is

static const char *cvsid =
  "\n%%% $Id: mklink2.cc,v 2.1 2002/03/26 00:25:15 rbcollins Exp $\n";

The most recent patch you applied to mklink2.cc (announcement attached) is
identical to my proposed patch, but it was applied in

 static const char *cvsid =
  "\n%%% $Id: mklink2.cc,v 2.1.2.2 2002/04/12 06:21:27 rbcollins Exp $\n";

The changelog for that is
2002-04-12  Robert Collins  <rbtcollins@hotmail.com>

* mklink2.cc (make_link_2): Tweak to work with current w32api headers.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.
----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>; <cygwin-patches@cygwin.com>
Sent: Thursday, April 18, 2002 15:45
Subject: RE: [PATCH]setup.exe mklink2.cc some function arguments need to be
pointers


Well if you recall I had the opposite code in place (as far as I can
tell without an actual patch), and that didn't compile for a different
set of users. I completely rebuild my OS the other day, and after that
I've needed the patch. That seemed a strong indication that the w32api
was the culprit..

Rob

> -----Original Message-----
> From: Brian Keener [mailto:bkeener@thesoftwaresource.com]
> Sent: Friday, April 19, 2002 8:46 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH]setup.exe mklink2.cc some function
> arguments need to be pointers
>
>
> Not to be a pain about this - but this have been reported
> several times in the
> past and I am running Win2000 and have the W32api-1.3-2
> installed.  I haven't
> seen any other w32api come down the pike so that appears to
> be the most recent.
> I have the patch - just took it out and no compile - put it
> back and it does
> compile.
>
> Not sure what Mike's OS or yours Robert or if it even makes a
> difference but I
> thought I would point out mine is Win2k.  I also have my just
> updated my CVS
> for cinstall so it is current.
>
> I know this is a me2 but I thought I would add what I could.
>
> Bk
>
>
>


------=_NextPart_000_0263_01C1E705.75FD93D0
Content-Type: message/rfc822;
	name="src_winsup_cinstall ChangeLog mklink2.cc.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="src_winsup_cinstall ChangeLog mklink2.cc.eml"
Content-length: 2401

Return-Path: <cygwin-cvs-return-2432-mchase=ix.netcom.com@cygwin.com>
Delivered-To: spamcop-net-mchase@spamcop.net
Received: (qmail 11732 invoked from network); 12 Apr 2002 06:21:33 -0000
Received: from unknown (HELO in2.scg.to) (192.168.1.15)
  by alpha.cesmail.net with SMTP; 12 Apr 2002 06:21:33 -0000
Received: (qmail 12205 invoked from network); 12 Apr 2002 06:21:32 -0000
Received: from unknown (HELO volcano.mail.pas.earthlink.net) (207.217.120.82)
  by scgin.cesmail.net with SMTP; 12 Apr 2002 06:21:32 -0000
Received: from motown-gp.pocket ([10.4.120.160] helo=motown)
	by volcano.mail.pas.earthlink.net with smtp (Exim 3.33 #1)
	id 16vuRA-0002Ho-00
	for mchase@spamcop.net; Thu, 11 Apr 2002 23:21:32 -0700
X-MindSpring-Loop: mchase@ix.netcom.com
Received: from sources.redhat.com ([209.249.29.67])
	by motown (Earthlink/Netcom Mail Service) with SMTP id 16VUr84Ep3NZFlu0
	for <mchase@ix.netcom.com>; Thu, 11 Apr 2002 23:21:30 -0700 (PDT)
Received: (qmail 361 invoked by alias); 12 Apr 2002 06:21:28 -0000
Mailing-List: contact cygwin-cvs-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Unsubscribe: <mailto:cygwin-cvs-unsubscribe-mchase=ix.netcom.com@cygwin.com>
List-Subscribe: <mailto:cygwin-cvs-subscribe@cygwin.com>
List-Post: <mailto:cygwin-cvs@cygwin.com>
List-Help: <mailto:cygwin-cvs-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-cvs-owner@cygwin.com
Delivered-To: mailing list cygwin-cvs@cygwin.com
Received: (qmail 350 invoked by uid 9126); 12 Apr 2002 06:21:28 -0000
Date: 12 Apr 2002 06:21:28 -0000
Message-ID: <20020412062128.348.qmail@sources.redhat.com>
From: rbcollins@cygwin.com
To: cygwin-cvs@cygwin.com
Subject: src/winsup/cinstall ChangeLog mklink2.cc
X-SpamCop-Checked: 192.168.1.15 207.217.120.82 10.4.120.160 209.249.29.67 
Content-length: 615

CVSROOT:	/cvs/src
Module name:	src
Branch: 	setup200202
Changes by:	rbcollins@sources.redhat.com	2002-04-11 23:21:28

Modified files:
	winsup/cinstall: ChangeLog mklink2.cc 

Log message:
	2002-04-12  Robert Collins  <rbtcollins@hotmail.com>
	
	* mklink2.cc (make_link_2): Tweak to work with current w32api
	headers.

Patches:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cinstall/ChangeLog.diff?cvsroot=src&only_with_tag=setup200202&r1=2.194.2.23&r2=2.194.2.24
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cinstall/mklink2.cc.diff?cvsroot=src&only_with_tag=setup200202&r1=2.1.2.1&r2=2.1.2.2


------=_NextPart_000_0263_01C1E705.75FD93D0--
