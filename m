Return-Path: <cygwin-patches-return-8023-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26761 invoked by alias); 9 Oct 2014 18:22:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26748 invoked by uid 89); 9 Oct 2014 18:22:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mailout09.t-online.de
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 09 Oct 2014 18:22:05 +0000
Received: from fwd13.aul.t-online.de (fwd13.aul.t-online.de [172.20.27.62])	by mailout09.t-online.de (Postfix) with SMTP id 0191C41F6B8	for <cygwin-patches@cygwin.com>; Thu,  9 Oct 2014 20:22:02 +0200 (CEST)
Received: from [192.168.2.108] (ZYk0BrZCoh6Envf7CBYaXj5wDU3gecjJ5jPpveab-7P6so1vV-1GgOURCloP41EQpN@[84.180.85.141]) by fwd13.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1XcILb-4Cu71c0; Thu, 9 Oct 2014 20:21:55 +0200
Message-ID: <5436D241.3070104@t-online.de>
Date: Thu, 09 Oct 2014 18:22:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0 SeaMonkey/2.26.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de>
In-Reply-To: <20141009175956.GF2681@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00002.txt.bz2

Corinna Vinschen wrote:
>> +int
>> +fhandler_socket::af_local_set_no_getpeereid ()
>> +{
>> +  if (get_addr_family () != AF_LOCAL || get_socket_type () != SOCK_STREAM)
>> +    {
>> +      set_errno (EINVAL);
>> +      return -1;
>> +    }
>> +  if (connect_state () != unconnected)
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
>
> Wouldn't it make sense to allow this call in the "listener" state as well?

It should work, but I don't see any real world use case.

Christian
