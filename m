Return-Path: <cygwin-patches-return-5111-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30178 invoked by alias); 3 Nov 2004 12:13:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30164 invoked from network); 3 Nov 2004 12:13:01 -0000
Received: from unknown (HELO smartmx-04.inode.at) (213.229.60.36)
  by sourceware.org with SMTP; 3 Nov 2004 12:13:01 -0000
Received: from [62.99.252.218] (port=62905 helo=[192.168.0.2])
	by smartmx-04.inode.at with esmtp (Exim 4.30)
	id 1CPK0b-0007IT-FK
	for cygwin-patches@cygwin.com; Wed, 03 Nov 2004 13:13:01 +0100
Message-ID: <4188CB4C.4000401@x-ray.at>
Date: Wed, 03 Nov 2004 12:13:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.3) Gecko/20040910
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] kill -f
References: <3.0.5.32.20041102211220.00827d50@incoming.verizon.net>
In-Reply-To: <3.0.5.32.20041102211220.00827d50@incoming.verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00112.txt.bz2

Pierre A. Humblet schrieb:
> This patch allows kill.exe -f to deal with Win9x pids.

Needs the bash internal also a patch like this?

> 2004-11-03  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* kill.cc (forcekill): Do not pass negative pids to 
> 	cygwin_internal.
> 	(main): Make pid a long long and distinguish between pids,
> 	gpids (i.e. negative pids) and Win9x pids.
-- 
Reini Urban
http://xarch.tu-graz.ac.at/home/rurban/
