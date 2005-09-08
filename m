Return-Path: <cygwin-patches-return-5645-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15909 invoked by alias); 8 Sep 2005 09:25:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15820 invoked by uid 22791); 8 Sep 2005 09:25:02 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 08 Sep 2005 09:25:02 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id C4685245CD
	for <cygwin-patches@cygwin.com>; Thu,  8 Sep 2005 11:24:59 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id A275AD6502
	for <cygwin-patches@cygwin.com>; Thu,  8 Sep 2005 11:24:58 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6CCEF544122; Thu,  8 Sep 2005 11:24:58 +0200 (CEST)
Date: Thu, 08 Sep 2005 09:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Don't append extra NUL to registry-strings.
Message-ID: <20050908092458.GA9966@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.dfddna.3vvbaub.1@buzzy-box.bavag> <SERRANOF2fPmsSVhGOD000000e6@SERRANO.CAM.ARTIMI.COM> <n2m-g.dfnqh4.3vv7psd.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.dfnqh4.3vv7psd.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00100.txt.bz2

On Sep  7 23:27, Bas van Gompel wrote:
> 2005-09-07  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
> 
> 	* regtool.cc: Extend copyright-years.
> 	(print_version): Ditto.
> 	(cmd_list): Don't depend on terminating '\0' being present on
> 	string-values.
> 	(cmd_get): Don't attempt to read more than present, but keep
> 	extra space for terminating '\0'. Really output REG_BINARY.
> 	Don't leak memory.
> 	(cmd_set): Include trailing '\0' in string's length.

Applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
