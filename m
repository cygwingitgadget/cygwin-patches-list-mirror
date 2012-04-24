Return-Path: <cygwin-patches-return-7656-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22666 invoked by alias); 24 Apr 2012 21:58:52 -0000
Received: (qmail 22656 invoked by uid 22791); 24 Apr 2012 21:58:51 -0000
X-SWARE-Spam-Status: No, hits=-3.2 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.186)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 24 Apr 2012 21:58:35 +0000
Received: from [127.0.0.1] (dslb-088-073-036-239.pools.arcor-ip.net [88.73.36.239])	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)	id 0M2TGj-1S42Y800iT-00szb4; Tue, 24 Apr 2012 23:58:34 +0200
Message-ID: <4F9721F9.90109@towo.net>
Date: Tue, 24 Apr 2012 21:58:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Extended mouse coordinates
References: <4F945706.3050808@towo.net> <20120424144403.GA24364@calimero.vinschen.de> <4F970064.8020009@towo.net> <20120424194513.GV25385@calimero.vinschen.de> <20120424194753.GW25385@calimero.vinschen.de> <4F970657.4010203@towo.net> <20120424202255.GA6807@calimero.vinschen.de>
In-Reply-To: <20120424202255.GA6807@calimero.vinschen.de>
X-TagToolbar-Keys: D20120424235817472
Content-Type: multipart/mixed; boundary="------------020801020306070105000908"
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
X-SW-Source: 2012-q2/txt/msg00025.txt.bz2

This is a multi-part message in MIME format.
--------------020801020306070105000908
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1363

Am 24.04.2012 22:22, schrieb Corinna Vinschen:
> On Apr 24 22:00, Thomas Wolff wrote:
>> Am 24.04.2012 21:47, schrieb Corinna Vinschen:
>>> On Apr 24 21:45, Corinna Vinschen wrote:
>>>> That was exactly the patch I applied.  I only chnaged the formatting
>>>> and changed sprintf to  __small_sprintf.
>>> ...and as far as quoting goes, the above is the ChangeLog you provided
>>> with your updated patch.
>> Sh.. I see. My deep apologies, I must have been confused. Here is
>> the actual updated patch which should be used instead.
>> Sorry for the trouble.
>> Thomas
>> 2012-04-20  Thomas Wolff<towo@towo.net>
>>
>> 	* fhandler.h (class dev_console): Flags for extended mouse modes.
>> 	* fhandler_console.cc: Supporting mouse coordinates greater than 222.
>> 	(fhandler_console::read) Implemented extended mouse modes
>> 	1015 (urxvt, mintty, xterm), 1006 (xterm), and 1005 (xterm, mintty).
>> 	Also: two { wrap formatting consistency fixes.
>> 	(fhandler_console::mouse_aware) Removed limitation of not sending
>> 	anything at exceeded coordinates; sending 0 byte instead (xterm).
>> 	(fhandler_console::char_command) Initialization of enhanced
>> 	mouse reporting modes.
>>
> Please recreate the patch against current CVS.  And please use
> __small_sprintf instead of sprintf.
>
Here's the missing patch and changelog. Sorry again for previous mix-up.
Thomas

--------------020801020306070105000908
Content-Type: text/plain; charset=windows-1252;
 name="mouse-mode-5.changelog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mouse-mode-5.changelog"
Content-length: 354

MjAxMi0wNC0yNCAgVGhvbWFzIFdvbGZmICA8dG93b0B0b3dvLm5ldD4KCgkq
IGZoYW5kbGVyLmggKGNsYXNzIGRldl9jb25zb2xlKTogQWRkIG1lbWJlciBl
eHRfbW91c2VfbW9kZTUuCgkqIGZoYW5kbGVyX2NvbnNvbGUuY2MgKGZoYW5k
bGVyX2NvbnNvbGU6OnJlYWQpOiBJbXBsZW1lbnQgZXh0ZW5kZWQKCW1vdXNl
IG1vZGUgMTAwNSAoeHRlcm0sIG1pbnR0eSkuCglGaXggYWN0dWFsIG1vdXNl
IHJlcG9ydGluZyBmb3IgbGFyZ2UgY29vcmRpbmF0ZXMuCgo=

--------------020801020306070105000908
Content-Type: text/plain; charset=windows-1252;
 name="mouse-mode-5.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mouse-mode-5.patch"
Content-length: 3323

ZGlmZiAtcnVwIHNhdi9maGFuZGxlci5oIC4vZmhhbmRsZXIuaAotLS0gc2F2
L2ZoYW5kbGVyLmgJMjAxMi0wNC0yNCAxNjoyOTozNy4wMDAwMDAwMDAgKzAy
MDAKKysrIC4vZmhhbmRsZXIuaAkyMDEyLTA0LTI0IDIzOjQ4OjI5LjQ1MzEy
NTAwMCArMDIwMApAQCAtMTI4OCw2ICsxMjg4LDcgQEAgY2xhc3MgZGV2X2Nv
bnNvbGUKIAogICBib29sIGluc2VydF9tb2RlOwogICBpbnQgdXNlX21vdXNl
OworICBib29sIGV4dF9tb3VzZV9tb2RlNTsKICAgYm9vbCBleHRfbW91c2Vf
bW9kZTY7CiAgIGJvb2wgZXh0X21vdXNlX21vZGUxNTsKICAgYm9vbCB1c2Vf
Zm9jdXM7CmRpZmYgLXJ1cCBzYXYvZmhhbmRsZXJfY29uc29sZS5jYyAuL2Zo
YW5kbGVyX2NvbnNvbGUuY2MKLS0tIHNhdi9maGFuZGxlcl9jb25zb2xlLmNj
CTIwMTItMDQtMjQgMTY6Mzk6MjIuMDAwMDAwMDAwICswMjAwCisrKyAuL2Zo
YW5kbGVyX2NvbnNvbGUuY2MJMjAxMi0wNC0yNCAyMzo1MjowMC4yNjU2MjUw
MDAgKzAyMDAKQEAgLTMwNywxNCArMzA3LDYgQEAgZmhhbmRsZXJfY29uc29s
ZTo6bW91c2VfYXdhcmUgKE1PVVNFX0VWRQogICAgICAgcmV0dXJuIDA7CiAg
ICAgfQogCi0gIC8qIENoZWNrIHdoZXRoZXIgYWRqdXN0ZWQgbW91c2UgcG9z
aXRpb24gY2FuIGJlIHJlcG9ydGVkICovCi0gIGlmIChkZXZfc3RhdGUuZHdN
b3VzZVBvc2l0aW9uLlggPiAweEZGIC0gJyAnIC0gMQotICAgICAgfHwgZGV2
X3N0YXRlLmR3TW91c2VQb3NpdGlvbi5ZID4gMHhGRiAtICcgJyAtIDEpCi0g
ICAgewotICAgICAgLyogTW91c2UgcG9zaXRpb24gb3V0IG9mIHJlcG9ydGlu
ZyByYW5nZSAqLwotICAgICAgcmV0dXJuIDA7Ci0gICAgfQotCiAgIHJldHVy
biAoKG1vdXNlX2V2ZW50LmR3RXZlbnRGbGFncyA9PSAwIHx8IG1vdXNlX2V2
ZW50LmR3RXZlbnRGbGFncyA9PSBET1VCTEVfQ0xJQ0spCiAJICAmJiBtb3Vz
ZV9ldmVudC5kd0J1dHRvblN0YXRlICE9IGRldl9zdGF0ZS5kd0xhc3RCdXR0
b25TdGF0ZSkKIAkgfHwgbW91c2VfZXZlbnQuZHdFdmVudEZsYWdzID09IE1P
VVNFX1dIRUVMRUQKQEAgLTY0Niw3ICs2MzgsMzQgQEAgZmhhbmRsZXJfY29u
c29sZTo6cmVhZCAodm9pZCAqcHYsIHNpemVfdAogCQkJCSAgICAgZGV2X3N0
YXRlLmR3TW91c2VQb3NpdGlvbi5ZICsgMSk7CiAJCSAgICBucmVhZCA9IHN0
cmxlbiAodG1wKTsKIAkJICB9Ci0JCS8qIGVsc2UgaWYgKGRldl9zdGF0ZS5l
eHRfbW91c2VfbW9kZTUpIG5vdCBpbXBsZW1lbnRlZCAqLworCQllbHNlIGlm
IChkZXZfc3RhdGUuZXh0X21vdXNlX21vZGU1KQorCQkgIHsKKwkJICAgIHVu
c2lnbmVkIGludCB4Y29kZSA9IGRldl9zdGF0ZS5kd01vdXNlUG9zaXRpb24u
WCArICcgJyArIDE7CisJCSAgICB1bnNpZ25lZCBpbnQgeWNvZGUgPSBkZXZf
c3RhdGUuZHdNb3VzZVBvc2l0aW9uLlkgKyAnICcgKyAxOworCisJCSAgICBf
X3NtYWxsX3NwcmludGYgKHRtcCwgIlwwMzNbTSVjIiwgYiArICcgJyk7CisJ
CSAgICBucmVhZCA9IDQ7CisJCSAgICAvKiB0aGUgbmVhdCBuZXN0ZWQgZW5j
b2RpbmcgZnVuY3Rpb24gb2YgbWludHR5IAorCQkgICAgICAgZG9lcyBub3Qg
Y29tcGlsZSBpbiBnKyssIHNvIGxldCdzIHVuZm9sZCBpdDogKi8KKwkJICAg
IGlmICh4Y29kZSA8IDB4ODApCisJCSAgICAgIHRtcCBbbnJlYWQrK10gPSB4
Y29kZTsKKwkJICAgIGVsc2UgaWYgKHhjb2RlIDwgMHg4MDApCisJCSAgICAg
IHsKKwkJCXRtcCBbbnJlYWQrK10gPSAweEMwICsgKHhjb2RlID4+IDYpOwor
CQkJdG1wIFtucmVhZCsrXSA9IDB4ODAgKyAoeGNvZGUgJiAweDNGKTsKKwkJ
ICAgICAgfQorCQkgICAgZWxzZQorCQkgICAgICB0bXAgW25yZWFkKytdID0g
MDsKKwkJICAgIGlmICh5Y29kZSA8IDB4ODApCisJCSAgICAgIHRtcCBbbnJl
YWQrK10gPSB5Y29kZTsKKwkJICAgIGVsc2UgaWYgKHljb2RlIDwgMHg4MDAp
CisJCSAgICAgIHsKKwkJCXRtcCBbbnJlYWQrK10gPSAweEMwICsgKHljb2Rl
ID4+IDYpOworCQkJdG1wIFtucmVhZCsrXSA9IDB4ODAgKyAoeWNvZGUgJiAw
eDNGKTsKKwkJICAgICAgfQorCQkgICAgZWxzZQorCQkgICAgICB0bXAgW25y
ZWFkKytdID0gMDsKKwkJICB9CiAJCWVsc2UKIAkJICB7CiAJCSAgICB1bnNp
Z25lZCBpbnQgeGNvZGUgPSBkZXZfc3RhdGUuZHdNb3VzZVBvc2l0aW9uLlgg
KyAnICcgKyAxOwpAQCAtMTU2Niw3ICsxNTg1LDcgQEAgZmhhbmRsZXJfY29u
c29sZTo6Y2hhcl9jb21tYW5kIChjaGFyIGMpCiAJICBicmVhazsKIAogCWNh
c2UgMTAwNTogLyogRXh0ZW5kZWQgbW91c2UgbW9kZSAqLwotCSAgc3lzY2Fs
bF9wcmludGYgKCJpZ25vcmVkIGgvbCBjb21tYW5kIGZvciBleHRlbmRlZCBt
b3VzZSBtb2RlIik7CisJICBkZXZfc3RhdGUuZXh0X21vdXNlX21vZGU1ID0g
YyA9PSAnaCc7CiAJICBicmVhazsKIAogCWNhc2UgMTAwNjogLyogU0dSIGV4
dGVuZGVkIG1vdXNlIG1vZGUgKi8K

--------------020801020306070105000908--
