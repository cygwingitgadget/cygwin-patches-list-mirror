Return-Path: <cygwin-patches-return-8337-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119684 invoked by alias); 18 Feb 2016 23:39:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119667 invoked by uid 89); 18 Feb 2016 23:39:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=intervals, adequate, exchanging, Hx-languages-length:3916
X-HELO: mail-yw0-f173.google.com
Received: from mail-yw0-f173.google.com (HELO mail-yw0-f173.google.com) (209.85.161.173) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 18 Feb 2016 23:39:41 +0000
Received: by mail-yw0-f173.google.com with SMTP id e63so54327477ywc.3        for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 15:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:date:message-id:subject:from:to         :content-type;        bh=rG+TlAP/Oz7qBlLe/33z12uRoLj/eyOMGJQx00b70+8=;        b=QuUiOU1YSH2GQv0fZkwZP+CbIk/dzrr/HF+Z0yrPLCWCnn+yqQEN19c3f5BBeEPSjL         74TBm6BgmWTRCDm4+jdKcrHYLW6gfHdi7EJ65W3jMlF8qTnBM/E2+mFVvH1UUWqf8VCs         Nh90SmzUrYGacgeY3quWQ+PwJT7JbPaTH35W5H7jDK6CbAVxY3doQyAa5OUMrv9+FqFa         JlynwCOzv7fGHitXWKmMdRYnDbDuNNGhZ2RAd+gnyO/W955Oet+IyqGI6U7dGrJdSQfh         kLfvC61Cz8Z4mabS5m8ABr3ubfQZCaijSvgjVUD7g3hFP8K/hm4Dy/jaoFaePJ3xWLN1         GlTw==
X-Gm-Message-State: AG10YOSclH/2D1Sad2fm7oLqqfUniZKTqrmTqKwt0bziB+gJHKZhXoXKCU+q8+f0CPUiWw0kHJ89+rnsllI/CA==
MIME-Version: 1.0
X-Received: by 10.129.38.135 with SMTP id m129mr6047399ywm.155.1455838778854; Thu, 18 Feb 2016 15:39:38 -0800 (PST)
Received: by 10.129.58.11 with HTTP; Thu, 18 Feb 2016 15:39:38 -0800 (PST)
Date: Thu, 18 Feb 2016 23:39:00 -0000
Message-ID: <CAJCedbifwNgza6nUfSX6QH8ovnEy85bRJ=vH8SGuA_hNYdW5bw@mail.gmail.com>
Subject: Re: [PATCH] Multiple timer issues + new [PATCH]
From: =?UTF-8?Q?Ir=C3=A1nyossy_Knoblauch_Art=C3=BAr?= <ikartur@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=001a1141618c44150c052c13e176
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00043.txt.bz2


--001a1141618c44150c052c13e176
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1662

Hi,

On Thu, Feb 18, 2016 at 12:28 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:

> Would you mind terribly to send a copyright assignment per
> https://cygwin.com/contrib.html?  If you send it as PDF by mail it takes
> usually just a few days to be countersigned.

OK, I will try my best. :-)

> I would apply patch 2 immediately, but as far as I can see it relies
> on patch 1.  Without patch 1, exchanging gtod with ntod will not change
> anything since it's still a non-monotonic timer.  Or am I missing
> something?

Exchanging 'gtod' with 'ntod' in select() could solve the issue if
'ntod' had its msecs() method implemented. So you are correct, the
patches are dependent on each other.

The important thing to note is that gtod (type hires_ms) is getting
its time using GetSystemTimeAsFileTime(), which is the system time
(UTC). Thus, the time returned by gtod is not adequate for measuring
time intervals, because a system time adjustment could interfere with
the measurement.

The ntod timer (type hires_ns), however, is getting its time value
from QueryPerformanceCounter(), which, according to the MSDN
documentation, will provide a "time stamp that can be used for
time-interval measurements" -- that is just what the doctor ordered.
:-)

I could not find any information regarding what the names 'gtod' and
'ntod' are supposed to mean, and their type names, hires_ms and
hires_ns, respectively, aren't conveying that 'ntod' is monotonic
while 'gtod' isn't.

Also, as I have been writing this mail, I have noticed that there is
still a data race left in the prime() function, so I have made a patch
for that, too.

Best Regards,
Art=C3=BAr

--001a1141618c44150c052c13e176
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0004-Fix-data-race-during-lazy-initialization.patch"
Content-Disposition: attachment; 
	filename="0004-Fix-data-race-during-lazy-initialization.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ikswmipz0
Content-length: 3225

RnJvbSA5MDQ1MzQ2NzE0NTNiOGNhMTZlMDEwZWEzNTIyMGVjOGEyYzJkYzI4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/SXI9
QzM9QTFueW9zc3k9MjBLbm9ibGF1Y2g9MjBBcnQ9QzM9QkFyPz0KIDxpa2Fy
dHVyQGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAxOCBGZWIgMjAxNiAyMzo0ODo0
NyArMDEwMApTdWJqZWN0OiBbUEFUQ0ggNC80XSBGaXggZGF0YSByYWNlIGR1
cmluZyBsYXp5IGluaXRpYWxpemF0aW9uCgoqIE1vdmUgaW5pdGlhbGl6YXRp
b24gdG8gdGhlIGNvbnN0cnVjdG9yIG9mIGhpcmVzX25zLgoKICBJbiBhIG11
bHRpdGhyZWFkZWQgZW52aXJvbm1lbnQsIHVuc3luY2hyb25pemVkIGxhenkg
aW5pdGlhbGl6YXRpb24gY2FuCiAgY2F1c2UgcmFjZSBjb25kaXRpb24gZXJy
b3JzLgoKKiBDbGVhbmVkIHVwIHJlc2V0KCkgZnVuY3Rpb24gd2hpY2ggaGFk
IG5vIGVmZmVjdC4KLS0tCiB3aW5zdXAvY3lnd2luL2hpcmVzLmggIHwgMTUg
KysrKy0tLS0tLS0tLS0tCiB3aW5zdXAvY3lnd2luL3RpbWVzLmNjIHwgMTEg
KystLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCAyMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L2hpcmVzLmggYi93aW5zdXAvY3lnd2luL2hpcmVzLmgKaW5kZXggODMxMWFk
MS4uOGEzMmI2NyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9oaXJlcy5o
CisrKyBiL3dpbnN1cC9jeWd3aW4vaGlyZXMuaApAQCAtMzQsMjYgKzM0LDE5
IEBAIGRldGFpbHMuICovCiAvKiAjIG9mIDEwMG5zIGludGVydmFscyBwZXIg
c2Vjb25kLiAqLwogI2RlZmluZSBOU1BFUlNFQyAxMDAwMDAwMExMCiAKLWNs
YXNzIGhpcmVzX2Jhc2UKLXsKLSBwcm90ZWN0ZWQ6Ci0gIGludCBpbml0ZWQ7
Ci0gcHVibGljOgotICB2b2lkIHJlc2V0KCkge2luaXRlZCA9IGZhbHNlO30K
LX07Ci0KLWNsYXNzIGhpcmVzX25zIDogcHVibGljIGhpcmVzX2Jhc2UKK2Ns
YXNzIGhpcmVzX25zCiB7CiAgIGRvdWJsZSBmcmVxOwotICB2b2lkIHByaW1l
ICgpOworICBib29sIGluaXRlZDsKICBwdWJsaWM6CisgIGhpcmVzX25zKCk7
CiAgIExPTkdMT05HIG5zZWNzICgpOwogICBMT05HTE9ORyB1c2VjcyAoKSB7
cmV0dXJuIG5zZWNzICgpIC8gMTAwMExMO30KICAgTE9OR0xPTkcgbXNlY3Mg
KCkge3JldHVybiBuc2VjcyAoKSAvIDEwMDAwMDBMTDt9CiAgIExPTkdMT05H
IHJlc29sdXRpb24oKTsKIH07CiAKLWNsYXNzIGhpcmVzX21zIDogcHVibGlj
IGhpcmVzX2Jhc2UKK2NsYXNzIGhpcmVzX21zCiB7CiAgcHVibGljOgogICBM
T05HTE9ORyBuc2VjcyAoKTsKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
dGltZXMuY2MgYi93aW5zdXAvY3lnd2luL3RpbWVzLmNjCmluZGV4IGNiNDk4
ZDcuLjIzNjUxOTMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vdGltZXMu
Y2MKKysrIGIvd2luc3VwL2N5Z3dpbi90aW1lcy5jYwpAQCAtMTQyLDcgKzE0
Miw2IEBAIHNldHRpbWVvZmRheSAoY29uc3Qgc3RydWN0IHRpbWV2YWwgKnR2
LCBjb25zdCBzdHJ1Y3QgdGltZXpvbmUgKnR6KQogICAgICAgc3Qud01pbGxp
c2Vjb25kcyA9IHR2LT50dl91c2VjIC8gMTAwMDsKIAogICAgICAgcmVzID0g
LSFTZXRTeXN0ZW1UaW1lICgmc3QpOwotICAgICAgZ3RvZC5yZXNldCAoKTsK
IAogICAgICAgaWYgKHJlcykKIAlzZXRfZXJybm8gKEVQRVJNKTsKQEAgLTQ3
MiwxNCArNDcxLDEyIEBAIGZ0aW1lIChzdHJ1Y3QgdGltZWIgKnRwKQogICBy
ZXR1cm4gMDsKIH0KIAotI2RlZmluZSBzdHVwaWRfcHJpbnRmIGlmIChjeWd3
aW5fZmluaXNoZWRfaW5pdGlhbGl6aW5nKSBkZWJ1Z19wcmludGYKLXZvaWQK
LWhpcmVzX25zOjpwcmltZSAoKQoraGlyZXNfbnM6OmhpcmVzX25zICgpCiB7
CiAgIExBUkdFX0lOVEVHRVIgaWZyZXE7CiAgIGlmICghUXVlcnlQZXJmb3Jt
YW5jZUZyZXF1ZW5jeSAoJmlmcmVxKSkKICAgICB7Ci0gICAgICBpbml0ZWQg
PSAtMTsKKyAgICAgIGluaXRlZCA9IGZhbHNlOwogICAgICAgcmV0dXJuOwog
ICAgIH0KIApAQCAtNDkxLDggKzQ4OCw2IEBAIExPTkdMT05HCiBoaXJlc19u
czo6bnNlY3MgKCkKIHsKICAgaWYgKCFpbml0ZWQpCi0gICAgcHJpbWUgKCk7
Ci0gIGlmIChpbml0ZWQgPCAwKQogICAgIHsKICAgICAgIHNldF9lcnJubyAo
RU5PU1lTKTsKICAgICAgIHJldHVybiAoTE9OR0xPTkcpIC0xOwpAQCAtNjQz
LDggKzYzOCw2IEBAIExPTkdMT05HCiBoaXJlc19uczo6cmVzb2x1dGlvbiAo
KQogewogICBpZiAoIWluaXRlZCkKLSAgICBwcmltZSAoKTsKLSAgaWYgKGlu
aXRlZCA8IDApCiAgICAgewogICAgICAgc2V0X2Vycm5vIChFTk9TWVMpOwog
ICAgICAgcmV0dXJuIChMT05HTE9ORykgLTE7Ci0tIAoxLjkuMQoK

--001a1141618c44150c052c13e176--
