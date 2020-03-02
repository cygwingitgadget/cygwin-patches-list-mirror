Return-Path: <cygwin-patches-return-10162-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125828 invoked by alias); 2 Mar 2020 21:39:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125816 invoked by uid 89); 2 Mar 2020 21:39:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=partition
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 21:39:32 +0000
Received: from [192.168.178.45] ([95.90.246.218]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MFsdD-1jAC6g2KSt-00HRJu for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2020 22:39:29 +0100
To: cygwin-patches@cygwin.com
From: Thomas Wolff <towo@towo.net>
Subject: /proc/partitions: add some space to avoid ragged output format
Message-ID: <dc387652-11c2-92c5-70e6-b096c318f58c@towo.net>
Date: Mon, 02 Mar 2020 21:39:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------ACC64BA1879AF68E1A718D94"
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00268.txt

This is a multi-part message in MIME format.
--------------ACC64BA1879AF68E1A718D94
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1



--------------ACC64BA1879AF68E1A718D94
Content-Type: text/plain; charset=UTF-8;
 name="0001-avoid-ragged-output-of-proc-partitions.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-avoid-ragged-output-of-proc-partitions.patch"
Content-length: 2196

RnJvbSAyZTMzYjI3ZTdkNDY4MzA2MmYyMWEzMDgyZWM2MzRhNDQwZmY5Mzg3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgV29sZmYg
PHRvd29AdG93by5uZXQ+CkRhdGU6IE1vbiwgMiBNYXIgMjAyMCAyMjozNjo1
NiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIGF2b2lkIHJhZ2dlZCBvdXRwdXQg
b2YgL3Byb2MvcGFydGl0aW9ucwoKLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX3Byb2MuY2MgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL2ZoYW5kbGVyX3Byb2MuY2MgYi93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyX3Byb2MuY2MKaW5kZXggNjA1YTg0NDNmLi4zMzczZjNlZjUgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcHJvYy5jYworKysg
Yi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3Byb2MuY2MKQEAgLTE0OTEsNyAr
MTQ5MSw3IEBAIGZvcm1hdF9wcm9jX3BhcnRpdGlvbnMgKHZvaWQgKiwgY2hh
ciAqJmRlc3RidWYpCiAJfQogICAgICAgaWYgKCFnb3Rfb25lKQogCXsKLQkg
IHByaW50ICgibWFqb3IgbWlub3IgICNibG9ja3MgIG5hbWUgICB3aW4tbW91
bnRzXG5cbiIpOworCSAgcHJpbnQgKCJtYWpvciBtaW5vciAgICNibG9ja3Mg
ICBuYW1lICAgd2luLW1vdW50c1xuXG4iKTsKIAkgIGdvdF9vbmUgPSB0cnVl
OwogCX0KICAgICAgIC8qIEZldGNoIHBhcnRpdGlvbiBpbmZvIGZvciB0aGUg
ZW50aXJlIGRpc2sgdG8gZ2V0IGl0cyBzaXplLiAqLwpAQCAtMTUxNCw3ICsx
NTE0LDcgQEAgZm9ybWF0X3Byb2NfcGFydGl0aW9ucyAodm9pZCAqLCBjaGFy
IComZGVzdGJ1ZikKIAkgIHNpemUgPSAwOwogCX0KICAgICAgIGRldmljZSBk
ZXYgKGRyaXZlX251bSwgMCk7Ci0gICAgICBidWZwdHIgKz0gX19zbWFsbF9z
cHJpbnRmIChidWZwdHIsICIlNWQgJTVkICU5VSAlc1xuIiwKKyAgICAgIGJ1
ZnB0ciArPSBfX3NtYWxsX3NwcmludGYgKGJ1ZnB0ciwgIiU1ZCAlNWQgJTEx
VSAlc1xuIiwKIAkJCQkgZGV2LmdldF9tYWpvciAoKSwgZGV2LmdldF9taW5v
ciAoKSwKIAkJCQkgc2l6ZSA+PiAxMCwgZGV2Lm5hbWUgKCkgKyA1KTsKICAg
ICAgIC8qIEZldGNoIGRyaXZlIGxheW91dCBpbmZvIHRvIGdldCBzaXplIG9m
IGFsbCBwYXJ0aXRpb25zIG9uIHRoZSBkaXNrLiAqLwpAQCAtMTU2MSw3ICsx
NTYxLDcgQEAgZm9ybWF0X3Byb2NfcGFydGl0aW9ucyAodm9pZCAqLCBjaGFy
IComZGVzdGJ1ZikKIAkgICAgICBjb250aW51ZTsKIAkgICAgZGV2aWNlIGRl
diAoZHJpdmVfbnVtLCBwYXJ0X251bSk7CiAKLQkgICAgYnVmcHRyICs9IF9f
c21hbGxfc3ByaW50ZiAoYnVmcHRyLCAiJTVkICU1ZCAlOVUgJXMiLAorCSAg
ICBidWZwdHIgKz0gX19zbWFsbF9zcHJpbnRmIChidWZwdHIsICIlNWQgJTVk
ICUxMVUgJXMiLAogCQkJCSAgICAgICBkZXYuZ2V0X21ham9yICgpLCBkZXYu
Z2V0X21pbm9yICgpLAogCQkJCSAgICAgICBzaXplID4+IDEwLCBkZXYubmFt
ZSAoKSArIDUpOwogCSAgICAvKiBDaGVjayBpZiB0aGUgcGFydGl0aW9uIGlz
IG1vdW50ZWQgaW4gV2luZG93cyBhbmQsIGlmIHNvLAotLSAKMi4yMS4wCgo=

--------------ACC64BA1879AF68E1A718D94--
