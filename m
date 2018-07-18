Return-Path: <cygwin-patches-return-9125-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97304 invoked by alias); 18 Jul 2018 05:30:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97137 invoked by uid 89); 18 Jul 2018 05:30:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=personal
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Jul 2018 05:29:59 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6I5Tweh080593	for <cygwin-patches@cygwin.com>; Tue, 17 Jul 2018 22:29:58 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdQmEOpD; Tue Jul 17 22:29:57 2018
Subject: Re: [PATCH v3 2/3] POSIX Asynchronous I/O support: fhandler files
To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-3-mark@maxrnd.com> <20180716142733.GA27673@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <3d913fa1-ac43-a632-8411-007e939595d5@maxrnd.com>
Date: Wed, 18 Jul 2018 05:30:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20180716142733.GA27673@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00020.txt.bz2

Corinna Vinschen wrote:
> On Jul 15 01:20, Mark Geisert wrote:
>> +      if (aio)
>> +	status = NtReadFile (prw_handle, aiocb->aio_win_event, NULL, NULL,
>> +			     &aiocb->aio_win_iosb, buf, count, &off, NULL);
>> +      else
>> +	status = NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,
>> +			     &off, NULL);
>
> Ok, this is a very personal style issue, but I don't like to see the same
> function called just with slightly different parameters in an if/else.
> Would you mind terribly to rewrite this kind of like
>
>   HANDLE evt = aio ? aiocb->aio_win_event : NULL;
>   PIO_STATUS_BLOCK pio = aio ? &aiocb->aio_win_iosb : NULL;
>
>   [...]
>
>   status = NtReadFile (prw_handle, evt, NULL, NULL, pio, buf, count,
> 		       &off, NULL);
>
> ?

I agree your code is more readable and maintainable.  I plead excess reverence 
for the original code :-().  All three locations have now been re-coded in the 
improved manner.

..mark
