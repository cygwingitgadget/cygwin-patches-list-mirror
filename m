Return-Path: <cygwin-patches-return-6366-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12670 invoked by alias); 29 Nov 2008 01:41:49 -0000
Received: (qmail 12660 invoked by uid 22791); 29 Nov 2008 01:41:48 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-71-97.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.71.97)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 29 Nov 2008 01:41:06 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id E150713C026 	for <cygwin-patches@cygwin.com>; Fri, 28 Nov 2008 20:40:56 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 755D96DEE92; Fri, 28 Nov 2008 20:40:56 -0500 (EST)
Date: Sat, 29 Nov 2008 01:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to Cygwin 1.7 ?
Message-ID: <20081129014056.GA19891@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de> <20081127093023.GA9487@calimero.vinschen.de> <1L5eGn-03rme80@fwd09.aul.t-online.de> <20081127111502.GF30831@calimero.vinschen.de> <492F1424.5000004@t-online.de> <20081128021554.GF16768@ednor.casa.cgf.cx> <20081128091049.GA12905@calimero.vinschen.de> <49306387.3090906@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49306387.3090906@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00010.txt.bz2

On Fri, Nov 28, 2008 at 10:32:55PM +0100, Christian Franke wrote:
>Attn maintainers:
>If package with dirent.d_type support is rebuild with new sys/dirent.h,
>it is no longer backward compatible with older Cygwin releases.  This
>is IMO no problem for packages rebuild for 1.7.

We never guarantee this so this isn't a big deal.  This happens every
time we add a new function to the DLL.

In fact, we should have bumped the api minor number in
include/cygwin/version.h.  I've just checked in a change which does
that.

cgf
