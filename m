Return-Path: <cygwin-patches-return-7706-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13838 invoked by alias); 17 Aug 2012 08:44:32 -0000
Received: (qmail 13812 invoked by uid 22791); 17 Aug 2012 08:44:28 -0000
X-SWARE-Spam-Status: No, hits=-3.3 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS,TW_CP,TW_YG
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.187)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 17 Aug 2012 08:44:14 +0000
Received: from [10.255.169.154] ([62.159.77.186])	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)	id 0Lxdlr-1TmU472F3L-017I8z; Fri, 17 Aug 2012 10:44:12 +0200
Message-ID: <502E0451.3020609@towo.net>
Date: Fri, 17 Aug 2012 08:44:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de> <502CE384.8050709@towo.net> <20120816123033.GH17546@calimero.vinschen.de> <502D0199.6040203@towo.net> <502D10AF.1040501@redhat.com> <20120816162245.GC14163@calimero.vinschen.de>
In-Reply-To: <20120816162245.GC14163@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------020201070205010406030208"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00027.txt.bz2

This is a multi-part message in MIME format.
--------------020201070205010406030208
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1026

On 16.08.2012 18:22, Corinna Vinschen wrote:
> On Aug 16 09:24, Eric Blake wrote:
>> On 08/16/2012 08:20 AM, Thomas Wolff wrote:
>>
>>>>> MB_CUR_MAX does not work because its value is 1 at this point
>>>> So what about MB_LEN_MAX then?  There's no problem using a multiplier,
>>>> but a symbolic constant is always better than a numerical constant.
>>> I've now used _MB_LEN_MAX from newlib.h, rather than MB_LEN_MAX from
>>> limits.h (note the "_" distinction :) ),
>>> because the latter, by its preceding comment, reserves the option to be
>>> changed into a dynamic function in the future, which could then possibly
>>> have the same problems as MB_CUR_MAX.
>> POSIX requires MB_LEN_MAX to be a constant, only MB_CUR_MAX can be
>> dynamic.  We cannot change MB_LEN_MAX to be dynamic in the future.
> ...also, Cygwin's include/limits.h doesn't mention to convert to
> a function.
Not sure how to interpret exactly what it mentions. Anyway, my updated 
patch (using MB_LEN_MAX) proposes a change here as well.
------
Thomas

--------------020201070205010406030208
Content-Type: text/plain; charset=windows-1252;
 name="clipboard-small-buffer.patch.4"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="clipboard-small-buffer.patch.4"
Content-length: 4811

ZGlmZiAtcnVwIHNhdi9maGFuZGxlcl9jbGlwYm9hcmQuY2MgLi9maGFuZGxl
cl9jbGlwYm9hcmQuY2MKLS0tIHNhdi9maGFuZGxlcl9jbGlwYm9hcmQuY2MJ
MjAxMi0wNy0wOCAwMjozNjo0Ny4wMDAwMDAwMDAgKzAyMDAKKysrIC4vZmhh
bmRsZXJfY2xpcGJvYXJkLmNjCTIwMTItMDgtMTcgMTA6MzQ6NDEuOTY4NzUw
MDAwICswMjAwCkBAIC0yMjIsNiArMjIyLDcgQEAgZmhhbmRsZXJfZGV2X2Ns
aXBib2FyZDo6cmVhZCAodm9pZCAqcHRyLAogICBVSU5UIGZvcm1hdGxpc3Rb
Ml07CiAgIGludCBmb3JtYXQ7CiAgIExQVk9JRCBjYl9kYXRhOworICBpbnQg
cmFjaDsKIAogICBpZiAoIU9wZW5DbGlwYm9hcmQgKE5VTEwpKQogICAgIHsK
QEAgLTI0MywxMiArMjQ0LDI0IEBAIGZoYW5kbGVyX2Rldl9jbGlwYm9hcmQ6
OnJlYWQgKHZvaWQgKnB0ciwKICAgICAgIGN5Z2NiX3QgKmNsaXBidWYgPSAo
Y3lnY2JfdCAqKSBjYl9kYXRhOwogCiAgICAgICBpZiAocG9zIDwgY2xpcGJ1
Zi0+bGVuKQotICAgICAgCXsKKwl7CiAJICByZXQgPSAoKGxlbiA+IChjbGlw
YnVmLT5sZW4gLSBwb3MpKSA/IChjbGlwYnVmLT5sZW4gLSBwb3MpIDogbGVu
KTsKIAkgIG1lbWNweSAocHRyLCBjbGlwYnVmLT5kYXRhICsgcG9zICwgcmV0
KTsKIAkgIHBvcyArPSByZXQ7CiAJfQogICAgIH0KKyAgZWxzZSBpZiAoKHJh
Y2ggPSBnZXRfcmVhZGFoZWFkICgpKSA+PSAwKQorICAgIHsKKyAgICAgIC8q
IERlbGl2ZXIgZnJvbSByZWFkLWFoZWFkIGJ1ZmZlci4gKi8KKyAgICAgIGNo
YXIgKiBvdXRfcHRyID0gKGNoYXIgKikgcHRyOworICAgICAgKiBvdXRfcHRy
KysgPSByYWNoOworICAgICAgcmV0ID0gMTsKKyAgICAgIHdoaWxlIChyZXQg
PCBsZW4gJiYgKHJhY2ggPSBnZXRfcmVhZGFoZWFkICgpKSA+PSAwKQorCXsK
KwkgICogb3V0X3B0cisrID0gcmFjaDsKKwkgIHJldCsrOworCX0KKyAgICB9
CiAgIGVsc2UKICAgICB7CiAgICAgICB3Y2hhcl90ICpidWYgPSAod2NoYXJf
dCAqKSBjYl9kYXRhOwpAQCAtMjU2LDI1ICsyNjksNTQgQEAgZmhhbmRsZXJf
ZGV2X2NsaXBib2FyZDo6cmVhZCAodm9pZCAqcHRyLAogICAgICAgc2l6ZV90
IGdsZW4gPSBHbG9iYWxTaXplIChoZ2xiKSAvIHNpemVvZiAoV0NIQVIpIC0g
MTsKICAgICAgIGlmIChwb3MgPCBnbGVuKQogCXsKKwkgIC8qIElmIGNhbGxl
cidzIGJ1ZmZlciBpcyB0b28gc21hbGwgdG8gaG9sZCBhdCBsZWFzdCBvbmUg
CisJICAgICBtYXgtc2l6ZSBjaGFyYWN0ZXIsIHJlZGlyZWN0IGFsZ29yaXRo
bSB0byBsb2NhbCAKKwkgICAgIHJlYWQtYWhlYWQgYnVmZmVyLCBmaW5hbGx5
IGZpbGwgY2xhc3MgcmVhZC1haGVhZCBidWZmZXIgCisJICAgICB3aXRoIHJl
c3VsdCBhbmQgZmVlZCBjYWxsZXIgZnJvbSB0aGVyZS4gKi8KKwkgIGNoYXIg
KiBjb252X3B0ciA9IChjaGFyICopIHB0cjsKKwkgIHNpemVfdCBjb252X2xl
biA9IGxlbjsKKyNkZWZpbmUgY3ByYWJ1Zl9sZW4gTUJfTEVOX01BWAkvKiBt
YXggTUJfQ1VSX01BWCBvZiBhbGwgZW5jb2RpbmdzICovCisJICBjaGFyIGNw
cmFidWYgW2NwcmFidWZfbGVuXTsKKwkgIGlmIChsZW4gPCBjcHJhYnVmX2xl
bikKKwkgICAgeworCSAgICAgIGNvbnZfcHRyID0gY3ByYWJ1ZjsKKwkgICAg
ICBjb252X2xlbiA9IGNwcmFidWZfbGVuOworCSAgICB9CisKIAkgIC8qIENv
bXBhcmluZyBhcHBsZXMgYW5kIG9yYW5nZXMgaGVyZSwgYnV0IHRoZSBiZWxv
dyBsb29wIGNvdWxkIGJlY29tZQogCSAgICAgZXh0cmVtbHkgc2xvdyBvdGhl
cndpc2UuICBXZSByYXRoZXIgcmV0dXJuIGEgZmV3IGJ5dGVzIGxlc3MgdGhh
bgogCSAgICAgcG9zc2libGUgaW5zdGVhZCBvZiBiZWluZyBldmVuIG1vcmUg
c2xvdyB0aGFuIHVzdWFsLi4uICovCi0JICBpZiAoZ2xlbiA+IHBvcyArIGxl
bikKLQkgICAgZ2xlbiA9IHBvcyArIGxlbjsKKwkgIGlmIChnbGVuID4gcG9z
ICsgY29udl9sZW4pCisJICAgIGdsZW4gPSBwb3MgKyBjb252X2xlbjsKIAkg
IC8qIFRoaXMgbG9vcCBpcyBuZWNlc3NhcnkgYmVjYXVzZSB0aGUgbnVtYmVy
IG9mIGJ5dGVzIHJldHVybmVkIGJ5CiAJICAgICBzeXNfd2NzdG9tYnMgZG9l
cyBub3QgaW5kaWNhdGUgdGhlIG51bWJlciBvZiB3aWRlIGNoYXJzIHVzZWQg
Zm9yCiAJICAgICBpdCwgc28gd2UgY291bGQgcG90ZW50aWFsbHkgZHJvcCB3
aWRlIGNoYXJzLiAqLwogCSAgd2hpbGUgKChyZXQgPSBzeXNfd2NzdG9tYnMg
KE5VTEwsIDAsIGJ1ZiArIHBvcywgZ2xlbiAtIHBvcykpCiAJCSAgIT0gKHNp
emVfdCkgLTEKLQkJICYmIHJldCA+IGxlbikKKwkJICYmIChyZXQgPiBjb252
X2xlbiAKKwkJCS8qIFNraXAgc2VwYXJhdGVkIGhpZ2ggc3Vycm9nYXRlOiAq
LworCQkgICAgIHx8ICgoYnVmIFtwb3MgKyBnbGVuIC0gMV0gJiAweEZDMDAp
ID09IDB4RDgwMCAmJiBnbGVuIC0gcG9zID4gMSkpKQogCSAgICAgLS1nbGVu
OwogCSAgaWYgKHJldCA9PSAoc2l6ZV90KSAtMSkKIAkgICAgcmV0ID0gMDsK
IAkgIGVsc2UKIAkgICAgewotCSAgICAgIHJldCA9IHN5c193Y3N0b21icyAo
KGNoYXIgKikgcHRyLCAoc2l6ZV90KSAtMSwKKwkgICAgICByZXQgPSBzeXNf
d2NzdG9tYnMgKChjaGFyICopIGNvbnZfcHRyLCAoc2l6ZV90KSAtMSwKIAkJ
CQkgIGJ1ZiArIHBvcywgZ2xlbiAtIHBvcyk7CiAJICAgICAgcG9zID0gZ2xl
bjsKKwkgICAgICAvKiBJZiB1c2luZyByZWFkLWFoZWFkIGJ1ZmZlciwgY29w
eSB0byBjbGFzcyByZWFkLWFoZWFkIGJ1ZmZlcgorCSAgICAgICAgIGFuZCBk
ZWxpdmVyIGZpcnN0IGJ5dGUuICovCisJICAgICAgaWYgKGNvbnZfcHRyID09
IGNwcmFidWYpCisJCXsKKwkJICBwdXRzX3JlYWRhaGVhZCAoY3ByYWJ1Ziwg
cmV0KTsKKwkJICBjaGFyICogb3V0X3B0ciA9IChjaGFyICopIHB0cjsKKwkJ
ICByZXQgPSAwOworCQkgIHdoaWxlIChyZXQgPCBsZW4gJiYgKHJhY2ggPSBn
ZXRfcmVhZGFoZWFkICgpKSA+PSAwKQorCQkgICAgeworCQkgICAgICAqIG91
dF9wdHIrKyA9IHJhY2g7CisJCSAgICAgIHJldCsrOworCQkgICAgfQorCQl9
CiAJICAgIH0KIAl9CiAgICAgfQpkaWZmIC1ydXAgc2F2L2luY2x1ZGUvbGlt
aXRzLmggLi9pbmNsdWRlL2xpbWl0cy5oCi0tLSBzYXYvaW5jbHVkZS9saW1p
dHMuaAkyMDExLTA3LTIxIDIyOjIxOjQ5LjAwMDAwMDAwMCArMDIwMAorKysg
Li9pbmNsdWRlL2xpbWl0cy5oCTIwMTItMDgtMTYgMTc6NDg6MzQuODQ3MTQx
MTAwICswMjAwCkBAIC0zNiw4ICszNiw3IEBAIGRldGFpbHMuICovCiAKIC8q
IE1heGltdW0gbGVuZ3RoIG9mIGEgbXVsdGlieXRlIGNoYXJhY3Rlci4gICov
CiAjaWZuZGVmIE1CX0xFTl9NQVgKLS8qIFRPRE86IFRoaXMgaXMgbmV3bGli
J3MgbWF4IHZhbHVlLiAgV2Ugc2hvdWxkIHByb2JhYmx5IHJhdGhlciBkZWZp
bmUgb3VyCi0gICBvd24gX21idG93Y19yIGFuZCBfd2N0b21iX3IgZnVuY3Rp
b25zIHdoaWNoIGFyZSBvbmx5IGNvZGVwYWdlIGRlcGVuZGVudC4gKi8KKy8q
IFVzZSB2YWx1ZSBmcm9tIG5ld2xpYiBhbHRob3VnaCA0IGlzIHN1ZmZpY2ll
bnQgKi8KICNkZWZpbmUgTUJfTEVOX01BWCA4CiAjZW5kaWYKIAo=

--------------020201070205010406030208--
