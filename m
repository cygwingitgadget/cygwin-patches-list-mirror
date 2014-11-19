Return-Path: <cygwin-patches-return-8033-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2660 invoked by alias); 19 Nov 2014 18:18:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2648 invoked by uid 89); 19 Nov 2014 18:18:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-lb0-f174.google.com
Received: from mail-lb0-f174.google.com (HELO mail-lb0-f174.google.com) (209.85.217.174) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 19 Nov 2014 18:18:33 +0000
Received: by mail-lb0-f174.google.com with SMTP id w7so975946lbi.5        for <cygwin-patches@cygwin.com>; Wed, 19 Nov 2014 10:18:29 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.153.7.170 with SMTP id dd10mr6779059lad.44.1416421109738; Wed, 19 Nov 2014 10:18:29 -0800 (PST)
Received: by 10.152.42.164 with HTTP; Wed, 19 Nov 2014 10:18:29 -0800 (PST)
In-Reply-To: <20141118204344.GJ3151@calimero.vinschen.de>
References: <CAE3zD3WZU8ZvqwW69f4hs+vFigShstjvh9HKuHGewXTLDsx==w@mail.gmail.com>	<20141118204344.GJ3151@calimero.vinschen.de>
Date: Wed, 19 Nov 2014 18:18:00 -0000
Message-ID: <CAE3zD3WE4ELw0eGHW=Y6Pvo+5b2ezV48UhzhdGxA+_uJXmOm=A@mail.gmail.com>
Subject: Re: Fix performance on 10Gb networks
From: Iuliu Rus <rus.iuliu@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=001a113483ae19498a05083a3dd6
X-SW-Source: 2014-q4/txt/msg00012.txt.bz2


--001a113483ae19498a05083a3dd6
Content-Type: text/plain; charset=UTF-8
Content-length: 2963

 You are right, of course. We initially thought it has to be a
multiple of page_size but it doesn't. I just re-tested with 63k and it
gives good perf too.
We get 600Mbits/second compared with 10Mb for the old default.
Attached the modified patch.

On Tue, Nov 18, 2014 at 8:43 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Hi Iuliu,
>
> On Nov 18 19:30, Iuliu Rus wrote:
>> Hello,
>> Google is running Cygwin apps on its 10Gb networks and we are seeing
>> extremely bad performance in a couple of cases. For example, iperf
>> with the defaults results in only 10Mbits/sec.
>> We tracked this down to a combination of non-blocking sockets with
>> Nagle+delayed ack kicking in, since the apps eventually end up sending
>> a very small packets (2 bytes).
>> We have a case open against Microsoft but since everything is moving
>> very slow we would like to work around by picking socket buffers that
>> are multiple of 4k.
>
> Thanks for the patch.  One question:
>
>> Change log:
>> 2014-11-18 Iuliu Rus <rus.iuliu@gmail.com>
>>
>> * net.cc Change default values for socket buffers to fix performance
>> on 10Gb networks.
>>
>> Index: winsup/cygwin/net.cc
>> ===================================================================
>> RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
>> retrieving revision 1.320
>> diff -u -p -r1.320 net.cc
>> --- winsup/cygwin/net.cc      13 Oct 2014 08:18:18 -0000      1.320
>> +++ winsup/cygwin/net.cc      18 Nov 2014 19:12:00 -0000
>> @@ -621,13 +621,16 @@ fdsock (cygheap_fdmanip& fd, const devic
>>       this is no problem on 64 bit.  So we set the default buffer size to
>>       the default values in current 3.x Linux versions.
>>
>> -     (*) Maximum normal TCP window size.  Coincidence?  */
>> +     (*) Maximum normal TCP window size.  Coincidence?
>> +
>> +     NOTE 3. Setting the window size to 65535 results in extremely
>> bad performance for apps that send data in multiples of Kb, as they
>> eventually end up sending 1 byte on the network and naggle + delay ack
>> kicks in. For example, iperf on a 10Gb network gives only 10 Mbits/sec
>> with a 65535 send buffer. We want this to be a multiple of PAGE_SIZE,
>> but since 64k breaks WSADuplicateSocket we use 60Kb.
>
> We do?  See below.
>
>> +*/
>>  #ifdef __x86_64__
>>    ((fhandler_socket *) fd)->rmem () = 212992;
>>    ((fhandler_socket *) fd)->wmem () = 212992;
>>  #else
>> -  ((fhandler_socket *) fd)->rmem () = 65535;
>> -  ((fhandler_socket *) fd)->wmem () = 65535;
>> +  ((fhandler_socket *) fd)->rmem () = 63488;
>> +  ((fhandler_socket *) fd)->wmem () = 63488;
>
> This is 62K, certainly not a multiple of the native PAGE_SIZE of 4K.
> And this makes me wonder.  Did you intend to use 60K and ended up with
> 62K for a reason?  And then, why not 63K as a multiple of 1K?
>
>
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat

--001a113483ae19498a05083a3dd6
Content-Type: application/octet-stream; name=net_patch
Content-Disposition: attachment; filename=net_patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i2p0jdxf1
Content-length: 1961

SW5kZXg6IHdpbnN1cC9jeWd3aW4vbmV0LmNjCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL25l
dC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4zMjAKZGlmZiAtdSAtcCAt
cjEuMzIwIG5ldC5jYwotLS0gd2luc3VwL2N5Z3dpbi9uZXQuY2MJMTMgT2N0
IDIwMTQgMDg6MTg6MTggLTAwMDAJMS4zMjAKKysrIHdpbnN1cC9jeWd3aW4v
bmV0LmNjCTE5IE5vdiAyMDE0IDE4OjAyOjE4IC0wMDAwCkBAIC02MjEsMTMg
KzYyMSwxNiBAQCBmZHNvY2sgKGN5Z2hlYXBfZmRtYW5pcCYgZmQsIGNvbnN0
IGRldmljCiAgICAgIHRoaXMgaXMgbm8gcHJvYmxlbSBvbiA2NCBiaXQuICBT
byB3ZSBzZXQgdGhlIGRlZmF1bHQgYnVmZmVyIHNpemUgdG8KICAgICAgdGhl
IGRlZmF1bHQgdmFsdWVzIGluIGN1cnJlbnQgMy54IExpbnV4IHZlcnNpb25z
LgogCi0gICAgICgqKSBNYXhpbXVtIG5vcm1hbCBUQ1Agd2luZG93IHNpemUu
ICBDb2luY2lkZW5jZT8gICovCisgICAgICgqKSBNYXhpbXVtIG5vcm1hbCBU
Q1Agd2luZG93IHNpemUuICBDb2luY2lkZW5jZT8gIAorCisgICAgIE5PVEUg
My4gU2V0dGluZyB0aGUgd2luZG93IHNpemUgdG8gNjU1MzUgcmVzdWx0cyBp
biBleHRyZW1lbHkgYmFkIHBlcmZvcm1hbmNlIGZvciBhcHBzIHRoYXQgc2Vu
ZCBkYXRhIGluIG11bHRpcGxlcyBvZiBLYiwgYXMgdGhleSBldmVudHVhbGx5
IGVuZCB1cCBzZW5kaW5nIDEgYnl0ZSBvbiB0aGUgbmV0d29yayBhbmQgbmFn
Z2xlICsgZGVsYXkgYWNrIGtpY2tzIGluLiBGb3IgZXhhbXBsZSwgaXBlcmYg
b24gYSAxMEdiIG5ldHdvcmsgZ2l2ZXMgb25seSAxMCBNYml0cy9zZWMgd2l0
aCBhIDY1NTM1IHNlbmQgYnVmZmVyLiBXZSB3YW50IHRoaXMgdG8gYmUgYSBt
dWx0aXBsZSBvZiAxaywgYnV0IHNpbmNlIDY0ayBicmVha3MgV1NBRHVwbGlj
YXRlU29ja2V0IHdlIHVzZSA2M0tiLgorKi8KICNpZmRlZiBfX3g4Nl82NF9f
CiAgICgoZmhhbmRsZXJfc29ja2V0ICopIGZkKS0+cm1lbSAoKSA9IDIxMjk5
MjsKICAgKChmaGFuZGxlcl9zb2NrZXQgKikgZmQpLT53bWVtICgpID0gMjEy
OTkyOwogI2Vsc2UKLSAgKChmaGFuZGxlcl9zb2NrZXQgKikgZmQpLT5ybWVt
ICgpID0gNjU1MzU7Ci0gICgoZmhhbmRsZXJfc29ja2V0ICopIGZkKS0+d21l
bSAoKSA9IDY1NTM1OworICAoKGZoYW5kbGVyX3NvY2tldCAqKSBmZCktPnJt
ZW0gKCkgPSA2NDUxMjsKKyAgKChmaGFuZGxlcl9zb2NrZXQgKikgZmQpLT53
bWVtICgpID0gNjQ1MTI7CiAjZW5kaWYKICAgaWYgKDo6c2V0c29ja29wdCAo
c29jLCBTT0xfU09DS0VULCBTT19SQ1ZCVUYsCiAJCSAgICAoY2hhciAqKSAm
KChmaGFuZGxlcl9zb2NrZXQgKikgZmQpLT5ybWVtICgpLCBzaXplb2YgKGlu
dCkpKQo=

--001a113483ae19498a05083a3dd6--
