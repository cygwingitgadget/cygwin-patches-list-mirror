Return-Path: <cygwin-patches-return-6374-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31346 invoked by alias); 7 Dec 2008 17:17:01 -0000
Received: (qmail 31332 invoked by uid 22791); 7 Dec 2008 17:17:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 07 Dec 2008 17:16:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 99FA16D4356; Sun,  7 Dec 2008 18:18:02 +0100 (CET)
Date: Sun, 07 Dec 2008 17:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash  find)
Message-ID: <20081207171802.GV12905@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4939A9F7.1000400@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00018.txt.bz2

Hi Christian,

On Dec  5 23:23, Christian Franke wrote:
> Corinna Vinschen wrote:
>> Maybe ".val" is already a good suffix?
>
> I would prefer "%val" to avoid any extra encoding for names using ".val". 
> The "%" is already used as an escape char, so "%val" in a name would appear 
> as "%25val"

Very good idea!

> With the attached patch, a duplicate name "foo" is handled as follows:
>
> - readdir() returns the key as "foo" and the value as "foo%val".
> - If the name is "foo%val", stat() and open() consider only the value 
> "foo".
>
> This keeps the names 'as is' if possible and allows access to the (very 
> few) entries with duplicate names. The "%val" is at least somewhat 
> self-explanatory.

Cool.  Can you please send a ChangeLog entry as well?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
