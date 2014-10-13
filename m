Return-Path: <cygwin-patches-return-8028-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32460 invoked by alias); 13 Oct 2014 05:38:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32445 invoked by uid 89); 13 Oct 2014 05:38:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mailout04.t-online.de
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 13 Oct 2014 05:38:09 +0000
Received: from fwd22.aul.t-online.de (fwd22.aul.t-online.de [172.20.26.127])	by mailout04.t-online.de (Postfix) with SMTP id 327C51E5E44	for <cygwin-patches@cygwin.com>; Mon, 13 Oct 2014 07:38:05 +0200 (CEST)
Received: from [192.168.2.108] (E6+mgmZCQhYTKUGfo1gpCcPcmoDf59StbK+D3wvXBQqTa47rK8VH5cNuWGQfE4UZ-m@[84.180.68.154]) by fwd22.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1XdYKR-28xyF60; Mon, 13 Oct 2014 07:37:55 +0200
Message-ID: <543B6533.807@t-online.de>
Date: Mon, 13 Oct 2014 05:38:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0 SeaMonkey/2.26.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de> <5436D241.3070104@t-online.de> <20141010110752.GA14455@calimero.vinschen.de> <54380B0E.7020803@t-online.de> <20141010180429.GO2681@calimero.vinschen.de> <20141011183644.GS2681@calimero.vinschen.de>
In-Reply-To: <20141011183644.GS2681@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00007.txt.bz2

Corinna Vinschen wrote:
> On Oct 10 20:04, Corinna Vinschen wrote:
>> On Oct 10 18:36, Christian Franke wrote:
>>> After a nonblocking connect(), postfix calls poll() with pollfd.events =
>>> POLLIN only. If poll() succeeds, it calls recv(). This fails with ENOTCONN
>>> because the state is still connect_pending.
>> Oh.  So it doesn't check if the connect succeeded?  Does it check the
>> poll result for POLLERR or does it explicitely check for revents==POLLIN?
>>
>> Hmm.
>>
>> [...time passes...]
>>
>> It looks like you catched a long-standing bug here.
>>
>> This isn't even AF_LOCAL specific.  The original comment in the
>> write_selected branch is misleading: The AF_LOCAL specific part is just
>> the call to af_local_connect, not setting the connect_state.  There was
>> a previous, longer comment at one point which I shortened for no good
>> reason in 2005:
>>
>>    /* eid credential transaction on successful non-blocking connect.
>>       Since the read bit indicates an error, don't start transaction
>>       if it's set. */
>>
>> However, If I'm not completely mistaken, your patch would only work in
>> the aforementioned scenario if setsockopt(SO_PEERCRED) has been called.
>> Otherwise the handshake would be skipped on the connect side and thus
>> the handshake would fail on the server side.  There's also the problem
>> that read_ready may indicate an error.  And POLLERR is only set if the
>> socket is polled for POLLOUT so a failing connect would go unnoticed.
>>
>> In short, the whole code is written under the assumption that any sane
>> application calling nonblocking connect would always call select/poll to
>> check if connect succeeded in the first place.  Obviously, as postfix
>> shows, this is a wrong assumption.
>>
>> I'm not yet sure how to fix this, but I'll look into this next week.
> I applied a fix which, I think, is much more elegant than the former
> solution.  The af_local_connect call is now called as soon as an
> FD_CONNECT event is generated and read by a call to wait_event.  It
> worked for me, so I have tender hopes that I didn't miss something.
>
> I also applied your patch on top of this new stuff and I'm just building
> a new developer snapshot for testing.

A quick test of current postfix draft with the snapshot works as 
expected. Thanks.


>    In setsockopt I added a check for
> socket family and type so setsockopt(SO_PEERCRED) only works for
> AF_LOCAL/SOCK_STREAM sockets, just as the entire handshake stuff.

Probably not needed because this check was already in 
af_local_set_no_getpeereid() itself.


>    I
> also added a comment to explain why we do this and a FIXME comment so we
> don't forget we're still looking for a more generic solution for the
> SO_PEERCRED exchange.

Definitely, at least because the current AF_LOCAL emulation has some 
security issues.

Thanks,
Christian
