Return-Path: <cygwin-patches-return-7987-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6892 invoked by alias); 26 May 2014 07:04:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6881 invoked by uid 89); 26 May 2014 07:04:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail.lysator.liu.se
Received: from mail.lysator.liu.se (HELO mail.lysator.liu.se) (130.236.254.3) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 26 May 2014 07:04:05 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])	by mail.lysator.liu.se (Postfix) with ESMTP id 6AA9F4000A	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 09:04:01 +0200 (CEST)
Received: from [192.168.0.68] (90-227-119-221-no95.business.telia.com [90.227.119.221])	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)	by mail.lysator.liu.se (Postfix) with ESMTPSA id 4622040003	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 09:04:01 +0200 (CEST)
Message-ID: <5382E760.7@lysator.liu.se>
Date: Mon, 26 May 2014 07:04:00 -0000
From: Peter Rosin <peda@lysator.liu.se>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
References: <53811668.5010208@tiscali.co.uk>
In-Reply-To: <53811668.5010208@tiscali.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00010.txt.bz2

On 2014-05-25 00:00, David Stacey wrote:
> In function cygwin_rexec(), a pointer to local buffer 'ahostbuf' is returned through 'ahost'. However, the buffer will have been deallocated at the end of the function, and so the contents of 'ahost' will be undefined. A trivial patch (attached) fixes the problem by making 'ahostbuf' static.
> 
> This patch fixes Coverity bug ID #60028.
> 
> Change Log:
> 2014-05-24  David Stacey  <drstacey@tiscali.co.uk>
> 
>         * libc/rexec.cc (cygwin_rexec):
>         Corrected returning a pointer to a buffer that will have gone out of
>         scope.

I'm comparing with [1] and the same comment is applicable here (reading "it"
as "static").

Cheers,
Peter

[1] https://cygwin.com/viewvc/src/winsup/cygwin/libc/rcmd.cc?revision=1.8&view=markup#l134
