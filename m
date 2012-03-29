Return-Path: <cygwin-patches-return-7626-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27090 invoked by alias); 29 Mar 2012 03:24:57 -0000
Received: (qmail 27080 invoked by uid 22791); 29 Mar 2012 03:24:56 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_RX
X-Spam-Check-By: sourceware.org
Received: from smtp4.epfl.ch (HELO smtp4.epfl.ch) (128.178.224.218)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 29 Mar 2012 03:24:42 +0000
Received: (qmail 8305 invoked by uid 107); 29 Mar 2012 03:24:39 -0000
Received: from 76-10-162-117.dsl.teksavvy.com (HELO [192.168.0.100]) (76.10.162.117) (authenticated)  by smtp4.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 29 Mar 2012 05:24:39 +0200
Message-ID: <4F73D5F6.2060500@cs.utoronto.ca>
Date: Thu, 29 Mar 2012 03:24:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ctrl-C and non-Cygwin programs
References: <4F73CF37.4020001@elfmimi.jp>
In-Reply-To: <4F73CF37.4020001@elfmimi.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2012-q1/txt/msg00049.txt.bz2

On 28/03/2012 10:55 PM, Ein Terakawa wrote:
> Lastly first third of the patch is a workaround of a problem observed
> with cygwin1.dll of cvs HEAD.
> To reproduce:
> 1. Launch a terminal emulator like rxvt or mintty.
> 2. Execute cmd.exe or more.com from shell prompt.
> 3. Type in Enter, Ctrl-C, then Enter again.
> Whole processes including the terminal emulator will just hung up.
Interesting... I may have just hit this earlier today trying to run a
Java program inside mintty. I assumed it was just Java being weird,
since killing it releases the terminal.

I'll try to build a cygwin1.dll with the patch, but my source tree seems
to be in a bad state so it could be a while.

Ryan
