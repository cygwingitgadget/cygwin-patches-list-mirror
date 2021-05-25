Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id A30B1385803D
 for <cygwin-patches@cygwin.com>; Tue, 25 May 2021 23:36:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A30B1385803D
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 7F6D2CB58
 for <cygwin-patches@cygwin.com>; Tue, 25 May 2021 19:36:38 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 6EB7FCB52
 for <cygwin-patches@cygwin.com>; Tue, 25 May 2021 19:36:38 -0400 (EDT)
Date: Tue, 25 May 2021 16:36:38 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygdrop: fix return type of usageCore
Message-ID: <alpine.BSO.2.21.2105251635120.14962@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="9191230013440-1361337281-1621985576=:14962"
Content-ID: <alpine.BSO.2.21.2105251635121.14962@resin.csoft.net>
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 25 May 2021 23:36:39 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--9191230013440-1361337281-1621985576=:14962
Content-Type: text/plain; charset=US-ASCII
Content-ID: <alpine.BSO.2.21.2105251635122.14962@resin.csoft.net>

Fixes a warning "no return statement in function returning non-void",
and solves a crash running --help.
--9191230013440-1361337281-1621985576=:14962
Content-Type: text/plain; charset=US-ASCII; name=0001-cygdrop-fix-return-type-of-usageCore.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2105251632561.14962@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0001-cygdrop-fix-return-type-of-usageCore.patch

RnJvbSBmNDgyMWRiMjRkNGU0ZmVjYTE2ZTRhZWE1ODg0MzEyOGUyMzNlZjRl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFR1ZSwgMjUgTWF5IDIwMjEg
MTY6MTM6MTcgLTA3MDANClN1YmplY3Q6IFtQQVRDSF0gY3lnZHJvcDogZml4
IHJldHVybiB0eXBlIG9mIHVzYWdlQ29yZQ0KDQpGaXhlcyBhIHdhcm5pbmcg
Im5vIHJldHVybiBzdGF0ZW1lbnQgaW4gZnVuY3Rpb24gcmV0dXJuaW5nIG5v
bi12b2lkIiwNCmFuZCBzb2x2ZXMgYSBjcmFzaCBydW5uaW5nIC0taGVscC4N
Ci0tLQ0KIHNyYy9jeWdkcm9wL2N5Z2Ryb3AuY2MgfCAyICstDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9zcmMvY3lnZHJvcC9jeWdkcm9wLmNjIGIvc3JjL2N5Z2Ry
b3AvY3lnZHJvcC5jYw0KaW5kZXggMzViY2MxOS4uZGM0MDNjOSAxMDA2NDQN
Ci0tLSBhL3NyYy9jeWdkcm9wL2N5Z2Ryb3AuY2MNCisrKyBiL3NyYy9jeWdk
cm9wL2N5Z2Ryb3AuY2MNCkBAIC0zOSw3ICszOSw3IEBAIHN0YXRpYyB2b2lk
IGhlbHAgKEZJTEUgKiBmLCBjb25zdCBjaGFyICpuYW1lKTsNCiBzdGF0aWMg
dm9pZCB2ZXJzaW9uIChGSUxFICogZiwgY29uc3QgY2hhciAqbmFtZSk7DQog
c3RhdGljIHZvaWQgbGljZW5zZSAoRklMRSAqIGYsIGNvbnN0IGNoYXIgKm5h
bWUpOw0KIA0KLXN0YXRpYyBpbnQNCitzdGF0aWMgdm9pZA0KIHVzYWdlQ29y
ZSAoRklMRSAqIGYsIGNvbnN0IGNoYXIgKiBuYW1lKQ0KIHsNCiAgIGZwcmlu
dGYgKGYsDQotLSANCjIuMzEuMQ0KDQo=

--9191230013440-1361337281-1621985576=:14962--
