Return-Path: <SRS0=tVpX=DE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-048.btinternet.com (mailomta7-re.btinternet.com [213.120.69.100])
	by sourceware.org (Postfix) with ESMTPS id BB9AA3856DE6
	for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2023 13:37:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BB9AA3856DE6
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20230718133720.NMPZ17945.re-prd-fep-048.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2023 14:37:20 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63FE9A2B0FD7B5F7
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfuvfhfhfgjsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehhfeigeeukedtgfefkeelgedvgeffvdejheevgfffgfduveejffelvedtffekfeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqddujeelrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhr
	ugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63FE9A2B0FD7B5F7 for cygwin-patches@cygwin.com; Tue, 18 Jul 2023 14:37:20 +0100
Content-Type: multipart/mixed; boundary="------------dmvbF9TUDKIIf0Z0KU0JWF35"
Message-ID: <b6c16cd8-3b02-fddd-966e-4dbe9ca430c4@dronecode.org.uk>
Date: Tue, 18 Jul 2023 14:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/11] More testsuite fixes
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <0a9d6f10-f26c-faf2-6fa1-c6a055570f5a@dronecode.org.uk>
 <ZLVKBcPUlt18BQoJ@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLVKBcPUlt18BQoJ@calimero.vinschen.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------dmvbF9TUDKIIf0Z0KU0JWF35
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2023 15:02, Corinna Vinschen wrote:
> 
>> We can't neatly tuck the pthread_cleanup_push/pop inside the object, as
>> they are implemented as macros which must appear in the same lexical
>> scope.
> 
> You could do it if you call the underlying functions instead.
> pthread_cleanup_push is just a convenience macro which initializes a
> local __pthread_cleanup_handler, see include/pthread.h.  If you add a
> __pthread_cleanup_handler to system_call_handle, you could use it the
> same way as the macro and encapsulate the whole thing inside the object.
> If you want to...

Good point.

Yeah, this seems preferable as it doesn't move the point where we 
restore the signal handlers in the normal flow of execution, which might 
be important, still happening when the system_call_handle object falls 
out of scope and is destroyed.

> 
> Fixes and Signed-off-by tags?
> 

Done.  Revised patch attached.


--------------dmvbF9TUDKIIf0Z0KU0JWF35
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Restore-signal-handlers-on-thread-cancellatio.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Restore-signal-handlers-on-thread-cancellatio.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxOGRkZGE2OTYxMzcxMDZlYWEzOTdhMDFiYzA2ZmM5N2M1OWRmMDJkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFN1biwgMTYgSnVsIDIwMjMgMTQ6NDY6MDAgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBDeWd3aW46IFJlc3RvcmUgc2lnbmFsIGhhbmRsZXJzIG9uIHRocmVhZCBj
YW5jZWxsYXRpb24gZHVyaW5nCiBzeXN0ZW0oKQoKQWRkIGJhY2sgdGhlIHJlc3RvcmF0aW9u
IG9mIHNpZ25hbCBoYW5kbGVycyBtb2RpZmllZCBkdXJpbmcgc3lzdGVtKCkgb24KdGhyZWFk
IGNhbmNlbGxhdGlvbi4KClJlbW92ZWQgaW4gM2NiOWRhMTQgd2hpY2ggZGVzY3JpYmVzIGl0
IGFzICdpbGwtY29uY2VpdmVkJyAoYWRkaXRpb25hbApjb250ZXh0IGRvZXNuJ3QgYXBwZWFy
IHRvIGJlIGF2YWlsYWJsZSkuCgpXZSB1c2UgaW50ZXJuYWwgaW1wbGVtZW50YXRpb24gaGVs
cGVycyBmb3IgcHRocmVhZCBjbGVhbnVwIGNoYWluLCBzbyB3ZQpjYW4gbmVhdGx5IHR1Y2sg
aXQgaW5zaWRlIHRoZSBvYmplY3QsIGFuZCBrZWVwIHRoZSBwb2ludCB3aGVuIHdlIHJlc3Rv
cmUKdGhlIHNpZ25hbCBoYW5kbGVycyB0aGUgc2FtZS4gVGhlIHB0aHJlYWRfY2xlYW51cF9w
dXNoL3BvcCgpIGZ1bmN0aW9ucwphcmUgaW1wbGVtZW50ZWQgYXMgbWFjcm9zIHdoaWNoIG11
c3QgYXBwZWFyIGluIHRoZSBzYW1lIGxleGljYWwgc2NvcGUuKQoKRml4ZXM6IDNjYjlkYTE0
NjE3YyAoIlB1dCBzaWduYWxzIG9uIGhvbGQgYW5kIHVzZSBzeXN0ZW1fY2FsbF9jbGVhbnVw
IGNsYXNzIHRvIHNldCBhbmQgcmVzdG9yZSBzaWduYWxzIHJhdGhlciB0aGFuIGRvaW5nIGl0
IHByaW9yIHRvIHRvIHJ1bm5pbmcgdGhlIHByb2dyYW0uICBSZW1vdmUgdGhlIGlsbC1jb25j
ZWl2ZWQgcHRocmVhZF9jbGVhbnVwIHN0dWZmLiIpClNpZ25lZC1vZmYtYnk6IEpvbiBUdXJu
ZXkgPGpvbi50dXJuZXlAZHJvbmVjb2RlLm9yZy51az4KLS0tCiB3aW5zdXAvY3lnd2luL3Nw
YXduLmNjIHwgMTkgKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9zcGF3bi5jYyBiL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MKaW5kZXggODRkZDc0ZTI4Li5j
MTZmZTI2OWEgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MKKysrIGIvd2lu
c3VwL2N5Z3dpbi9zcGF3bi5jYwpAQCAtMjI4LDYgKzIyOCw4IEBAIHN0cnVjdCBzeXN0ZW1f
Y2FsbF9oYW5kbGUKICAgX3NpZ19mdW5jX3B0ciBvbGRpbnQ7CiAgIF9zaWdfZnVuY19wdHIg
b2xkcXVpdDsKICAgc2lnc2V0X3Qgb2xkbWFzazsKKyAgX19wdGhyZWFkX2NsZWFudXBfaGFu
ZGxlciBjbGVhbnVwX2hhbmRsZXI7CisKICAgYm9vbCBpc19zeXN0ZW1fY2FsbCAoKQogICB7
CiAgICAgcmV0dXJuIG9sZGludCAhPSBJTExFR0FMX1NJR19GVU5DX1BUUjsKQEAgLTI1Mywx
OCArMjU1LDI3IEBAIHN0cnVjdCBzeXN0ZW1fY2FsbF9oYW5kbGUKIAlzaWdhZGRzZXQgKCZj
aGlsZF9ibG9jaywgU0lHQ0hMRCk7CiAJc2lncHJvY21hc2sgKFNJR19CTE9DSywgJmNoaWxk
X2Jsb2NrLCAmb2xkbWFzayk7CiAJc2lnX3NlbmQgKE5VTEwsIF9fU0lHTk9IT0xEKTsKKwor
CWNsZWFudXBfaGFuZGxlciA9IHsgc3lzdGVtX2NhbGxfaGFuZGxlOjpjbGVhbnVwLCB0aGlz
LCBOVUxMIH07CisJX3B0aHJlYWRfY2xlYW51cF9wdXNoICgmY2xlYW51cF9oYW5kbGVyKTsK
ICAgICAgIH0KICAgfQogICB+c3lzdGVtX2NhbGxfaGFuZGxlICgpCiAgIHsKICAgICBpZiAo
aXNfc3lzdGVtX2NhbGwgKCkpCisgICAgICBfcHRocmVhZF9jbGVhbnVwX3BvcCAoMSk7Cisg
IH0KKyAgc3RhdGljIHZvaWQgY2xlYW51cCAodm9pZCAqYXJnKQorICB7CisjIGRlZmluZSB0
aGlzXyAoKHN5c3RlbV9jYWxsX2hhbmRsZSAqKSBhcmcpCisgICAgaWYgKHRoaXNfLT5pc19z
eXN0ZW1fY2FsbCAoKSkKICAgICAgIHsKLQlzaWduYWwgKFNJR0lOVCwgb2xkaW50KTsKLQlz
aWduYWwgKFNJR1FVSVQsIG9sZHF1aXQpOwotCXNpZ3Byb2NtYXNrIChTSUdfU0VUTUFTSywg
Jm9sZG1hc2ssIE5VTEwpOworCXNpZ25hbCAoU0lHSU5ULCB0aGlzXy0+b2xkaW50KTsKKwlz
aWduYWwgKFNJR1FVSVQsIHRoaXNfLT5vbGRxdWl0KTsKKwlzaWdwcm9jbWFzayAoU0lHX1NF
VE1BU0ssICYodGhpc18tPm9sZG1hc2spLCBOVUxMKTsKICAgICAgIH0KICAgfQotIyB1bmRl
ZiBjbGVhbnVwCisjIHVuZGVmIHRoaXNfCiB9OwogCiBjaGlsZF9pbmZvX3NwYXduIE5PX0NP
UFkgY2hfc3Bhd247Ci0tIAoyLjM5LjAKCg==

--------------dmvbF9TUDKIIf0Z0KU0JWF35--
