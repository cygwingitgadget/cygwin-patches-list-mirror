Return-Path: <cygwin-patches-return-8045-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26743 invoked by alias); 16 Jan 2015 14:24:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26727 invoked by uid 89); 16 Jan 2015 14:24:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-we0-f181.google.com
Received: from mail-we0-f181.google.com (HELO mail-we0-f181.google.com) (74.125.82.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Fri, 16 Jan 2015 14:24:05 +0000
Received: by mail-we0-f181.google.com with SMTP id q58so20534623wes.12        for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2015 06:24:02 -0800 (PST)
X-Received: by 10.180.126.99 with SMTP id mx3mr6852496wib.66.1421418242255;        Fri, 16 Jan 2015 06:24:02 -0800 (PST)
Received: from [192.168.67.57] (host217-40-61-57.in-addr.btopenworld.com. [217.40.61.57])        by mx.google.com with ESMTPSA id cg8sm6290598wjc.1.2015.01.16.06.24.00        for <cygwin-patches@cygwin.com>        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Fri, 16 Jan 2015 06:24:01 -0800 (PST)
Message-ID: <54B91EFD.80302@gmail.com>
Date: Fri, 16 Jan 2015 14:24:00 -0000
From: Marco Atzeri <marco.atzeri@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: tracing malloc/free call
References: <54B6EE1F.60705@gmail.com> <20150115093451.GB10242@calimero.vinschen.de>
In-Reply-To: <20150115093451.GB10242@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------040806030705020609010706"
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------040806030705020609010706
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1199

On 1/15/2015 10:34 AM, Corinna Vinschen wrote:
> Hi Marco,
>
> On Jan 14 23:30, Marco Atzeri wrote:
>> Debugging a program I am trying to catch where this call is happening
>>
>> 17 1499678 [main] ncview 1484 free: (0x6000D7961), called by 0x180115A0B
>>
>> unfortunately the 0x180115A0B address is not real caller address
>
> No, the return address is the address of the _sigbe function defined in
> the gendef script...
>
[cut]
>
> Bottom line, you should be able to fetch the original return address by
> printing the value at
>
>    *(void*)_my_tls->stackptr
>
> which points to the uppermost entry on the stack.

Hi Corinna,

in reality I found it is "*(_my_tls.stackptr-1)"

-  malloc_printf ("(%p), called by %p", p, __builtin_return_address (0));
+  malloc_printf ("(%p), called by %p", p, *(_my_tls.stackptr-1));

Attached patch that allows tracking of original caller,
for the 4 memory allocation calls.

Tested on 64 bit.

  $ grep 0x6000D6AA1 ncview.strace4
    20 1605112 [main] ncview 4408 free: (0x6000D6AA1), called by 0x10040E744


  $ addr2line.exe -a 0x10040E744 -e /usr/bin/ncview.exe
0x000000010040e744
/usr/src/debug/ncview-2.1.4-2/src/file_netcdf.c:271


Regards
Marco








--------------040806030705020609010706
Content-Type: text/plain; charset=windows-1252;
 name="malloc_wrapper.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="malloc_wrapper.patch"
Content-length: 1965

LS0tIHNyY19uZXcvd2luc3VwL2N5Z3dpbi9tYWxsb2Nfd3JhcHBlci5jYwky
MDE0LTA2LTI2IDIzOjUyOjQ2LjUzNzg0NzQwMCArMDIwMAorKysgc3JjL3dp
bnN1cC9jeWd3aW4vbWFsbG9jX3dyYXBwZXIuY2MJMjAxNS0wMS0xNiAxNDo0
MToxNS43NjYzODQ2MDAgKzAxMDAKQEAgLTE3LDYgKzE3LDcgQEAKICNpbmNs
dWRlICJkdGFibGUuaCIKICNpbmNsdWRlICJwZXJwcm9jZXNzLmgiCiAjaW5j
bHVkZSAibWlzY2Z1bmNzLmgiCisjaW5jbHVkZSAiY3lndGxzLmgiCiAjaW5j
bHVkZSAiY3lnbWFsbG9jLmgiCiAjaWZuZGVmIE1BTExPQ19ERUJVRwogI2lu
Y2x1ZGUgPG1hbGxvYy5oPgpAQCAtMzgsNyArMzksNyBAQAogZXh0ZXJuICJD
IiB2b2lkCiBmcmVlICh2b2lkICpwKQogewotICBtYWxsb2NfcHJpbnRmICgi
KCVwKSwgY2FsbGVkIGJ5ICVwIiwgcCwgX19idWlsdGluX3JldHVybl9hZGRy
ZXNzICgwKSk7CisgIG1hbGxvY19wcmludGYgKCIoJXApLCBjYWxsZWQgYnkg
JXAiLCBwLCAqKF9teV90bHMuc3RhY2twdHItMSkpOwogICBpZiAoIXVzZV9p
bnRlcm5hbCkKICAgICB1c2VyX2RhdGEtPmZyZWUgKHApOwogICBlbHNlCkBA
IC02MSw3ICs2Miw3IEBACiAgICAgICByZXMgPSBkbG1hbGxvYyAoc2l6ZSk7
CiAgICAgICBfX21hbGxvY191bmxvY2sgKCk7CiAgICAgfQotICBtYWxsb2Nf
cHJpbnRmICgiKCVsZCkgPSAlcCwgY2FsbGVkIGJ5ICVwIiwgc2l6ZSwgcmVz
LCBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MgKDApKTsKKyAgbWFsbG9jX3By
aW50ZiAoIiglbGQpID0gJXAsIGNhbGxlZCBieSAlcCIsIHNpemUsIHJlcywg
KihfbXlfdGxzLnN0YWNrcHRyLTEpKTsKICAgcmV0dXJuIHJlczsKIH0KIApA
QCAtNzcsNyArNzgsNyBAQAogICAgICAgcmVzID0gZGxyZWFsbG9jIChwLCBz
aXplKTsKICAgICAgIF9fbWFsbG9jX3VubG9jayAoKTsKICAgICB9Ci0gIG1h
bGxvY19wcmludGYgKCIoJXAsICVsZCkgPSAlcCwgY2FsbGVkIGJ5ICVwIiwg
cCwgc2l6ZSwgcmVzLCBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MgKDApKTsK
KyAgbWFsbG9jX3ByaW50ZiAoIiglcCwgJWxkKSA9ICVwLCBjYWxsZWQgYnkg
JXAiLCBwLCBzaXplLCByZXMsICooX215X3Rscy5zdGFja3B0ci0xKSk7CiAg
IHJldHVybiByZXM7CiB9CiAKQEAgLTEwNCw3ICsxMDUsNyBAQAogICAgICAg
cmVzID0gZGxjYWxsb2MgKG5tZW1iLCBzaXplKTsKICAgICAgIF9fbWFsbG9j
X3VubG9jayAoKTsKICAgICB9Ci0gIG1hbGxvY19wcmludGYgKCIoJWxkLCAl
bGQpID0gJXAsIGNhbGxlZCBieSAlcCIsIG5tZW1iLCBzaXplLCByZXMsIF9f
YnVpbHRpbl9yZXR1cm5fYWRkcmVzcyAoMCkpOworICBtYWxsb2NfcHJpbnRm
ICgiKCVsZCwgJWxkKSA9ICVwLCBjYWxsZWQgYnkgJXAiLCBubWVtYiwgc2l6
ZSwgcmVzLCAqKF9teV90bHMuc3RhY2twdHItMSkpOwogICByZXR1cm4gcmVz
OwogfQogCg==

--------------040806030705020609010706--
