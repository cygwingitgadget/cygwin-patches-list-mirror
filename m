Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 9A5673858D35
 for <cygwin-patches@cygwin.com>; Thu, 23 Dec 2021 23:10:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9A5673858D35
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 8D5C1CB59
 for <cygwin-patches@cygwin.com>; Thu, 23 Dec 2021 18:10:49 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 8A67FCB24
 for <cygwin-patches@cygwin.com>; Thu, 23 Dec 2021 18:10:49 -0500 (EST)
Date: Thu, 23 Dec 2021 15:10:49 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_pipe: add sanity limit to handle loops
Message-ID: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="14581413969920-1284947198-1640300937=:11760"
Content-ID: <alpine.BSO.2.21.2112231509170.11760@resin.csoft.net>
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 23 Dec 2021 23:10:52 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--14581413969920-1284947198-1640300937=:11760
Content-Type: text/plain; charset=US-ASCII
Content-ID: <alpine.BSO.2.21.2112231509171.11760@resin.csoft.net>

Attempt to avoid an exception I caught once in gdb, trying to debug
msys2/MSYS2-packages#2752.  Unfortunately I haven't been able to catch it
in the act again since, but with this change running on Windows on ARM64
has been more reliable than it had been.

---
 winsup/cygwin/fhandler_pipe.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc
b/winsup/cygwin/fhandler_pipe.cc
index ba6b70f55..48713a38d 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -1239,7 +1239,7 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
       if (!NT_SUCCESS (status))
        goto close_proc;

-      for (ULONG j = 0; j < phi->NumberOfHandles; j++)
+      for (ULONG j = 0; j < min(phi->NumberOfHandles, n_handle); j++)
        {
          /* Check for the peculiarity of cygwin read pipe */
          const ULONG access = FILE_READ_DATA | FILE_READ_EA
@@ -1309,7 +1309,7 @@ fhandler_pipe::get_query_hdl_per_system (WCHAR *name,
   if (!NT_SUCCESS (status))
     return NULL;

-  for (LONG i = (LONG) shi->NumberOfHandles - 1; i >= 0; i--)
+  for (LONG i = (LONG) min(shi->NumberOfHandles, n_handle) - 1; i >= 0; i--)
     {
       /* Check for the peculiarity of cygwin read pipe */
       const ULONG access = FILE_READ_DATA | FILE_READ_EA
--
2.34.1.windows.1


--14581413969920-1284947198-1640300937=:11760
Content-Type: text/plain; charset=US-ASCII; name=0001-fhandler_pipe-add-sanity-limit-to-handle-loops.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2112231508570.11760@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0001-fhandler_pipe-add-sanity-limit-to-handle-loops.patch

RnJvbSBhYmE4MzAxNTBlYmIxNzA3YzY2YWNkYWQ4MjU0NzI4YzVmOTYyNzA1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFRodSwgMjMgRGVjIDIwMjEg
MTI6MjI6NDYgLTA4MDANClN1YmplY3Q6IFtQQVRDSF0gZmhhbmRsZXJfcGlw
ZTogYWRkIHNhbml0eSBsaW1pdCB0byBoYW5kbGUgbG9vcHMNCg0KQXR0ZW1w
dCB0byBhdm9pZCBhbiBleGNlcHRpb24gSSBjYXVnaHQgb25jZSBpbiBnZGIs
IHRyeWluZyB0byBkZWJ1ZyBtc3lzMi9NU1lTMi1wYWNrYWdlcyMyNzUyDQot
LS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3BpcGUuY2MgfCA0ICsrLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9w
aXBlLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9waXBlLmNjDQppbmRl
eCBiYTZiNzBmNTUuLjQ4NzEzYTM4ZCAxMDA2NDQNCi0tLSBhL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfcGlwZS5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9m
aGFuZGxlcl9waXBlLmNjDQpAQCAtMTIzOSw3ICsxMjM5LDcgQEAgZmhhbmRs
ZXJfcGlwZTo6Z2V0X3F1ZXJ5X2hkbF9wZXJfcHJvY2VzcyAoV0NIQVIgKm5h
bWUsDQogICAgICAgaWYgKCFOVF9TVUNDRVNTIChzdGF0dXMpKQ0KIAlnb3Rv
IGNsb3NlX3Byb2M7DQogDQotICAgICAgZm9yIChVTE9ORyBqID0gMDsgaiA8
IHBoaS0+TnVtYmVyT2ZIYW5kbGVzOyBqKyspDQorICAgICAgZm9yIChVTE9O
RyBqID0gMDsgaiA8IG1pbihwaGktPk51bWJlck9mSGFuZGxlcywgbl9oYW5k
bGUpOyBqKyspDQogCXsNCiAJICAvKiBDaGVjayBmb3IgdGhlIHBlY3VsaWFy
aXR5IG9mIGN5Z3dpbiByZWFkIHBpcGUgKi8NCiAJICBjb25zdCBVTE9ORyBh
Y2Nlc3MgPSBGSUxFX1JFQURfREFUQSB8IEZJTEVfUkVBRF9FQQ0KQEAgLTEz
MDksNyArMTMwOSw3IEBAIGZoYW5kbGVyX3BpcGU6OmdldF9xdWVyeV9oZGxf
cGVyX3N5c3RlbSAoV0NIQVIgKm5hbWUsDQogICBpZiAoIU5UX1NVQ0NFU1Mg
KHN0YXR1cykpDQogICAgIHJldHVybiBOVUxMOw0KIA0KLSAgZm9yIChMT05H
IGkgPSAoTE9ORykgc2hpLT5OdW1iZXJPZkhhbmRsZXMgLSAxOyBpID49IDA7
IGktLSkNCisgIGZvciAoTE9ORyBpID0gKExPTkcpIG1pbihzaGktPk51bWJl
ck9mSGFuZGxlcywgbl9oYW5kbGUpIC0gMTsgaSA+PSAwOyBpLS0pDQogICAg
IHsNCiAgICAgICAvKiBDaGVjayBmb3IgdGhlIHBlY3VsaWFyaXR5IG9mIGN5
Z3dpbiByZWFkIHBpcGUgKi8NCiAgICAgICBjb25zdCBVTE9ORyBhY2Nlc3Mg
PSBGSUxFX1JFQURfREFUQSB8IEZJTEVfUkVBRF9FQQ0KLS0gDQoyLjM0LjEu
d2luZG93cy4xDQoNCg==

--14581413969920-1284947198-1640300937=:11760--
