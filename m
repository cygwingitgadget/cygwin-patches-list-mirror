Return-Path: <cygwin-patches-return-5113-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28236 invoked by alias); 3 Nov 2004 18:57:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28227 invoked from network); 3 Nov 2004 18:57:42 -0000
Received: from unknown (HELO smartmx-07.inode.at) (213.229.60.39)
  by sourceware.org with SMTP; 3 Nov 2004 18:57:42 -0000
Received: from [62.99.252.218] (port=62281 helo=[192.168.0.2])
	by smartmx-07.inode.at with esmtp (Exim 4.30)
	id 1CPQKE-0001V0-Cb
	for cygwin-patches@cygwin.com; Wed, 03 Nov 2004 19:57:42 +0100
Message-ID: <41892A25.3080408@x-ray.at>
Date: Wed, 03 Nov 2004 18:57:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.3) Gecko/20040910
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] kill -f
References: <3.0.5.32.20041102211220.00827d50@incoming.verizon.net> <4188CB4C.4000401@x-ray.at> <4188E7A3.305D5FAA@phumblet.no-ip.org>
In-Reply-To: <4188E7A3.305D5FAA@phumblet.no-ip.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00114.txt.bz2

Pierre A. Humblet schrieb:
> Reini Urban wrote:
>>Pierre A. Humblet schrieb:
>>
>>>This patch allows kill.exe -f to deal with Win9x pids.
>>
>>Needs the bash internal also a patch like this?
>  
> The bash internal doesn't kill Windows pids, neither on NT
> nor on 9X. I am not in favor of adding Windows specific frills
> to bash. /bin/kill is a Cygwin program,  its man page says
> that the -f switch kills Windows pids.

oops, my $(man kill) misses this interesting info.
because I didn't patch that away in my experimental coreutils.

I only remembered --force
-- 
Reini Urban
http://xarch.tu-graz.ac.at/home/rurban/
