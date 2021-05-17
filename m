Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id BA3883853809
 for <cygwin-patches@cygwin.com>; Mon, 17 May 2021 19:15:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BA3883853809
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 6CF1FCB52
 for <cygwin-patches@cygwin.com>; Mon, 17 May 2021 15:15:59 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 5BB3DCB4B
 for <cygwin-patches@cygwin.com>; Mon, 17 May 2021 15:15:59 -0400 (EDT)
Date: Mon, 17 May 2021 12:15:59 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add support for high-entropy-va flag to peflags.
In-Reply-To: <YKJLZE/QFQotdkQw@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2105171213390.14962@resin.csoft.net>
References: <alpine.WNT.2.22.394.2105151214260.7536@persephone>
 <YKJLZE/QFQotdkQw@calimero.vinschen.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="9191230013440-97692182-1621278959=:14962"
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 17 May 2021 19:16:02 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--9191230013440-97692182-1621278959=:14962
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 May 2021, Corinna Vinschen wrote:

> Hi Jeremy,
>
> Thanks for the patch, but I have two nits:
>
> - The patch doesn't apply cleanly with `git am'.  Please check again.

Probably got mangled in the mail.  Attached this time.

>
> - I would prefer a massively reduced patch size, by *not* changing
>   indentation on otherwise unaffected lines.
>

Done
--9191230013440-97692182-1621278959=:14962
Content-Type: text/plain; charset=US-ASCII; name=0001-Add-support-for-high-entropy-va-flag-to-peflags.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2105171215590.14962@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0001-Add-support-for-high-entropy-va-flag-to-peflags.patch

RnJvbSAyNmU3ZDcxNmI1ZWNjNDljYzJlOGQ1YWIwNWExNTg2YzA4OWM3NWZl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFNhdCwgMTUgTWF5IDIwMjEg
MTI6MDc6MjYgLTA3MDANClN1YmplY3Q6IFtQQVRDSF0gQWRkIHN1cHBvcnQg
Zm9yIGhpZ2gtZW50cm9weS12YSBmbGFnIHRvIHBlZmxhZ3MuDQoNClRoaXMg
YWxsb3dzIGZvciBzZXR0aW5nLCBjbGVhcmluZywgYW5kIGRpc3BsYXlpbmcg
dGhlIHZhbHVlIG9mIHRoZSAiaGlnaA0KZW50cm9weSB2YSIgZGxsIGNoYXJh
Y3RlcmlzdGljcyBmbGFnLg0KDQpTaWduZWQtb2ZmLWJ5OiBKZXJlbXkgRHJh
a2UgPGN5Z3dpbkBqZHJha2UuY29tPg0KLS0tDQogcGVmbGFncy5jIHwgMTMg
KysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvcGVmbGFncy5j
IGIvcGVmbGFncy5jDQppbmRleCA0ZDIyZTRhLi5iYjMzM2Q3IDEwMDY0NA0K
LS0tIGEvcGVmbGFncy5jDQorKysgYi9wZWZsYWdzLmMNCkBAIC0xMTIsNyAr
MTEyLDcgQEAgc3RhdGljIGNvbnN0IHN5bWJvbGljX2ZsYWdzX3QgcGVfc3lt
Ym9saWNfZmxhZ3NbXSA9IHsNCiAvKkNGKDB4MDAwNCwgcmVzZXJ2ZWRfMHgw
MDA0KSwqLw0KIC8qQ0YoMHgwMDA4LCByZXNlcnZlZF8weDAwMDgpLCovDQog
LypDRigweDAwMTAsIHVuc3BlY18weDAwMTApLCovDQotLypDRigweDAwMjAs
IHVuc3BlY18weDAwMjApLCovDQorICBDRigweDAwMjAsIGhpZ2gtZW50cm9w
eS12YSksDQogICBDRigweDAwNDAsIGR5bmFtaWNiYXNlKSwNCiAgIENGKDB4
MDA4MCwgZm9yY2VpbnRlZyksDQogICBDRigweDAxMDAsIG54Y29tcGF0KSwN
CkBAIC0xODEsNiArMTgxLDcgQEAgc2l6ZW9mX3ZhbHVlc190IHNpemVvZl92
YWxzWzVdID0gew0KIA0KIHN0YXRpYyBzdHJ1Y3Qgb3B0aW9uIGxvbmdfb3B0
aW9uc1tdID0gew0KICAgeyJkeW5hbWljYmFzZSIsICBvcHRpb25hbF9hcmd1
bWVudCwgTlVMTCwgJ2QnfSwNCisgIHsiaGlnaC1lbnRyb3B5LXZhIiwgb3B0
aW9uYWxfYXJndW1lbnQsIE5VTEwsICdlJ30sDQogICB7ImZvcmNlaW50ZWci
LCAgIG9wdGlvbmFsX2FyZ3VtZW50LCBOVUxMLCAnZid9LA0KICAgeyJueGNv
bXBhdCIsICAgICBvcHRpb25hbF9hcmd1bWVudCwgTlVMTCwgJ24nfSwNCiAg
IHsibm8taXNvbGF0aW9uIiwgb3B0aW9uYWxfYXJndW1lbnQsIE5VTEwsICdp
J30sDQpAQCAtMjAzLDcgKzIwNCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb3B0aW9u
IGxvbmdfb3B0aW9uc1tdID0gew0KICAge05VTEwsIG5vX2FyZ3VtZW50LCBO
VUxMLCAwfQ0KIH07DQogc3RhdGljIGNvbnN0IGNoYXIgKnNob3J0X29wdGlv
bnMNCi0JPSAiZDo6Zjo6bjo6aTo6czo6Yjo6Vzo6dDo6dzo6bDo6Uzo6eDo6
WDo6eTo6WTo6ejo6VDp2aFYiOw0KKwk9ICJkOjplOjpmOjpuOjppOjpzOjpi
OjpXOjp0Ojp3OjpsOjpTOjp4OjpYOjp5OjpZOjp6OjpUOnZoViI7DQogDQog
c3RhdGljIHZvaWQgc2hvcnRfdXNhZ2UgKEZJTEUgKmYpOw0KIHN0YXRpYyB2
b2lkIGhlbHAgKEZJTEUgKmYpOw0KQEAgLTY5OSw2ICs3MDAsMTEgQEAgcGFy
c2VfYXJncyAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCiAJICAgICAgICAg
ICAgICAgICAgICAgICAgIG9wdGFyZywNCiAJICAgICAgICAgICAgICAgICAg
ICAgICAgIElNQUdFX0RMTENIQVJBQ1RFUklTVElDU19EWU5BTUlDX0JBU0Up
Ow0KIAkgIGJyZWFrOw0KKwljYXNlICdlJzoNCisJICBoYW5kbGVfcGVfZmxh
Z19vcHRpb24gKGxvbmdfb3B0aW9uc1tvcHRpb25faW5kZXhdLm5hbWUsDQor
CSAgICAgICAgICAgICAgICAgICAgICAgICBvcHRhcmcsDQorCSAgICAgICAg
ICAgICAgICAgICAgICAgICBJTUFHRV9ETExDSEFSQUNURVJJU1RJQ1NfSElH
SF9FTlRST1BZX1ZBKTsNCisJICBicmVhazsNCiAJY2FzZSAnbic6DQogCSAg
aGFuZGxlX3BlX2ZsYWdfb3B0aW9uIChsb25nX29wdGlvbnNbb3B0aW9uX2lu
ZGV4XS5uYW1lLA0KIAkgICAgICAgICAgICAgICAgICAgICAgICAgb3B0YXJn
LA0KQEAgLTEwNjksNiArMTA3NSw5IEBAIGhlbHAgKEZJTEUgKmYpDQogIlxu
Ig0KICIgIC1kLCAtLWR5bmFtaWNiYXNlICBbQk9PTF0gICBJbWFnZSBiYXNl
IGFkZHJlc3MgbWF5IGJlIHJlbG9jYXRlZCB1c2luZ1xuIg0KICIgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGRyZXNzIHNwYWNlIGxheW91dCBy
YW5kb21pemF0aW9uIChBU0xSKS5cbiINCisiICAtZSxcbiINCisiICAtLWhp
Z2gtZW50cm9weS12YSAgW0JPT0xdICAgSW1hZ2UgaXMgY29tcGF0aWJsZSB3
aXRoIDY0LWJpdCBhZGRyZXNzIHNwYWNlXG4iDQorIiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGxheW91dCByYW5kb21pemF0aW9uIChBU0xSKS5c
biINCiAiICAtZiwgLS1mb3JjZWludGVnICAgW0JPT0xdICAgQ29kZSBpbnRl
Z3JpdHkgY2hlY2tzIGFyZSBlbmZvcmNlZC5cbiINCiAiICAtbiwgLS1ueGNv
bXBhdCAgICAgW0JPT0xdICAgSW1hZ2UgaXMgY29tcGF0aWJsZSB3aXRoIGRh
dGEgZXhlY3V0aW9uXG4iDQogIiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHByZXZlbnRpb24gKERFUCkuXG4iDQotLSANCjIuMzEuMS53aW5kb3dz
LjENCg0K

--9191230013440-97692182-1621278959=:14962--
