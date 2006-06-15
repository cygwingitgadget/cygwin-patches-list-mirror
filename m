Return-Path: <cygwin-patches-return-5896-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1876 invoked by alias); 15 Jun 2006 16:08:00 -0000
Received: (qmail 1865 invoked by uid 22791); 15 Jun 2006 16:07:59 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.181)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 15 Jun 2006 16:07:56 +0000
Received: by py-out-1112.google.com with SMTP id i75so340072pye         for <cygwin-patches@cygwin.com>; Thu, 15 Jun 2006 09:07:54 -0700 (PDT)
Received: by 10.35.135.12 with SMTP id m12mr3195498pyn;         Thu, 15 Jun 2006 09:07:54 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Thu, 15 Jun 2006 09:07:54 -0700 (PDT)
Message-ID: <ba40711f0606150907x9fb33efy463582520fa300f0@mail.gmail.com>
Date: Thu, 15 Jun 2006 16:08:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
In-Reply-To: <20060613155208.GO16683@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_1076_3639178.1150387674363"
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> 	 <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM> 	 <20060612131046.GC2129@calimero.vinschen.de> 	 <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com> 	 <ba40711f0606121959g2a1acf17g5e6963e811676f71@mail.gmail.com> 	 <20060613083243.GC16683@calimero.vinschen.de> 	 <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com> 	 <ba40711f0606130847mba77fd5h84f329096fdbf847@mail.gmail.com> 	 <20060613155208.GO16683@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00084.txt.bz2


------=_Part_1076_3639178.1150387674363
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 1539

On 6/13/06, Corinna Vinschen wrote:
> On Jun 13 11:47, Lev Bishop wrote:

> > It seems it's hanging in fhandler_socket::close(), when the child
> > process closes the listening socket.
>
> Hanging?  Or looping endlessly with WSAEWOULDBLOCK?

Actually, it's very strange. It gets stuck on the setsockopt() in
fhandler_socket::close(). There's a race with the parent (which is why
it didn't happen under strace or sshd -d), but if the parent gets
round to doing its select() before the child does the close(), then
the setsockopt() does not return until after the select() returns. I
attach a short testcase which reliably demonstrates the problem for
me. It doesn't use privilege separation or non-blocking sockets, so
that is not the problem. I haven't investigated whether it's something
to do with the way the socket is duplicated into the child
(WSADuplicateSocket() versus DuplicateHandle(), and such).

Just to spell it out: the problem shown in my testcase, is only
exibited with overlapped sockets. Non-overlapped don't have any
problem. Which is strange to me, since MSDN makes no mention of
situations where setsockopt() can block.

>  Any change when not
> setting the linger option, maybe?

Well, yes, because then there's no setsockopt() call to block on, but
it doesn't really solve the problem, because now if the user code
calls setsockopt() it will still unexpectedly block.

I think that's as far as I'm going to go with persuing this issue. If
I need native programs to use sockets, then I'll pipe them through
socat.

L

------=_Part_1076_3639178.1150387674363
Content-Type: text/plain; name=fork.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eohb2m02
Content-Disposition: attachment; filename="fork.c"
Content-length: 1420

I2luY2x1ZGUgPG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPGVyci5oPgojaW5j
bHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKaW50Cm1haW4o
dm9pZCkKewogIHN0cnVjdCBzb2NrYWRkcl9pbiBsYWRkcj0KICAgIHsuc2lu
X2ZhbWlseT1BRl9JTkVULCAuc2luX3BvcnQ9aHRvbnMoNTAwMSksIC5zaW5f
YWRkcj17SU5BRERSX0FOWX19OwogIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdl
IGFkZHI7CiAgaW50IHNrdCxhbGVuPXNpemVvZihhZGRyKTsKICBmZF9zZXQg
cix3LGU7CiAgc3RydWN0IHRpbWV2YWwgdG87CgogIGlmICgtMT09KHNrdD1z
b2NrZXQoQUZfSU5FVCxTT0NLX1NUUkVBTSxJUFBST1RPX1RDUCkpKWVycigx
LCJvcGVuaW5nIik7CiAgaWYgKC0xPT1iaW5kKHNrdCwoc3RydWN0IHNvY2th
ZGRyKikmbGFkZHIsc2l6ZW9mKGxhZGRyKSkpZXJyKDEsImJpbmQiKTsKICBm
cHJpbnRmKHN0ZGVyciwiTGlzdGVuaW5nLi4uLlxuIik7CiAgaWYgKC0xPT1s
aXN0ZW4oc2t0LDEpKWVycigxLCJsaXN0ZW4iKTsKICBzd2l0Y2goZm9yaygp
KXsKICBjYXNlIC0xOiBlcnIoMSwiZm9yayIpOwogIGNhc2UgMDoKICAgIHNs
ZWVwKDEpOyAvLyBFbnN1cmUgcGFyZW50IHdpbnMgdGhlIHJhY2UuCiAgICBm
cHJpbnRmKHN0ZGVyciwiY2xvc2luZy4uLlxuIik7CiAgICBjbG9zZShza3Qp
OyAvLyBibG9jayBoZXJlIHVudGlsIHBhcmVudCByZXR1cm5zIGZyb20gc2Vs
ZWN0KCkKICAgIGZwcmludGYoc3RkZXJyLCJjbG9zZWRcbiIpOwogICAgcmV0
dXJuIDA7CiAgZGVmYXVsdDoKICAgIEZEX1pFUk8oJnIpOwogICAgRkRfWkVS
Tygmdyk7CiAgICBGRF9aRVJPKCZlKTsKICAgIHRvLnR2X3NlYz0xMDsKICAg
IHRvLnR2X3VzZWM9MDsKICAgIEZEX1NFVChza3QsJnIpOwogICAgZnByaW50
ZihzdGRlcnIsInNlbGVjdGluZy4uLlxuIik7CiAgICBpZigtMT09KHM9c2Vs
ZWN0KHNrdCsxLCZyLCZ3LCZlLCZ0bykpKWVycigxLCJzZWxlY3QiKTsKICAg
IGZwcmludGYoc3RkZXJyLCJzZWxlY3RlZFxuIik7CiAgICB9CiAgfQogIHJl
dHVybiAwOwp9Cg==

------=_Part_1076_3639178.1150387674363--
