Return-Path: <cygwin-patches-return-4570-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1436 invoked by alias); 11 Feb 2004 14:54:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1084 invoked from network); 11 Feb 2004 14:54:03 -0000
To: <cygwin-patches@cygwin.com>
Subject: Re: Re: [PATCH] Thread safe stdio
From: =?iso-8859-1?Q?Thomas_Pfaff?= <tpfaff@gmx.net>
Message-Id: <5676191$1076510672402a3fd074a897.67662948@config8.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 5676191
X-Routing: DE
X-Received: from config8 by 129.247.190.4 with HTTP id 5676191 for cygwin-patches@cygwin.com; Wed, 11 Feb 2004 15:52:02 +0100
Content-Type: text/plain;
	charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Wed, 11 Feb 2004 14:54:00 -0000
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.135
X-SW-Source: 2004-q1/txt/msg00060.txt.bz2


Igor Pechtchanski <pechtcha@cs.nyu.edu> schrieb am 11.02.2004, 15:24:15:
> Thomas,
> 
> IMHO, include/cygwin/_types.h should be created before the below patch is
> applied, to provide continuity (otherwise the builds will be broken
> between the two patches).  Creating it earlier does no harm, AFAICS.  The
> rest of the Cygwin patch should obviously wait.
> 	Igor
> 

Igor,

include/cygwin/_types.h is part of the patch, see Changelog:

2004-02-11 Thomas Pfaff <tpfaff@gmx.net>

        * include/cygwin/_types.h: New file.


The patch for newlibs _type.h must wait until the patch for cygwin is
applied and was only included for completeness.

Thomas
