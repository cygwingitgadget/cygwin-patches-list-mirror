Return-Path: <cygwin-patches-return-7654-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12911 invoked by alias); 24 Apr 2012 20:00:30 -0000
Received: (qmail 12891 invoked by uid 22791); 24 Apr 2012 20:00:28 -0000
X-SWARE-Spam-Status: No, hits=-3.1 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS,TW_CP,TW_RX
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.10)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 24 Apr 2012 20:00:14 +0000
Received: from [127.0.0.1] (dslb-088-073-036-239.pools.arcor-ip.net [88.73.36.239])	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)	id 0LlEiU-1Rm3Vl3zNO-00b2EE; Tue, 24 Apr 2012 22:00:12 +0200
Message-ID: <4F970657.4010203@towo.net>
Date: Tue, 24 Apr 2012 20:00:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Extended mouse coordinates
References: <4F945706.3050808@towo.net> <20120424144403.GA24364@calimero.vinschen.de> <4F970064.8020009@towo.net> <20120424194513.GV25385@calimero.vinschen.de> <20120424194753.GW25385@calimero.vinschen.de>
In-Reply-To: <20120424194753.GW25385@calimero.vinschen.de>
X-TagToolbar-Keys: D20120424220023013
Content-Type: multipart/mixed; boundary="------------060304020504010202000309"
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
X-SW-Source: 2012-q2/txt/msg00023.txt.bz2

This is a multi-part message in MIME format.
--------------060304020504010202000309
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2294

Am 24.04.2012 21:47, schrieb Corinna Vinschen:
> On Apr 24 21:45, Corinna Vinschen wrote:
>> On Apr 24 21:35, Thomas Wolff wrote:
>>> Am 24.04.2012 16:44, schrieb Corinna Vinschen:
>>>> On Apr 22 21:07, Thomas Wolff wrote:
>>>>> This patch replaces my previous proposal
>>>>> (http://cygwin.com/ml/cygwin-patches/2012-q2/msg00005.html) with two
>>>>> modifications:
>>>>>
>>>>>   * Fixed a bug that suppressed mouse reporting at large coordinates (in
>>>>>     all modes actually:-\ )
>>>>>   * Added mouse mode 1005 (total of 3 three new modes, so all reporting
>>>>>     modes run by current terminal emulators would be implemented)
>>>>>
>>>>> I would appreciate the patch to be applied this time, planned to be
>>>>> my last mouse patch :)
>>>>>
>>>>> Kind regards,
>>>>> Thomas
>>>>> 2012-04-03  Thomas Wolff<towo@towo.net>
>>>>>
>>>>> 	* fhandler.h (class dev_console): Two flags for extended mouse modes.
>>>>> 	* fhandler_console.cc (fhandler_console::read): Implemented
>>>>> 	extended mouse modes 1015 (urxvt, mintty, xterm) and 1006 (xterm).
>>>>> 	Not implemented extended mouse mode 1005 (xterm, mintty).
>>>>> 	Supporting mouse coordinates greater than 222 (each axis).
>>>>> 	Also: two { wrap formatting consistency fixes.
>>>>> 	(fhandler_console::char_command) Initialization of enhanced
>>>>> 	mouse reporting modes.
>>>>>
>>>> Patch applied with changes.  Please use __small_sprintf rather than
>>>> sprintf.  I also changed the CHangeLog entry slightly.  Keep it short
>>>> and in present tense.
>>>>
>>>>
>>>> Thanks,
>>>> Corinna
>>>>
>>> Hmm, thanks but I'm afraid this went wrong. You quote (and probably
>>> applied) my first patch which is missing mouse mode 1005 and
>>> unfortunately also has a bug which effectively makes the extended
>>> coordinates unusable (because the reports are suppressed in that
>>> case as they were before :( ).
>>> The mail you responded to contained an updated patch.
>> That was exactly the patch I applied.  I only chnaged the formatting
>> and changed sprintf to  __small_sprintf.
> ...and as far as quoting goes, the above is the ChangeLog you provided
> with your updated patch.
Sh.. I see. My deep apologies, I must have been confused. Here is the 
actual updated patch which should be used instead.
Sorry for the trouble.
Thomas

--------------060304020504010202000309
Content-Type: text/plain; charset=windows-1252;
 name="mouse-modes-5-6-16.changelog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mouse-modes-5-6-16.changelog"
Content-length: 789

MjAxMi0wNC0yMCAgVGhvbWFzIFdvbGZmICA8dG93b0B0b3dvLm5ldD4KCgkq
IGZoYW5kbGVyLmggKGNsYXNzIGRldl9jb25zb2xlKTogRmxhZ3MgZm9yIGV4
dGVuZGVkIG1vdXNlIG1vZGVzLgoJKiBmaGFuZGxlcl9jb25zb2xlLmNjOiBT
dXBwb3J0aW5nIG1vdXNlIGNvb3JkaW5hdGVzIGdyZWF0ZXIgdGhhbiAyMjIu
CgkoZmhhbmRsZXJfY29uc29sZTo6cmVhZCkgSW1wbGVtZW50ZWQgZXh0ZW5k
ZWQgbW91c2UgbW9kZXMgCgkxMDE1ICh1cnh2dCwgbWludHR5LCB4dGVybSks
IDEwMDYgKHh0ZXJtKSwgYW5kIDEwMDUgKHh0ZXJtLCBtaW50dHkpLgoJQWxz
bzogdHdvIHsgd3JhcCBmb3JtYXR0aW5nIGNvbnNpc3RlbmN5IGZpeGVzLgoJ
KGZoYW5kbGVyX2NvbnNvbGU6Om1vdXNlX2F3YXJlKSBSZW1vdmVkIGxpbWl0
YXRpb24gb2Ygbm90IHNlbmRpbmcgCglhbnl0aGluZyBhdCBleGNlZWRlZCBj
b29yZGluYXRlczsgc2VuZGluZyAwIGJ5dGUgaW5zdGVhZCAoeHRlcm0pLgoJ
KGZoYW5kbGVyX2NvbnNvbGU6OmNoYXJfY29tbWFuZCkgSW5pdGlhbGl6YXRp
b24gb2YgZW5oYW5jZWQgCgltb3VzZSByZXBvcnRpbmcgbW9kZXMuCgo=

--------------060304020504010202000309
Content-Type: text/plain; charset=windows-1252;
 name="mouse-modes-5-6-16.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mouse-modes-5-6-16.patch"
Content-length: 8231

ZGlmZiAtcnVwIHNhdi9maGFuZGxlci5oIC4vZmhhbmRsZXIuaAotLS0gc2F2
L2ZoYW5kbGVyLmgJMjAxMi0wNC0xOCAwNzo1ODowNC4wMDAwMDAwMDAgKzAy
MDAKKysrIC4vZmhhbmRsZXIuaAkyMDEyLTA0LTIwIDEzOjU5OjAyLjI2NTMy
ODgwMCArMDIwMApAQCAtMTI4OCw2ICsxMjg4LDkgQEAgY2xhc3MgZGV2X2Nv
bnNvbGUKIAogICBib29sIGluc2VydF9tb2RlOwogICBpbnQgdXNlX21vdXNl
OworICBib29sIGV4dF9tb3VzZV9tb2RlNTsKKyAgYm9vbCBleHRfbW91c2Vf
bW9kZTY7CisgIGJvb2wgZXh0X21vdXNlX21vZGUxNTsKICAgYm9vbCB1c2Vf
Zm9jdXM7CiAgIGJvb2wgcmF3X3dpbjMyX2tleWJvYXJkX21vZGU7CiAKZGlm
ZiAtcnVwIHNhdi9maGFuZGxlcl9jb25zb2xlLmNjIC4vZmhhbmRsZXJfY29u
c29sZS5jYwotLS0gc2F2L2ZoYW5kbGVyX2NvbnNvbGUuY2MJMjAxMi0wNC0x
NSAxOTo1MTo0OS4wMDAwMDAwMDAgKzAyMDAKKysrIC4vZmhhbmRsZXJfY29u
c29sZS5jYwkyMDEyLTA0LTIwIDEzOjU5OjAyLjI5NjU3OTIwMCArMDIwMApA
QCAtMzA0LDE0ICszMDQsNiBAQCBmaGFuZGxlcl9jb25zb2xlOjptb3VzZV9h
d2FyZSAoTU9VU0VfRVZFCiAgICAgICByZXR1cm4gMDsKICAgICB9CiAKLSAg
LyogQ2hlY2sgd2hldGhlciBhZGp1c3RlZCBtb3VzZSBwb3NpdGlvbiBjYW4g
YmUgcmVwb3J0ZWQgKi8KLSAgaWYgKGRldl9zdGF0ZS5kd01vdXNlUG9zaXRp
b24uWCA+IDB4RkYgLSAnICcgLSAxCi0gICAgICB8fCBkZXZfc3RhdGUuZHdN
b3VzZVBvc2l0aW9uLlkgPiAweEZGIC0gJyAnIC0gMSkKLSAgICB7Ci0gICAg
ICAvKiBNb3VzZSBwb3NpdGlvbiBvdXQgb2YgcmVwb3J0aW5nIHJhbmdlICov
Ci0gICAgICByZXR1cm4gMDsKLSAgICB9Ci0KICAgcmV0dXJuICgobW91c2Vf
ZXZlbnQuZHdFdmVudEZsYWdzID09IDAgfHwgbW91c2VfZXZlbnQuZHdFdmVu
dEZsYWdzID09IERPVUJMRV9DTElDSykKIAkgICYmIG1vdXNlX2V2ZW50LmR3
QnV0dG9uU3RhdGUgIT0gZGV2X3N0YXRlLmR3TGFzdEJ1dHRvblN0YXRlKQog
CSB8fCBtb3VzZV9ldmVudC5kd0V2ZW50RmxhZ3MgPT0gTU9VU0VfV0hFRUxF
RApAQCAtNDUzLDEyICs0NDUsMTMgQEAgZmhhbmRsZXJfY29uc29sZTo6cmVh
ZCAodm9pZCAqcHYsIHNpemVfdAogCSAgICB7CiAJICAgICAgY2hhciBjID0g
ZGV2X3N0YXRlLmJhY2tzcGFjZV9rZXljb2RlOwogCSAgICAgIG5yZWFkID0g
MDsKLQkgICAgICBpZiAoY29udHJvbF9rZXlfc3RhdGUgJiBBTFRfUFJFU1NF
RCkgewotCQlpZiAoZGV2X3N0YXRlLm1ldGFiaXQpCi0JCSAgYyB8PSAweDgw
OwotCQllbHNlCi0JCSAgdG1wW25yZWFkKytdID0gJ1xlJzsKLQkgICAgICB9
CisJICAgICAgaWYgKGNvbnRyb2xfa2V5X3N0YXRlICYgQUxUX1BSRVNTRUQp
CisJCXsKKwkJICBpZiAoZGV2X3N0YXRlLm1ldGFiaXQpCisJCSAgICBjIHw9
IDB4ODA7CisJCSAgZWxzZQorCQkgICAgdG1wW25yZWFkKytdID0gJ1xlJzsK
KwkJfQogCSAgICAgIHRtcFtucmVhZCsrXSA9IGM7CiAJICAgICAgdG1wW25y
ZWFkXSA9IDA7CiAJICAgICAgdG9hZGQgPSB0bXA7CkBAIC01NTEsNiArNTQ0
LDcgQEAgZmhhbmRsZXJfY29uc29sZTo6cmVhZCAodm9pZCAqcHYsIHNpemVf
dAogCQkgICBldmVudHMgYXQgdGhlIHNhbWUgdGltZS4gKi8KIAkJaW50IGIg
PSAwOwogCQljaGFyIHN6WzMyXTsKKwkJY2hhciBtb2RlNl90ZXJtID0gJ00n
OwogCiAJCWlmIChtb3VzZV9ldmVudC5kd0V2ZW50RmxhZ3MgPT0gTU9VU0Vf
V0hFRUxFRCkKIAkJICB7CkBAIC01NzQsNyArNTY4LDcgQEAgZmhhbmRsZXJf
Y29uc29sZTo6cmVhZCAodm9pZCAqcHYsIHNpemVfdAogCQkgICAgICB7CiAJ
CQliID0gZGV2X3N0YXRlLmxhc3RfYnV0dG9uX2NvZGU7CiAJCSAgICAgIH0K
LQkJICAgIGVsc2UgaWYgKG1vdXNlX2V2ZW50LmR3QnV0dG9uU3RhdGUgPCBk
ZXZfc3RhdGUuZHdMYXN0QnV0dG9uU3RhdGUpCisJCSAgICBlbHNlIGlmICht
b3VzZV9ldmVudC5kd0J1dHRvblN0YXRlIDwgZGV2X3N0YXRlLmR3TGFzdEJ1
dHRvblN0YXRlICYmICFkZXZfc3RhdGUuZXh0X21vdXNlX21vZGU2KQogCQkg
ICAgICB7CiAJCQliID0gMzsKIAkJCXN0cmNweSAoc3osICJidG4gdXAiKTsK
QEAgLTU5NSw2ICs1ODksMTAgQEAgZmhhbmRsZXJfY29uc29sZTo6cmVhZCAo
dm9pZCAqcHYsIHNpemVfdAogCQkJc3RyY3B5IChzeiwgImJ0bjMgZG93biIp
OwogCQkgICAgICB9CiAKKwkJICAgIGlmIChkZXZfc3RhdGUuZXh0X21vdXNl
X21vZGU2KQkvKiBkaXN0aW5ndWlzaCByZWxlYXNlICovCisJCSAgICAgIGlm
IChtb3VzZV9ldmVudC5kd0J1dHRvblN0YXRlIDwgZGV2X3N0YXRlLmR3TGFz
dEJ1dHRvblN0YXRlKQorCQkgICAgICAgIG1vZGU2X3Rlcm0gPSAnbSc7CisK
IAkJICAgIGRldl9zdGF0ZS5sYXN0X2J1dHRvbl9jb2RlID0gYjsKIAogCQkg
ICAgaWYgKG1vdXNlX2V2ZW50LmR3RXZlbnRGbGFncyA9PSBNT1VTRV9NT1ZF
RCkKQEAgLTYyNiwyNSArNjI0LDczIEBAIGZoYW5kbGVyX2NvbnNvbGU6OnJl
YWQgKHZvaWQgKnB2LCBzaXplX3QKIAkJYiB8PSBkZXZfc3RhdGUubk1vZGlm
aWVyczsKIAogCQkvKiBXZSBjYW4gbm93IGNyZWF0ZSB0aGUgY29kZS4gKi8K
LQkJc3ByaW50ZiAodG1wLCAiXDAzM1tNJWMlYyVjIiwgYiArICcgJywgZGV2
X3N0YXRlLmR3TW91c2VQb3NpdGlvbi5YICsgJyAnICsgMSwgZGV2X3N0YXRl
LmR3TW91c2VQb3NpdGlvbi5ZICsgJyAnICsgMSk7CisJCWlmIChkZXZfc3Rh
dGUuZXh0X21vdXNlX21vZGU2KQorCQkgIHsKKwkJICAgIHNwcmludGYgKHRt
cCwgIlwwMzNbPCVkOyVkOyVkJWMiLCBiLCBkZXZfc3RhdGUuZHdNb3VzZVBv
c2l0aW9uLlggKyAxLCBkZXZfc3RhdGUuZHdNb3VzZVBvc2l0aW9uLlkgKyAx
LCBtb2RlNl90ZXJtKTsKKwkJICAgIG5yZWFkID0gc3RybGVuICh0bXApOwor
CQkgIH0KKwkJZWxzZSBpZiAoZGV2X3N0YXRlLmV4dF9tb3VzZV9tb2RlMTUp
CisJCSAgeworCQkgICAgc3ByaW50ZiAodG1wLCAiXDAzM1slZDslZDslZE0i
LCBiICsgMzIsIGRldl9zdGF0ZS5kd01vdXNlUG9zaXRpb24uWCArIDEsIGRl
dl9zdGF0ZS5kd01vdXNlUG9zaXRpb24uWSArIDEpOworCQkgICAgbnJlYWQg
PSBzdHJsZW4gKHRtcCk7CisJCSAgfQorCQllbHNlIGlmIChkZXZfc3RhdGUu
ZXh0X21vdXNlX21vZGU1KQorCQkgIHsKKwkJICAgIHVuc2lnbmVkIGludCB4
Y29kZSA9IGRldl9zdGF0ZS5kd01vdXNlUG9zaXRpb24uWCArICcgJyArIDE7
CisJCSAgICB1bnNpZ25lZCBpbnQgeWNvZGUgPSBkZXZfc3RhdGUuZHdNb3Vz
ZVBvc2l0aW9uLlkgKyAnICcgKyAxOworCisJCSAgICBzcHJpbnRmICh0bXAs
ICJcMDMzW00lYyIsIGIgKyAnICcpOworCQkgICAgbnJlYWQgPSA0OworCQkg
ICAgLyogdGhlIG5lYXQgbmVzdGVkIGVuY29kaW5nIGZ1bmN0aW9uIG9mIG1p
bnR0eSAKKwkJICAgICAgIGRvZXMgbm90IGNvbXBpbGUgaW4gZysrLCBzbyBs
ZXQncyB1bmZvbGQgaXQ6ICovCisJCSAgICBpZiAoeGNvZGUgPCAweDgwKQor
CQkgICAgICB0bXAgW25yZWFkKytdID0geGNvZGU7CisJCSAgICBlbHNlIGlm
ICh4Y29kZSA8IDB4ODAwKQorCQkgICAgICB7CisJCQl0bXAgW25yZWFkKytd
ID0gMHhDMCArICh4Y29kZSA+PiA2KTsKKwkJCXRtcCBbbnJlYWQrK10gPSAw
eDgwICsgKHhjb2RlICYgMHgzRik7CisJCSAgICAgIH0KKwkJICAgIGVsc2UK
KwkJICAgICAgdG1wIFtucmVhZCsrXSA9IDA7CisJCSAgICBpZiAoeWNvZGUg
PCAweDgwKQorCQkgICAgICB0bXAgW25yZWFkKytdID0geWNvZGU7CisJCSAg
ICBlbHNlIGlmICh5Y29kZSA8IDB4ODAwKQorCQkgICAgICB7CisJCQl0bXAg
W25yZWFkKytdID0gMHhDMCArICh5Y29kZSA+PiA2KTsKKwkJCXRtcCBbbnJl
YWQrK10gPSAweDgwICsgKHljb2RlICYgMHgzRik7CisJCSAgICAgIH0KKwkJ
ICAgIGVsc2UKKwkJICAgICAgdG1wIFtucmVhZCsrXSA9IDA7CisJCSAgfQor
CQllbHNlCisJCSAgeworCQkgICAgdW5zaWduZWQgaW50IHhjb2RlID0gZGV2
X3N0YXRlLmR3TW91c2VQb3NpdGlvbi5YICsgJyAnICsgMTsKKwkJICAgIHVu
c2lnbmVkIGludCB5Y29kZSA9IGRldl9zdGF0ZS5kd01vdXNlUG9zaXRpb24u
WSArICcgJyArIDE7CisJCSAgICBpZiAoeGNvZGUgPj0gMjU2KQorCQkgICAg
ICB4Y29kZSA9IDA7CisJCSAgICBpZiAoeWNvZGUgPj0gMjU2KQorCQkgICAg
ICB5Y29kZSA9IDA7CisJCSAgICBzcHJpbnRmICh0bXAsICJcMDMzW00lYyVj
JWMiLCBiICsgJyAnLCB4Y29kZSwgeWNvZGUpOworCQkgICAgbnJlYWQgPSA2
OwkvKiB0bXAgbWF5IGNvbnRhaW4gTlVMIGJ5dGVzICovCisJCSAgfQogCQlz
eXNjYWxsX3ByaW50ZiAoIm1vdXNlOiAlcyBhdCAoJWQsJWQpIiwgc3osIGRl
dl9zdGF0ZS5kd01vdXNlUG9zaXRpb24uWCwgZGV2X3N0YXRlLmR3TW91c2VQ
b3NpdGlvbi5ZKTsKIAogCQl0b2FkZCA9IHRtcDsKLQkJbnJlYWQgPSA2Owog
CSAgICAgIH0KIAkgIH0KIAkgIGJyZWFrOwogCiAJY2FzZSBGT0NVU19FVkVO
VDoKLQkgIGlmIChkZXZfc3RhdGUudXNlX2ZvY3VzKSB7Ci0JICAgIGlmIChp
bnB1dF9yZWMuRXZlbnQuRm9jdXNFdmVudC5iU2V0Rm9jdXMpCi0JICAgICAg
c3ByaW50ZiAodG1wLCAiXDAzM1tJIik7Ci0JICAgIGVsc2UKLQkgICAgICBz
cHJpbnRmICh0bXAsICJcMDMzW08iKTsKKwkgIGlmIChkZXZfc3RhdGUudXNl
X2ZvY3VzKQorCSAgICB7CisJICAgICAgaWYgKGlucHV0X3JlYy5FdmVudC5G
b2N1c0V2ZW50LmJTZXRGb2N1cykKKwkgICAgICAgIHNwcmludGYgKHRtcCwg
IlwwMzNbSSIpOworCSAgICAgIGVsc2UKKwkgICAgICAgIHNwcmludGYgKHRt
cCwgIlwwMzNbTyIpOwogCi0JICAgIHRvYWRkID0gdG1wOwotCSAgICBucmVh
ZCA9IDM7Ci0JICB9CisJICAgICAgdG9hZGQgPSB0bXA7CisJICAgICAgbnJl
YWQgPSAzOworCSAgICB9CiAJICBicmVhazsKIAogCWNhc2UgV0lORE9XX0JV
RkZFUl9TSVpFX0VWRU5UOgpAQCAtMTUxNywyMiArMTU2MywzMCBAQCBmaGFu
ZGxlcl9jb25zb2xlOjpjaGFyX2NvbW1hbmQgKGNoYXIgYykKIAogCWNhc2Ug
MTAwMDogLyogTW91c2UgdHJhY2tpbmcgKi8KIAkgIGRldl9zdGF0ZS51c2Vf
bW91c2UgPSAoYyA9PSAnaCcpID8gMSA6IDA7Ci0JICBzeXNjYWxsX3ByaW50
ZiAoIm1vdXNlIHN1cHBvcnQgc2V0IHRvIG1vZGUgJWQiLCBkZXZfc3RhdGUu
dXNlX21vdXNlKTsKIAkgIGJyZWFrOwogCiAJY2FzZSAxMDAyOiAvKiBNb3Vz
ZSBidXR0b24gZXZlbnQgdHJhY2tpbmcgKi8KIAkgIGRldl9zdGF0ZS51c2Vf
bW91c2UgPSAoYyA9PSAnaCcpID8gMiA6IDA7Ci0JICBzeXNjYWxsX3ByaW50
ZiAoIm1vdXNlIHN1cHBvcnQgc2V0IHRvIG1vZGUgJWQiLCBkZXZfc3RhdGUu
dXNlX21vdXNlKTsKIAkgIGJyZWFrOwogCiAJY2FzZSAxMDAzOiAvKiBNb3Vz
ZSBhbnkgZXZlbnQgdHJhY2tpbmcgKi8KIAkgIGRldl9zdGF0ZS51c2VfbW91
c2UgPSAoYyA9PSAnaCcpID8gMyA6IDA7Ci0JICBzeXNjYWxsX3ByaW50ZiAo
Im1vdXNlIHN1cHBvcnQgc2V0IHRvIG1vZGUgJWQiLCBkZXZfc3RhdGUudXNl
X21vdXNlKTsKIAkgIGJyZWFrOwogCiAJY2FzZSAxMDA0OiAvKiBGb2N1cyBp
bi9vdXQgZXZlbnQgcmVwb3J0aW5nICovCiAJICBkZXZfc3RhdGUudXNlX2Zv
Y3VzID0gKGMgPT0gJ2gnKSA/IHRydWUgOiBmYWxzZTsKLQkgIHN5c2NhbGxf
cHJpbnRmICgiZm9jdXMgcmVwb3J0aW5nIHNldCB0byAlZCIsIGRldl9zdGF0
ZS51c2VfZm9jdXMpOworCSAgYnJlYWs7CisKKwljYXNlIDEwMDU6IC8qIEV4
dGVuZGVkIG1vdXNlIG1vZGUgKi8KKwkgIGRldl9zdGF0ZS5leHRfbW91c2Vf
bW9kZTUgPSBjID09ICdoJzsKKwkgIGJyZWFrOworCisJY2FzZSAxMDA2OiAv
KiBTR1IgZXh0ZW5kZWQgbW91c2UgbW9kZSAqLworCSAgZGV2X3N0YXRlLmV4
dF9tb3VzZV9tb2RlNiA9IGMgPT0gJ2gnOworCSAgYnJlYWs7CisKKwljYXNl
IDEwMTU6IC8qIFVyeHZ0IGV4dGVuZGVkIG1vdXNlIG1vZGUgKi8KKwkgIGRl
dl9zdGF0ZS5leHRfbW91c2VfbW9kZTE1ID0gYyA9PSAnaCc7CiAJICBicmVh
azsKIAogCWNhc2UgMjAwMDogLyogUmF3IGtleWJvYXJkIG1vZGUgKi8K

--------------060304020504010202000309--
