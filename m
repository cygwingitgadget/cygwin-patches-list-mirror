Return-Path: <cygwin-patches-return-7454-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26096 invoked by alias); 29 Jul 2011 11:41:30 -0000
Received: (qmail 26086 invoked by uid 22791); 29 Jul 2011 11:41:29 -0000
X-SWARE-Spam-Status: No, hits=0.3 required=5.0	tests=AWL,BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_YG,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 29 Jul 2011 11:41:14 +0000
Received: by gyh20 with SMTP id 20so3118408gyh.2        for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2011 04:41:13 -0700 (PDT)
Received: by 10.142.170.15 with SMTP id s15mr803016wfe.168.1311939673374;        Fri, 29 Jul 2011 04:41:13 -0700 (PDT)
Received: from [192.168.1.2] ([183.106.96.61])        by mx.google.com with ESMTPS id d14sm1204206wfh.13.2011.07.29.04.41.10        (version=SSLv3 cipher=OTHER);        Fri, 29 Jul 2011 04:41:11 -0700 (PDT)
Message-ID: <4E329C56.8090605@gmail.com>
Date: Fri, 29 Jul 2011 11:41:00 -0000
From: jojelino <jojelino@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 5.2; rv:7.0a2) Gecko/20110728 Thunderbird/7.0a2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] workaround for sigproc_init
Content-Type: multipart/mixed; boundary="------------060302070406040200010402"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00030.txt.bz2

This is a multi-part message in MIME format.
--------------060302070406040200010402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 546

As sigproc_init is called during dll initialization, wait_sig thread is 
not created as soon as possible.(this is known in msdn createthread 
reference. http://msdn.microsoft.com/en-us/library/ms682453(v=vs.85).aspx)
And then wait_sig starts to wake up as sig_dispatch_pending enters 
waitforsingleobject. then main thread stops for few ms. and it shows 
poor performance.
as a workaround, issue user apc call, let the os decide when to call them.
And the result was quite good. patch,changelog modified are attached.
Please review it.

Regards.

--------------060302070406040200010402
Content-Type: text/plain;
 name="workaround_sigproc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="workaround_sigproc.diff"
Content-length: 2558

SW5kZXg6IHdpbnN1cC9jeWd3aW4vc2lncHJvYy5jYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dp
bi9zaWdwcm9jLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjMzOQpkaWZm
IC11IC1yMS4zMzkgc2lncHJvYy5jYwotLS0gd2luc3VwL2N5Z3dpbi9zaWdw
cm9jLmNjCTYgSnVsIDIwMTEgMTI6Mzk6MzYgLTAwMDAJMS4zMzkKKysrIHdp
bnN1cC9jeWd3aW4vc2lncHJvYy5jYwkyOSBKdWwgMjAxMSAxMDo0NToxMSAt
MDAwMApAQCAtNDQ3LDYgKzQ0Nyw5IEBACiAKIC8qIFNpZ25hbCB0aHJlYWQg
aW5pdGlhbGl6YXRpb24uICBDYWxsZWQgZnJvbSBkbGxfY3J0MF8xLgogICAg
VGhpcyByb3V0aW5lIHN0YXJ0cyB0aGUgc2lnbmFsIGhhbmRsaW5nIHRocmVh
ZC4gICovCitzdGF0aWMgdm9pZCBfX3N0ZGNhbGwgYXBjX3NwYXdudGhyZWFk
KHVuc2lnbmVkIGxvbmcgcCl7CisJbmV3IGN5Z3RocmVhZCAod2FpdF9zaWcs
IGN5Z3NlbGYsICJzaWciKTsKK30KIHZvaWQgX19zdGRjYWxsCiBzaWdwcm9j
X2luaXQgKCkKIHsKQEAgLTQ1OSw3ICs0NjIsMTYgQEAKICAgICAgIGFwaV9m
YXRhbCAoImNvdWxkbid0IGNyZWF0ZSBzaWduYWwgcGlwZSwgJUUiKTsKICAg
UHJvdGVjdEhhbmRsZSAobXlfcmVhZHNpZyk7CiAgIG15c2VsZi0+c2VuZHNp
ZyA9IG15X3NlbmRzaWc7Ci0gIG5ldyBjeWd0aHJlYWQgKHdhaXRfc2lnLCBj
eWdzZWxmLCAic2lnIik7CisgIC8qCisgICAqIElzc3VlIHVzZXIgQVBDIGNh
bGwsIGFuZCBsZXQgdGhlIG9zIGRlY2lkZSB3aGVuIHRvIGNhbGwgdGhlbS4K
KyAgICogSXQgaXMga25vd24gYXMgd29ya2Fyb3VuZC4gd2FpdF9zaWcgdGhy
ZWFkIHdha2VzIHVwIGZhc3Rlci4KKyAgICovCisgIGlmICghUXVldWVVc2Vy
QVBDKGFwY19zcGF3bnRocmVhZCxHZXRDdXJyZW50VGhyZWFkKCksMCkpewor
CSAgLyoKKwkgICAqIEFuZCBmYWlsZWQuIGp1c3QgY2FsbCBmcm9tIGhlcmUu
CisJICAgKi8KKwkgIGFwY19zcGF3bnRocmVhZCgwKTsKKyAgfQogICAvKiBz
eW5jX3Byb2Nfc3VicHJvYyBpcyB1c2VkIGJ5IHByb2Nfc3VicHJvYy4gIEl0
IHNlcmlhbGl6ZXMKICAgICAgYWNjZXNzIHRvIHRoZSBjaGlsZHJlbiBhbmQg
cHJvYyBhcnJheXMuICAqLwogICBzeW5jX3Byb2Nfc3VicHJvYy5pbml0ICgi
c3luY19wcm9jX3N1YnByb2MiKTsKCkluZGV4OiB3aW5zdXAvY3lnd2luL0No
YW5nZUxvZwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zz
L3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9DaGFuZ2VMb2csdgpyZXRyaWV2aW5n
IHJldmlzaW9uIDEuNTQ1NQpkaWZmIC11IC1yMS41NDU1IENoYW5nZUxvZwot
LS0gd2luc3VwL2N5Z3dpbi9DaGFuZ2VMb2cJMjYgSnVsIDIwMTEgMTM6MzA6
NDAgLTAwMDAJMS41NDU1CisrKyB3aW5zdXAvY3lnd2luL0NoYW5nZUxvZwky
OSBKdWwgMjAxMSAxMTowNzo0OSAtMDAwMApAQCAtMSwzICsxLDggQEAKKzIw
MTEtMDctMjkgIEppbndvbyBZZSAgPGpvamVsaW5vQGdtYWlsLmNvbT4NCisN
CisJKiBzaWdwcm9jLmNjIChhcGNfc3Bhd250aHJlYWQpOiBOZXcgZnVuY3Rp
b24gZm9yIHNpZ3Byb2NfaW5pdC4NCisJKHNpZ3Byb2NfaW5pdCk6IFVzZSBh
cGNfc3Bhd250aHJlYWQsIHVzZSBRdWV1ZVVzZXJBUEMgYW5kIGV4cGxhaW4g
d2h5LgorCiAyMDExLTA3LTI2ICBDb3Jpbm5hIFZpbnNjaGVuICA8Y29yaW5u
YUB2aW5zY2hlbi5kZT4KIAogCSogZmhhbmRsZXJfZGlza19maWxlLmNjIChf
X0RJUl9tb3VudHM6OmV2YWxfaW5vKTogQ3JlYXRlIHBhdGhfY29udgo=

--------------060302070406040200010402--
