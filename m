Return-Path: <cygwin-patches-return-7524-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23332 invoked by alias); 11 Oct 2011 16:46:07 -0000
Received: (qmail 23320 invoked by uid 22791); 11 Oct 2011 16:46:05 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 11 Oct 2011 16:45:51 +0000
Received: by ggnk4 with SMTP id k4so7380305ggn.2        for <cygwin-patches@cygwin.com>; Tue, 11 Oct 2011 09:45:50 -0700 (PDT)
Received: by 10.150.62.18 with SMTP id k18mr11130311yba.2.1318351550628; Tue, 11 Oct 2011 09:45:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.51.3 with HTTP; Tue, 11 Oct 2011 09:45:30 -0700 (PDT)
In-Reply-To: <20111010150443.GB30156@calimero.vinschen.de>
References: <1311042021.7348.26.camel@YAAKOV04> <20110719074343.GA15263@calimero.vinschen.de> <20111010150443.GB30156@calimero.vinschen.de>
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
Date: Tue, 11 Oct 2011 16:46:00 -0000
Message-ID: <CAGvSfewpkzdoGoKPzWz8KHPcSdCNc2tTqiK7KKjV9382MdZc3A@mail.gmail.com>
Subject: Re: [PATCH] add getconf(1)
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=000e0cd47bc6dd455304af08a351
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00014.txt.bz2


--000e0cd47bc6dd455304af08a351
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 387

On Mon, Oct 10, 2011 at 10:04, Corinna Vinschen wrote:
> what I didn't realize at the time was the fact that you didn't provide a
> documentation patch, too. =A0My latest patch to utils.sgml adds a short
> description for the getconf tool. =A0It's rather tight-lipped, so I'd
> appreciate if you could have a look and, perhaps, improve the text.

My apologies.  Patch attached.


Yaakov

--000e0cd47bc6dd455304af08a351
Content-Type: application/octet-stream; name="doc-getconf.patch"
Content-Disposition: attachment; filename="doc-getconf.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gtn4g7a70
Content-length: 2904

MjAxMS0xMC0xMSAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
Lj4KCgkqIHV0aWxzLnNnbWwgKGdldGNvbmYpOiBFeHBhbmQgZG9jdW1lbnRh
dGlvbi4KCkluZGV4OiB1dGlscy5zZ21sCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvdXRpbHMvdXRpbHMu
c2dtbCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45NQpkaWZmIC11IC1wIC1y
MS45NSB1dGlscy5zZ21sCi0tLSB1dGlscy5zZ21sCTEwIE9jdCAyMDExIDE0
OjU3OjQ4IC0wMDAwCTEuOTUKKysrIHV0aWxzLnNnbWwJMTEgT2N0IDIwMTEg
MTY6NDM6NTMgLTAwMDAKQEAgLTQ4NCwxNSArNDg0LDMxIEBAIE90aGVyIG9w
dGlvbnM6CiAKIDxwYXJhPlRoZSA8Y29tbWFuZD5nZXRjb25mPC9jb21tYW5k
PiB1dGlsaXR5IHByaW50cyB0aGUgdmFsdWUgb2YgdGhlCiBjb25maWd1cmF0
aW9uIHZhcmlhYmxlIHNwZWNpZmllZCBieSA8bGl0ZXJhbD52YXJpYWJsZV9u
YW1lPC9saXRlcmFsPi4KLUlmIDxsaXRlcmFsPnBhdGhuYW1lPC9saXRlcmFs
PiBpcyBnaXZlbiwgPGNvbW1hbmQ+Z2V0Y29uZjwvY29tbWFuZD4gcHJpbnRz
Ci10aGUgdmFsdWUgb2YgdGhlIGNvbmZpZ3VyYXRpb24gdmFyaWFibGUgZm9y
IHRoZSBzcGVjaWZpZWQgcGF0aG5hbWUuPC9wYXJhPgorSWYgbm8gPGxpdGVy
YWw+cGF0aG5hbWU8L2xpdGVyYWw+IGlzIGdpdmVuLCA8Y29tbWFuZD5nZXRj
b25mPC9jb21tYW5kPgorc2VydmVzIGFzIGEgd3JhcHBlciBmb3IgdGhlIDxs
aXRlcmFsPmNvbmZzdHI8L2xpdGVyYWw+IGFuZAorPGxpdGVyYWw+c3lzY29u
ZjwvbGl0ZXJhbD4gZnVuY3Rpb25zLCBzdXBwb3J0aW5nIHRoZSBzeW1ib2xp
YyBjb25zdGFudHMKK2RlZmluZWQgaW4gdGhlIDxsaXRlcmFsPmxpbWl0cy5o
PC9saXRlcmFsPiBhbmQgPGxpdGVyYWw+dW5pc3RkLmg8L2xpdGVyYWw+Cito
ZWFkZXJzLCB3aXRob3V0IHRoZWlyIHJlc3BlY3RpdmUgPGxpdGVyYWw+X0NT
XzwvbGl0ZXJhbD4gb3IKKzxsaXRlcmFsPl9TQ188L2xpdGVyYWw+IHByZWZp
eGVzLgorPC9wYXJhPgorCis8cGFyYT5JZiA8bGl0ZXJhbD5wYXRobmFtZTwv
bGl0ZXJhbD4gaXMgZ2l2ZW4sIDxjb21tYW5kPmdldGNvbmY8L2NvbW1hbmQ+
CitwcmludHMgdGhlIHZhbHVlIG9mIHRoZSBjb25maWd1cmF0aW9uIHZhcmlh
YmxlIGZvciB0aGUgc3BlY2lmaWVkIHBhdGhuYW1lLgorSW4gdGhpcyBmb3Jt
LCA8Y29tbWFuZD5nZXRjb25mPC9jb21tYW5kPiBzZXJ2ZXMgYXMgYSB3cmFw
cGVyIGZvciB0aGUKKzxsaXRlcmFsPnBhdGhjb25mPC9saXRlcmFsPiBmdW5j
dGlvbiwgc3VwcG9ydGluZyB0aGUgc3ltYm9saWMgY29uc3RhbnRzIGRlZmlu
ZWQKK2luIHRoZSA8bGl0ZXJhbD51bmlzdGQuaDwvbGl0ZXJhbD4gaGVhZGVy
LCB3aXRob3V0IHRoZSA8bGl0ZXJhbD5fUENfPC9saXRlcmFsPiAKK3ByZWZp
eC4gPC9wYXJhPgogCiA8cGFyYT5JZiB5b3Ugc3BlY2lmeSB0aGUgPGxpdGVy
YWw+LXY8L2xpdGVyYWw+IG9wdGlvbiwgdGhlIHBhcmFtZXRlcgogZGVub3Rl
cyBhIHNwZWNpZmljYXRpb24gZm9yIHdoaWNoIHRoZSB2YWx1ZSBvZiB0aGUg
Y29uZmlndXJhdGlvbiB2YXJpYWJsZQotc2hvdWxkIGJlIHByaW50ZWQuPC9w
YXJhPgorc2hvdWxkIGJlIHByaW50ZWQuIE5vdGUgdGhhdCB0aGUgb25seSBz
cGVjaWZpY2F0aW9ucyBzdXBwb3J0ZWQgYnkgQ3lnd2luCithcmUgPGxpdGVy
YWw+UE9TSVhfVjdfSUxQMzJfT0ZGQklHPC9saXRlcmFsPiBhbmQgdGhlIGxl
Z2FjeQorPGxpdGVyYWw+UE9TSVhfVjZfSUxQMzJfT0ZGQklHPC9saXRlcmFs
PiBhbmQKKzxsaXRlcmFsPlhCUzVfSUxQMzJfT0ZGQklHPC9saXRlcmFsPiBl
cXVpdmFsZW50cy48L3BhcmE+CiAKIDxwYXJhPlVzZSB0aGUgPGxpdGVyYWw+
LWE8L2xpdGVyYWw+IG9wdGlvbiB0byBwcmludCBhIGxpc3Qgb2YgYWxsIGF2
YWlsYWJsZQotY29uZmlndXJhdGlvbiB2YXJpYWJsZXMuPC9wYXJhPgorY29u
ZmlndXJhdGlvbiB2YXJpYWJsZXMgZm9yIHRoZSBzeXN0ZW0sIG9yIGdpdmVu
IDxsaXRlcmFsPnBhdGhuYW1lPC9saXRlcmFsPiwKK2FuZCB0aGVpciB2YWx1
ZXMuPC9wYXJhPgogCiA8L3NlY3QyPgogCg==

--000e0cd47bc6dd455304af08a351--
