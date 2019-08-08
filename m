Return-Path: <cygwin-patches-return-9554-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86907 invoked by alias); 8 Aug 2019 11:01:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86874 invoked by uid 89); 8 Aug 2019 11:01:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Aug 2019 11:01:42 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 13:01:40 +0200
Received: from fril0049.wamas.com ([172.28.42.244])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hvgAt-0001ht-8z; Thu, 08 Aug 2019 13:01:39 +0200
Subject: Re: [PATCH] Cygwin: shmat: use mmap allocator strategy on 64 bit
To: cygwin-patches@cygwin.com
References: <20190808085527.29002-1-corinna-cygwin@cygwin.com>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <b0a2a855-9796-68c5-cca6-6c8d01859e81@ssi-schaefer.com>
Date: Thu, 08 Aug 2019 11:01:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808085527.29002-1-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q3/txt/msg00074.txt.bz2

On 8/8/19 10:55 AM, corinna-cygwin@cygwin.com wrote:
> From: Corinna Vinschen <corinna-cygwin@cygwin.com>
> 
> This avoids collisions of shmat maps with Windows own datastructures
> when allocating top-down.
> 
> This patch moves the mmap_allocator class definition into its
> own files and just uses it from mmap and shmat.

Confirmed to work Server 2012r2 and 2019.

/haubi/
