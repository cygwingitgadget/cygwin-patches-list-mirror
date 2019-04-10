Return-Path: <cygwin-patches-return-9319-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27420 invoked by alias); 10 Apr 2019 12:32:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27407 invoked by uid 89); 10 Apr 2019 12:32:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Envelope-From:sk:michael
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Apr 2019 12:32:52 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 14:32:50 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hECPJ-0000cg-8k; Wed, 10 Apr 2019 14:32:49 +0200
Subject: Re: [rebase PATCH] Introduce --with-posix-shell configure flag.
References: <65e46d68-33be-bfea-dfd2-756812ac3472@ssi-schaefer.com> <20190410090237.GF4248@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <d4cfd98d-c9a2-3185-d2f2-c8c3c68a9345@ssi-schaefer.com>
Date: Wed, 10 Apr 2019 12:32:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410090237.GF4248@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00026.txt.bz2

On 4/10/19 11:02 AM, Corinna Vinschen wrote:
> On Apr  9 11:23, Michael Haubenwallner wrote:
>> Some distros prefer a POSIX shell other than /bin/ash and /bin/dash.
> 
> I think this is pretty old stuff nobody really looked at for a while.
> ash and dash are the same binary anyway, both are dash.

Patch updated.

> 
> I'd prefer to drop the distinction between ash and dash, so dash
> is default and --with-dash becomes a no-op.
> 
> Also, why not just SHELL?

The variable SHELL does have meanings to the system() call,
and may not necessarily denote a POSIX compatible shell.

Thanks!
/haubi/
