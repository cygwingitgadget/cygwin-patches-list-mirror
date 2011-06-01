Return-Path: <cygwin-patches-return-7419-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9457 invoked by alias); 1 Jun 2011 16:38:51 -0000
Received: (qmail 9447 invoked by uid 22791); 1 Jun 2011 16:38:51 -0000
X-SWARE-Spam-Status: No, hits=0.2 required=5.0	tests=AWL,BAYES_00,TW_CG,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from anoid.noid.net (HELO anoid.noid.net) (74.95.194.161)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 01 Jun 2011 16:38:37 +0000
Received: from 192.168.127.127	by mx.noid.net (GNU) id p51GcasH000040; Wed, 1 Jun 2011 09:38:36 -0700 (PDT)
X-Mini-Diatribe: To fix America:	1. Cut government in half	2. Wait thirty years	3. Repeat as necessary
Received: by scythe.noid.net (Postfix, from userid 0)	id 91E5A1ED73ED; Wed,  1 Jun 2011 09:38:36 -0700 (PDT)
From: Tor Perkins <cygwin@noid.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] tcsetpgrp fails unexpectedly
In-Reply-To: <20110530065904.GA6348@ednor.casa.cgf.cx>
Message-Id: <20110601163836.91E5A1ED73ED@scythe.noid.net>
Date: Wed, 01 Jun 2011 16:38:00 -0000
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00185.txt.bz2

On Mon, May 30, 2011 at 02:59:04AM -0400, Christopher Faylor wrote:
> On Mon, Apr 04, 2011 at 09:45:09AM -0700, Tor Perkins wrote:
> >2011-03-28  Tor Perkins
> >
> >  * fhandler_termios.cc (fhandler_termios::bg_check): Do not return EIO
> >  when a process group has no leader as this is allowed and does not imply
> >  an orphaned process group.  Add a test for orphaned process groups.
>
> I've checked this in and added missing pieces to the ChangeLog.
>
> Thanks for the patch and apologies for the long delay.
>
> cgf

That's great; thanks for accepting it!   - Tor
