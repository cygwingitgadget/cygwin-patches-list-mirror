Return-Path: <cygwin-patches-return-5112-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13548 invoked by alias); 3 Nov 2004 14:14:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13528 invoked from network); 3 Nov 2004 14:14:05 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 3 Nov 2004 14:14:05 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I6LWUY-00009G-8I; Wed, 03 Nov 2004 09:13:56 -0500
Message-ID: <4188E7A3.305D5FAA@phumblet.no-ip.org>
Date: Wed, 03 Nov 2004 14:14:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: Reini Urban <rurban@x-ray.at>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] kill -f
References: <3.0.5.32.20041102211220.00827d50@incoming.verizon.net> <4188CB4C.4000401@x-ray.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00113.txt.bz2



Reini Urban wrote:
> 
> Pierre A. Humblet schrieb:
> > This patch allows kill.exe -f to deal with Win9x pids.
>
> Needs the bash internal also a patch like this?
 
The bash internal doesn't kill Windows pids, neither on NT
nor on 9X. I am not in favor of adding Windows specific frills
to bash. /bin/kill is a Cygwin program,  its man page says
that the -f switch kills Windows pids.

Pierre
