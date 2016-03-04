Return-Path: <cygwin-patches-return-8376-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88177 invoked by alias); 4 Mar 2016 19:57:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88155 invoked by uid 89); 4 Mar 2016 19:57:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.3 required=5.0 tests=AWL,BAYES_20,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=remedy, Hx-languages-length:187, 850, engineer
X-HELO: mail-wm0-f41.google.com
Received: from mail-wm0-f41.google.com (HELO mail-wm0-f41.google.com) (74.125.82.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 04 Mar 2016 19:57:02 +0000
Received: by mail-wm0-f41.google.com with SMTP id l68so34043470wml.0        for <cygwin-patches@cygwin.com>; Fri, 04 Mar 2016 11:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;        bh=kszoyQvhbaimdfWIQs0VnmkMl2DVtFT2LZwcAE83IPE=;        b=Dg6dkZ5RJLX+RRYiX5oaHjwAdLPqe+xQWAk5oKr4bvOkTIWcViJDFeMyqgAPMRtjKA         IE/PFytg0yPoYfXPXG/c//S5OyN5utR1Dp5zpF4fr6t5ftIRnEuVKvfqJ+LAhglfXO8B         fUyWSw1KO58j7ZDbX+TB0PnKpaJMA6LukBq/uwdrMG2donr9ORHBQrVHUxmDJeWhPRYU         ErP2NBhu6g5Ny0rX7e9bH9y9HKLQPypni7g7hiA0VAi9grD+jHYqtDSn2Bl21hsgYUXV         oTItUr3rMTrbc7NQiJe5AnXZjfl2NbYxH66+BgrE3AGBksFB+HP22TNGKasz9CZJctFx         swUg==
X-Gm-Message-State: AD7BkJKQz511wXPgkfwv1yIKz9/CNFcMDJovowwW3vfD8x4szWmgMLcUEiTGqhujfZ5XM5TaINoLvpEVlQzzb+f2
X-Received: by 10.28.184.137 with SMTP id i131mr584055wmf.96.1457121419276; Fri, 04 Mar 2016 11:56:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.19.7 with HTTP; Fri, 4 Mar 2016 11:56:39 -0800 (PST)
From: Alexey Sokolov <sokolov@google.com>
Date: Fri, 04 Mar 2016 19:57:00 -0000
Message-ID: <CAL-ThkuJseQeZOSsH=aFw4-8zitheSs6H0c8KQdh_TvsgptXXg@mail.gmail.com>
Subject: [PATCH] Mention 64-bit Cygwin as another remedy for fork() failures.
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=001a114b30d297d565052d3e84db
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00082.txt.bz2


--001a114b30d297d565052d3e84db
Content-Type: text/plain; charset=UTF-8
Content-length: 118

Hello, patch to FAQ is attached.

-- 
Alexey Sokolov | SRE, Software Engineer | sokolov@google.com | +353 87 3767 850

--001a114b30d297d565052d3e84db
Content-Type: application/octet-stream; 
	name="0001-Mention-64-bit-Cygwin-as-another-remedy-for-fork-fai.patch"
Content-Disposition: attachment; 
	filename="0001-Mention-64-bit-Cygwin-as-another-remedy-for-fork-fai.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ile4fx700
Content-length: 2131

RnJvbSA0MDcwYWNjNTc0ZGNlNDFmNmE5ODg0OGE2NjYyNmIyNmJlNGNkZjhj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZXkgU29rb2xv
diA8c29rb2xvdkBnb29nbGUuY29tPgpEYXRlOiBGcmksIDQgTWFyIDIwMTYg
MTk6NDI6MTUgKzAwMDAKU3ViamVjdDogW1BBVENIXSBNZW50aW9uIDY0LWJp
dCBDeWd3aW4gYXMgYW5vdGhlciByZW1lZHkgZm9yIGZvcmsoKSBmYWlsdXJl
cy4KCi0tLQogd2luc3VwL2RvYy9mYXEtdXNpbmcueG1sIHwgNCArKystCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy9mYXEtdXNpbmcueG1sIGIvd2lu
c3VwL2RvYy9mYXEtdXNpbmcueG1sCmluZGV4IGFlNzIxNDUuLmY2ZDRiOGUg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9kb2MvZmFxLXVzaW5nLnhtbAorKysgYi93
aW5zdXAvZG9jL2ZhcS11c2luZy54bWwKQEAgLTEzOTQsMTMgKzEzOTQsMTUg
QEAgc3VjaCBhcyB2aXJ0dWFsIG1lbW9yeSBwYWdpbmcgYW5kIGZpbGUgY2Fj
aGluZy48L3BhcmE+CiAgIDxwYXJhPjxpdGVtaXplZGxpc3Q+CiAgICAgPGxp
c3RpdGVtPlJlc3RhcnQgd2hhdGV2ZXIgcHJvY2VzcyBpcyB0cnlpbmcgKGFu
ZCBmYWlsaW5nKSB0byB1c2UKICAgICA8bGl0ZXJhbD5mb3JrKCk8L2xpdGVy
YWw+LiBTb21ldGltZXMgV2luZG93cyBzZXRzIHVwIGEgcHJvY2VzcwotICAg
IGVudmlyb25tZW50IHRoYXQgaXMgZXZlbiBtb3JlIGhvc3RpbGUgdG8gZm9y
aygpIHRoYW4gdXN1YWwuPC9saXN0aXRlbT4KKyAgICBlbnZpcm9ubWVudCB0
aGF0IGlzIGV2ZW4gbW9yZSBob3N0aWxlIHRvIDxsaXRlcmFsPmZvcmsoKTwv
bGl0ZXJhbD4gdGhhbiB1c3VhbC48L2xpc3RpdGVtPgogICAgIDxsaXN0aXRl
bT5FbnN1cmUgdGhhdCB5b3UgaGF2ZSBlbGltaW5hdGVkIChub3QganVzdCBk
aXNhYmxlZCkgYWxsCiAgICAgc29mdHdhcmUgb24gdGhlIDx4cmVmIGxpbmtl
bmQ9ImZhcS51c2luZy5ibG9kYSIvPi4KICAgICA8L2xpc3RpdGVtPgogICAg
IDxsaXN0aXRlbT5SZWFkIHRoZSAncmViYXNlJyBwYWNrYWdlIFJFQURNRSBp
bgogICAgIDxsaXRlcmFsPi91c3Ivc2hhcmUvZG9jL3JlYmFzZS88L2xpdGVy
YWw+LCBhbmQgZm9sbG93IHRoZQogICAgIGluc3RydWN0aW9ucyB0aGVyZSB0
byBydW4gJ3JlYmFzZWFsbCcuPC9saXN0aXRlbT4KKyAgICA8bGlzdGl0ZW0+
U3dpdGNoIGZyb20gMzItYml0IEN5Z3dpbiB0byA2NC1iaXQgQ3lnd2luLCBp
ZiB5b3VyIE9TIGFuZCBDUFUgc3VwcG9ydCB0aGF0LgorICAgIFdpdGggdGhl
IGJpZ2dlciBhZGRyZXNzIHNwYWNlIDxsaXRlcmFsPmZvcmsoKTwvbGl0ZXJh
bD4gaXMgbGVzcyBsaWtlbHkgdG8gZmFpbC48L2xpc3RpdGVtPgogICAgIDwv
aXRlbWl6ZWRsaXN0PjwvcGFyYT4KICAgPHBhcmE+UGxlYXNlIG5vdGUgdGhh
dCBpbnN0YWxsaW5nIG5ldyBwYWNrYWdlcyBvciB1cGRhdGluZyBleGlzdGlu
ZwogICBvbmVzIHVuZG9lcyB0aGUgZWZmZWN0cyBvZiByZWJhc2VhbGwgYW5k
IG9mdGVuIGNhdXNlcyBmb3JrKCkgZmFpbHVyZXMKLS0gCjIuNi4yCgo=

--001a114b30d297d565052d3e84db--
