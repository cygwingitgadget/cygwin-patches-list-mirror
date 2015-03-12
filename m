Return-Path: <cygwin-patches-return-8063-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77263 invoked by alias); 12 Mar 2015 14:05:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77240 invoked by uid 89); 12 Mar 2015 14:05:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out2-smtp.messagingengine.com
Received: from out2-smtp.messagingengine.com (HELO out2-smtp.messagingengine.com) (66.111.4.26) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 12 Mar 2015 14:05:32 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])	by mailout.nyi.internal (Postfix) with ESMTP id A9B8B20178	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2015 10:05:28 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute2.internal (MEProxy); Thu, 12 Mar 2015 10:05:30 -0400
Received: from [192.168.1.102] (unknown [31.51.206.246])	by mail.messagingengine.com (Postfix) with ESMTPA id D2EAFC002A2	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2015 10:05:29 -0400 (EDT)
Message-ID: <55019D23.6060308@dronecode.org.uk>
Date: Thu, 12 Mar 2015 14:05:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] Improve stackdumps on x86_64
Content-Type: multipart/mixed; boundary="------------070708020405090102030609"
X-SW-Source: 2015-q1/txt/msg00018.txt.bz2

This is a multi-part message in MIME format.
--------------070708020405090102030609
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2933


I was looking at the crash reported at [1]. Processing the stackdump gives:

> 0x000000018006ff23    signal_exit                                exceptions.cc:1234
> 0x00000001800713ea    _cygtls::call_signal_handler()             exceptions.cc:1490
> 0x0000000180121d04    sig_send(_pinfo*, siginfo_t&, _cygtls*)    sigproc.cc:714
> 0x000000018011ee5e    _pinfo::kill(siginfo_t&)                   signal.cc:252
> 0x000000018011f32b    kill0                                      signal.cc:303
> 0x000000018011f4fc    raise                                      signal.cc:289
> 0x000000018011f7bf    abort                                      signal.cc:376
> 0x00000001801528c5    dlfree                                     malloc.cc:4762
> 0x00000001800c52b3    free                                       sync.h:36
> 0x000000018011ae5b    ??                                         sigfe.s:43

Which is not entirely helpful.

We can see that an abort signal is being raised inside free, but the 
stacktrace stops at _sigbe, because unwinding that frame requires 
special measures.

Presumably run has some invalid heap use going on, but annoyingly the 
stackdump stops short of identifying the problem line.

Attached is a patch which teaches stack_info::walk() how to unwind these 
frames on x86_64.

Also attached is a small testcase, which currently produces a similar 
stackdump truncated at _sigbe, or with my patch applied:

> 0x0000000180070238    signal_exit                                exceptions.cc:1321
> 0x000000018007172a    _cygtls::call_signal_handler()             exceptions.cc:1578
> 0x0000000180127e2f    sig_send(_pinfo*, siginfo_t&, _cygtls*)    sigproc.cc:714
> 0x0000000180124fb0    _pinfo::kill(siginfo_t&)                   signal.cc:252
> 0x0000000180125479    kill0                                      signal.cc:303
> 0x000000018012564c    raise                                      signal.cc:289
> 0x000000018012590f    abort                                      signal.cc:376
> 0x000000018015969a    dlfree                                     malloc.cc:4717
> 0x00000001800ca103    free                                       sync.h:36
> 0x0000000180120f5b    ?? (_sigbe)                                sigfe.s:54
> 0x0000000100401119    foo                                        malloc-corruption-abort.c:11
> 0x000000010040113b    sighandler                                 malloc-corruption-abort.c:17
> 0x000000018007172a    _cygtls::call_signal_handler()             exceptions.cc:1578
> 0x0000000180121078    ?? (sigdelayed)                            sigfe.s:144
> 0x0000000100401174    main                                       malloc-corruption-abort.c:32

The x86 unwinder could probably benefit from something similar, but it 
seems to be able to do a slightly better job of escaping from _sigbe, I 
guess due to the frame pointer.

[1] https://cygwin.com/ml/cygwin/2015-03/msg00117.html

--------------070708020405090102030609
Content-Type: text/plain; charset=windows-1252;
 name="malloc-corruption-abort.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="malloc-corruption-abort.c"
Content-length: 371

I2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNs
dWRlIDxzdHJpbmcuaD4KCnN0YXRpYyBpbnQgZm9vKCkKewogIHZvaWQgKnAg
PSBtYWxsb2MoMTApOwogIG1lbXNldChwLCAweGNhLCAyNTYpOwogIGZyZWUo
cCk7CiAgZnJlZShwKTsKfQoKc3RhdGljIHZvaWQKc2lnaGFuZGxlcihpbnQg
c2lnKQp7CiAgZm9vKCk7Cn0KCmludCBtYWluKCkKewogIHNpZ25hbChTSUdB
TFJNLCBzaWdoYW5kbGVyKTsKCiAgYWxhcm0oMSk7CgogIHNsZWVwKDEwKTsK
fQo=

--------------070708020405090102030609
Content-Type: text/plain; charset=windows-1252;
 name="0001-Teach-stackinfo-walk-how-to-virtually-unwind-the-tls.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Teach-stackinfo-walk-how-to-virtually-unwind-the-tls.pa";
 filename*1="tch"
Content-length: 3717

RnJvbSA5NDM5MWI3YWYwNmY2YWVjNmZjMDI1NDNiODk0YjA5NjM1NTYxMThl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVFVSTkVZIDxq
b24udHVybmV5QGRyb25lY29kZS5vcmcudWs+CkRhdGU6IE1vbiwgOSBNYXIg
MjAxNSAyMTo1NToyOSArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIFRlYWNoIHN0
YWNraW5mbzo6d2FsaygpIGhvdyB0byB2aXJ0dWFsbHkgdW53aW5kIHRoZSB0
bHMKIHNpZ3N0YWNrCgpUaGlzIGltcHJvdmVzIGhvdyBzdGFja2luZm86OmR1
bXBzdGFjaygpIGR1bXBzIF9zaWdiZSBhbmQgc2lnZGVsYXllZCBmcmFtZXMK
ClNpZ25lZC1vZmYtYnk6IEpvbiBUVVJORVkgPGpvbi50dXJuZXlAZHJvbmVj
b2RlLm9yZy51az4KLS0tCiB3aW5zdXAvY3lnd2luL0NoYW5nZUxvZyAgICAg
fCAgNiArKysrKysKIHdpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyB8IDEz
ICsrKysrKysrKysrKysKIHdpbnN1cC9jeWd3aW4vZ2VuZGVmICAgICAgICB8
ICAyICsrCiAzIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL0NoYW5nZUxvZyBiL3dpbnN1cC9j
eWd3aW4vQ2hhbmdlTG9nCmluZGV4IGQ2M2IzNTkuLmYwY2JlZWQgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vQ2hhbmdlTG9nCisrKyBiL3dpbnN1cC9j
eWd3aW4vQ2hhbmdlTG9nCkBAIC0xLDMgKzEsOSBAQAorMjAxNS0wMy0xMiAg
Sm9uIFRVUk5FWSAgPGpvbi50dXJuZXlAZHJvbmVjb2RlLm9yZy51az4KKwor
CSogZXhjZXB0aW9ucy5jYyAoc3RhY2tfaW5mbyk6IEFkZCBzaWdzdGFja3B0
ciBtZW1iZXIuCisJKHdhbGspOiBVbndpbmQgc2lnc3RhY2twdHIgaW5zaWRl
IF9zaWdiZSBhbmQgc2lnZGVsYXllZC4KKwkqIGdlbmRlZiAoX3NpZ2RlbGF5
ZWRfZW5kKTogQWRkIHN5bWJvbCB0byBtYXJrIGVuZCBvZiBzaWdkZWxheWVk
LgorCiAyMDE1LTAzLTExICBDb3Jpbm5hIFZpbnNjaGVuICA8Y29yaW5uYUB2
aW5zY2hlbi5kZT4KIAogCSogaW5jbHVkZS9jeWd3aW4vdHlwZXMuaDogSW5j
bHVkZSA8c3lzL190aW1lc3BlYy5oPgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5
Z3dpbi9leGNlcHRpb25zLmNjIGIvd2luc3VwL2N5Z3dpbi9leGNlcHRpb25z
LmNjCmluZGV4IDczZGU3ZTcuLjYwMzUyNzAgMTAwNjQ0Ci0tLSBhL3dpbnN1
cC9jeWd3aW4vZXhjZXB0aW9ucy5jYworKysgYi93aW5zdXAvY3lnd2luL2V4
Y2VwdGlvbnMuY2MKQEAgLTQ1LDYgKzQ1LDggQEAgZGV0YWlscy4gKi8KICNk
ZWZpbmUgQ0FMTF9IQU5ETEVSX1JFVFJZX0lOTkVSIDEwCiAKIGNoYXIgZGVi
dWdnZXJfY29tbWFuZFsyICogTlRfTUFYX1BBVEggKyAyMF07CitleHRlcm4g
dV9jaGFyIF9zaWdiZTsKK2V4dGVybiB1X2NoYXIgX3NpZ2RlbGF5ZWRfZW5k
OwogCiBzdGF0aWMgQk9PTCBXSU5BUEkgY3RybF9jX2hhbmRsZXIgKERXT1JE
KTsKIApAQCAtMjc3LDYgKzI3OSw3IEBAIGNsYXNzIHN0YWNrX2luZm8KICNp
ZmRlZiBfX3g4Nl82NF9fCiAgIENPTlRFWFQgYzsKICAgVU5XSU5EX0hJU1RP
UllfVEFCTEUgaGlzdDsKKyAgX19zdGFja190ICpzaWdzdGFja3B0cjsKICNl
bmRpZgogcHVibGljOgogICBTVEFDS0ZSQU1FIHNmOwkJIC8qIEZvciBzdG9y
aW5nIHRoZSBzdGFjayBpbmZvcm1hdGlvbiAqLwpAQCAtMzA1LDYgKzMwOCw3
IEBAIHN0YWNrX2luZm86OmluaXQgKFBVSU5UX1BUUiBmcmFtZXAsIGJvb2wg
d2FudGFyZ3MsIFBDT05URVhUIGN0eCkKICAgICAgIG1lbXNldCAoJmMsIDAs
IHNpemVvZiBjKTsKICAgICAgIGMuQ29udGV4dEZsYWdzID0gQ09OVEVYVF9B
TEw7CiAgICAgfQorICBzaWdzdGFja3B0ciA9IF9teV90bHMuc3RhY2twdHI7
CiAjZW5kaWYKICAgbWVtc2V0ICgmc2YsIDAsIHNpemVvZiAoc2YpKTsKICAg
aWYgKGN0eCkKQEAgLTM0MCw2ICszNDQsMTUgQEAgc3RhY2tfaW5mbzo6d2Fs
ayAoKQogICBzZi5BZGRyU3RhY2suT2Zmc2V0ID0gYy5Sc3A7CiAgIHNmLkFk
ZHJGcmFtZS5PZmZzZXQgPSBjLlJicDsKIAorICBpZiAoKGMuUmlwID49IChE
V09SRDY0KSZfc2lnYmUpICYmIChjLlJpcCA8IChEV09SRDY0KSZfc2lnZGVs
YXllZF9lbmQpKQorICAgIHsKKyAgICAgIC8qIF9zaWdiZSBhbmQgc2lnZGVs
YXllZCBkb24ndCBoYXZlIFNFSCB1bndpbmRpbmcgZGF0YSwgc28gdmlydHVh
bGx5CisgICAgICAgICB1bndpbmQgdGhlIHRscyBzaWdzdGFjayAqLworICAg
ICAgYy5SaXAgPSBzaWdzdGFja3B0clstMV07CisgICAgICBzaWdzdGFja3B0
ci0tOworICAgICAgcmV0dXJuIDE7CisgICAgfQorCiAgIGYgPSBSdGxMb29r
dXBGdW5jdGlvbkVudHJ5IChjLlJpcCwgJmltYWdlYmFzZSwgJmhpc3QpOwog
ICBpZiAoZikKICAgICBSdGxWaXJ0dWFsVW53aW5kICgwLCBpbWFnZWJhc2Us
IGMuUmlwLCBmLCAmYywgJmhkbCwgJmVzdGFibGlzaGVyLCBOVUxMKTsKZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZ2VuZGVmIGIvd2luc3VwL2N5Z3dp
bi9nZW5kZWYKaW5kZXggYWM0MTFjYS4uMDFiOGMzOSAxMDA3NTUKLS0tIGEv
d2luc3VwL2N5Z3dpbi9nZW5kZWYKKysrIGIvd2luc3VwL2N5Z3dpbi9nZW5k
ZWYKQEAgLTMyNyw2ICszMjcsOCBAQCBzaWdkZWxheWVkOgogCXhjaGdxCSVy
MTAsKCVyc3ApCiAJcmV0CiAJLnNlaF9lbmRwcm9jCitfc2lnZGVsYXllZF9l
bmQ6CisJLmdsb2JhbCBfc2lnZGVsYXllZF9lbmQKIAogIyBfY3lndGxzOjpw
b3AKIAkuZ2xvYmFsIF9aTjdfY3lndGxzM3BvcEV2Ci0tIAoyLjEuNAoK

--------------070708020405090102030609--
