Return-Path: <cygwin-patches-return-8644-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24050 invoked by alias); 15 Nov 2016 13:51:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24034 invoked by uid 89); 15 Nov 2016 13:51:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=mailerdaemon, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f47.google.com
Received: from mail-wm0-f47.google.com (HELO mail-wm0-f47.google.com) (74.125.82.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Nov 2016 13:51:19 +0000
Received: by mail-wm0-f47.google.com with SMTP id g23so168435040wme.1        for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2016 05:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;        bh=ch1k6W6ZaZLqdx7x6Lvnnaitd86B3L2a6DzVLX9t5tc=;        b=Yk/S6tllr3URQwnsjAPRBIs7hDzB2hMsgm9GOXYalOmq9cBbznzA1osjHGeUxb7tBC         fTziRtMK/q9aahX7McrrGTR0fND6URTPvLaKSB5ok0Q+OGK4cMGFm5yILUwSd/2XgQOh         vdaFA642pUQ2zIkU7FH4gKO9Rj33tKhuDvrCeK0cc3NmPCfLYDsDWQnKrQzKtM1+E5xR         A1Skkf9N0oJF+vRVbx1rmUCbyGbfHUAfhOqlZkT0tlV8RwWzrJ52xmiy5mSeejMRZW5C         1UtGIAF5eor7NQSrDATCoeGYj9ur1sjDZXKtpNOuuyjol+GXgTCTO6+Hs/6ReMDgc2zq         bhOQ==
X-Gm-Message-State: ABUngvcT39Vn0yRXX3gdo0Xj3acvcP/H2zKvXoNi9O5MdIbILPO2i2y6LewCcbFZETJd2zExRv+dDumguyl7/A==
X-Received: by 10.28.175.195 with SMTP id y186mr4204600wme.68.1479217877488; Tue, 15 Nov 2016 05:51:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.151.145 with HTTP; Tue, 15 Nov 2016 05:51:16 -0800 (PST)
From: Erik Bray <erik.m.bray@gmail.com>
Date: Tue, 15 Nov 2016 13:51:00 -0000
Message-ID: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com>
Subject: Return the correct value for sysconf(_SC_PAGESIZE)
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=001a1144356623067805415740c2
X-IsSubscribed: yes
X-SW-Source: 2016-q4/txt/msg00002.txt.bz2


--001a1144356623067805415740c2
Content-Type: text/plain; charset=UTF-8
Content-length: 586

Greetings,

Currently sysconf(_SC_PAGESIZE) returns the value of
wincap.allocation_granularity()--a change I *think* had to have been
made by mistake in
https://cygwin.com/git/gitweb.cgi?p=newlib-cygwin.git;a=commit;f=winsup/cygwin/sysconf.cc;h=177dc6c7f6d0608ef6540fd997d9b444e324cae2

There's no obvious reason, anyways, that this value should be returned
and not the actual page size.

Thanks,

Erik

(P.S. Took me about a half-dozen tries to get a message through to
this ML due to a very picky mailer-daemon--I think it doesn't like
gmail aliases--hopefully this does the
trick :)

--001a1144356623067805415740c2
Content-Type: application/octet-stream; 
	name="0001-Return-wincap.page_size-for-sysconf-_SC_PAGESIZE-not.patch"
Content-Disposition: attachment; 
	filename="0001-Return-wincap.page_size-for-sysconf-_SC_PAGESIZE-not.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivjk4dop0
Content-length: 928

RnJvbSAyYjlkNmU4OWRmYmI0ZmNlNWZmMzYwYWMxMTM3MmM3OGYxNGM5MDNk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiRXJpayBNLiBCcmF5
IiA8ZXJpay5icmF5QGxyaS5mcj4KRGF0ZTogVHVlLCAxNSBOb3YgMjAxNiAx
MzoyODoxOSArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIFJldHVybiB3aW5jYXAu
cGFnZV9zaXplKCkgZm9yIHN5c2NvbmYoX1NDX1BBR0VTSVpFKSwgbm90CiB3
aW5jYXAuYWxsb2NhdGlvbl9ncmFudWxhcml0eSgpCgotLS0KIHdpbnN1cC9j
eWd3aW4vc3lzY29uZi5jYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vc3lzY29uZi5jYyBiL3dpbnN1cC9jeWd3aW4vc3lzY29uZi5j
YwppbmRleCBhMjRhOTg1Li5hZjBhZTJlIDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL3N5c2NvbmYuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9zeXNjb25m
LmNjCkBAIC0zMiw3ICszMiw3IEBAIGdldF9vcGVuX21heCAoaW50IGluKQog
c3RhdGljIGxvbmcKIGdldF9wYWdlX3NpemUgKGludCBpbikKIHsKLSAgcmV0
dXJuIHdpbmNhcC5hbGxvY2F0aW9uX2dyYW51bGFyaXR5ICgpOworICByZXR1
cm4gd2luY2FwLnBhZ2Vfc2l6ZSAoKTsKIH0KIAogc3RhdGljIGJvb2wKLS0g
CjIuOC4zCgo=

--001a1144356623067805415740c2--
