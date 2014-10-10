Return-Path: <cygwin-patches-return-8025-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22546 invoked by alias); 10 Oct 2014 16:36:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22532 invoked by uid 89); 10 Oct 2014 16:36:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mailout09.t-online.de
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 10 Oct 2014 16:36:35 +0000
Received: from fwd33.aul.t-online.de (fwd33.aul.t-online.de [172.20.27.144])	by mailout09.t-online.de (Postfix) with SMTP id BE51A2ED941	for <cygwin-patches@cygwin.com>; Fri, 10 Oct 2014 18:36:31 +0200 (CEST)
Received: from [192.168.2.108] (rxSeUeZQ8huC2v0P0khAPE3knw9fqWpj4tMbDDU4ycOKCIfsRrYma0YatYjPYH4giE@[84.180.87.107]) by fwd33.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1XcdB9-0IHTay0; Fri, 10 Oct 2014 18:36:31 +0200
Message-ID: <54380B0E.7020803@t-online.de>
Date: Fri, 10 Oct 2014 16:36:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0 SeaMonkey/2.26.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de> <5436D241.3070104@t-online.de> <20141010110752.GA14455@calimero.vinschen.de>
In-Reply-To: <20141010110752.GA14455@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00004.txt.bz2

Corinna Vinschen wrote:
> I was just looking into applying your patch when I got thinking over the
> change in select.cc once more.  You're setting the connect_state from
> connect_pending to connected there when there's something to read on the
> socket.
>
> This puzzles me.  A completed connection attempt should set the
> write_selected flag (see function peek_socket).

No, peek_socket() does not change write_selected. It sets write_read if 
write_selected is set.


>    The AF_LOCAL handling
> in the
>
>    if (me->write_selected && me->write_ready)
>
> case in set_bits should cover this.  What situation is your special case
> covering which is not already covered by the write_selected case?

If only read status is requested via select()/poll(), write_selected is 
always false and the connect_pending=>connected transition is never done.

After a nonblocking connect(), postfix calls poll() with pollfd.events = 
POLLIN only. If poll() succeeds, it calls recv(). This fails with 
ENOTCONN because the state is still connect_pending.

Christian
