Return-Path: <cygwin-patches-return-5377-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20046 invoked by alias); 10 Mar 2005 16:32:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19429 invoked from network); 10 Mar 2005 16:32:01 -0000
Received: from unknown (HELO mail.gmx.net) (213.165.64.20)
  by sourceware.org with SMTP; 10 Mar 2005 16:32:01 -0000
Received: (qmail invoked by alias); 10 Mar 2005 16:32:00 -0000
Received: from unknown (EHLO mordor) (213.91.247.38)
  by mail.gmx.net (mp015) with SMTP; 10 Mar 2005 17:32:00 +0100
X-Authenticated: #14308112
Date: Thu, 10 Mar 2005 16:32:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
X-X-Sender: ptsekov@mordor
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: autoload.cc: Remove unnecessary data entries from
 .dllname_info sections
In-Reply-To: <20050310144414.GC16211@gully.casa.cgf.cx>
Message-ID: <Pine.CYG.4.58.0503101828510.1208@mordor>
References: <Pine.CYG.4.58.0503101212001.1188@mordor> <20050310144414.GC16211@gully.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
X-SW-Source: 2005-q1/txt/msg00080.txt.bz2


On Thu, 10 Mar 2005, Christopher Faylor wrote:

> Thanks for the patch but I'd prefer keeping the current functionality which
> makes the use of LoadDllprime optional.

I didn't know better :(

> I've checked in a fix for this so that only one .*_info block is loaded
> for any given DLL.

Very nice! :)

Thanks!
