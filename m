Return-Path: <cygwin-patches-return-6413-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15738 invoked by alias); 25 Feb 2009 02:33:45 -0000
Received: (qmail 15724 invoked by uid 22791); 25 Feb 2009 02:33:45 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-111.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.111)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 25 Feb 2009 02:33:38 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id BA77313C026; 	Tue, 24 Feb 2009 21:33:27 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id AF9032B35E; Tue, 24 Feb 2009 21:33:27 -0500 (EST)
Date: Wed, 25 Feb 2009 02:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com, mingw-users@lists.sourceforge.net
Subject: Re: [PATCH] w32api fixes commctrl.h listview
Message-ID: <20090225023327.GA18395@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, 	mingw-users@lists.sourceforge.net
References: <83b27df30902241538m1aa5b85bh8e7ebee11e11ece6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b27df30902241538m1aa5b85bh8e7ebee11e11ece6@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00011.txt.bz2

On Tue, Feb 24, 2009 at 03:38:56PM -0800, Michael James wrote:
>A simple patch. My application was misbehaving only when built with
>mingw. It turned out that this incorrect header value was at fault. I
>am also submitting this patch to the mingw patch tracker on
>sourceforge.
>
>Does anyone have an estimate on how long these patches take to be
>incorporated into the main repository?

FYI, you don't have to cc w32api patches to cygwin-patches.  They are handled
by the MinGW team.

cgf
