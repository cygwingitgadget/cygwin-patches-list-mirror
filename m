Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 133473892445
 for <cygwin-patches@cygwin.com>; Sun, 30 May 2021 19:58:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 133473892445
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 72109CB56
 for <cygwin-patches@cygwin.com>; Sun, 30 May 2021 15:58:30 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 61941CB55
 for <cygwin-patches@cygwin.com>; Sun, 30 May 2021 15:58:30 -0400 (EDT)
Date: Sun, 30 May 2021 12:58:30 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
In-Reply-To: <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
Message-ID: <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="28205050232832-1075604823-1622402219=:30039"
Content-ID: <alpine.BSO.2.21.2105301254460.30039@resin.csoft.net>
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 30 May 2021 19:58:33 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--28205050232832-1075604823-1622402219=:30039
Content-Type: text/plain; charset=US-ASCII
Content-ID: <alpine.BSO.2.21.2105301254461.30039@resin.csoft.net>

First, revert the handling of virtual drives as non-symlinks.  This is no
longer necessary.

The new GetFinalPathNameW handling for native symlinks in inner path
components is disabled if caller doesn't want to follow symlinks, or
doesn't want to follow reparse points.  Set flag to not follow reparse
points in chdir, allowing native processes to see their cwd potentially
including native symlinks, rather than dereferencing them.
---

For v2, I realized the PC_SYM_NOFOLLOW_REP flag was supposed to do this,
and that lack of PC_SYM_FOLLOW was not being respected either.  With this,
and patching `pwd -P` to `pwd` in makepkg, the long-named package builds
successfully.  I did not re-indent the code for the addition of the if due
to having learned from my patch to rebase, but it looks kind of ugly.

 winsup/cygwin/path.cc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index e62f8fe2b..2ce5aef81 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -722,9 +722,9 @@ path_conv::check (const char *src, unsigned opt,
 	  int symlen = 0;

 	  /* Make sure to check certain flags on last component only. */
-	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE);
+	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE | PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP);
 	       ;
-	       pc_flags = 0)
+	       pc_flags = opt & (PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP))
 	    {
 	      const suffix_info *suff;
 	      char *full_path;
@@ -3452,6 +3452,8 @@ restart:
 	    break;
 	}

+      if ((pc_flags & (PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP)) == PC_SYM_FOLLOW)
+      {
       /* Check if the inner path components contain native symlinks or
 	 junctions, or if the drive is a virtual drive.  Compare incoming
 	 path with path returned by GetFinalPathNameByHandleA.  If they
@@ -3522,6 +3524,7 @@ restart:
 	      }
 	  }
       }
+      }

     /* Normal file. */
     file_not_symlink:
@@ -3704,7 +3707,7 @@ chdir (const char *in_dir)

       /* Convert path.  PC_NONULLEMPTY ensures that we don't check for
 	 NULL/empty/invalid again. */
-      path_conv path (in_dir, PC_SYM_FOLLOW | PC_POSIX | PC_NONULLEMPTY);
+      path_conv path (in_dir, PC_SYM_FOLLOW | PC_POSIX | PC_NONULLEMPTY | PC_SYM_NOFOLLOW_REP);
       if (path.error)
 	{
 	  set_errno (path.error);
-- 
2.31.1.windows.1
--28205050232832-1075604823-1622402219=:30039
Content-Type: text/plain; charset=US-ASCII; name=0001-Revert-Cygwin-Handle-virtual-drives-as-non-symlinks.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2105301216590.30039@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0001-Revert-Cygwin-Handle-virtual-drives-as-non-symlinks.patch

RnJvbSA0YmI5NTliNTc2MDY0NjVkNWE3YWJlN2QzYWUxNjhkYjY2ZjVmNmZh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFNhdCwgMjkgTWF5IDIwMjEg
MTM6MTc6MDggLTA3MDANClN1YmplY3Q6IFtQQVRDSCAxLzJdIFJldmVydCAi
Q3lnd2luOiBIYW5kbGUgdmlydHVhbCBkcml2ZXMgYXMgbm9uLXN5bWxpbmtz
Ig0KDQpUaGlzIHJldmVydHMgY29tbWl0IGM4OTQ5ZDA0MDAxZTNkYmMwMzY1
MTQ3NWI2Y2QxYzU2MjM0MDA4MzUuDQotLS0NCiB3aW5zdXAvY3lnd2luL3Bh
dGguY2MgfCA5ICsrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL3BhdGguY2MgYi93aW5zdXAvY3lnd2luL3BhdGguY2MNCmlu
ZGV4IDZhMDdmMGQwNi4uZTYyZjhmZTJiIDEwMDY0NA0KLS0tIGEvd2luc3Vw
L2N5Z3dpbi9wYXRoLmNjDQorKysgYi93aW5zdXAvY3lnd2luL3BhdGguY2MN
CkBAIC0zNTA1LDkgKzM1MDUsMTQgQEAgcmVzdGFydDoNCiANCiAJCSAgICAg
c3Vic3QgWDogQzpcZm9vXGJhcg0KIA0KLQkJICAgVHJlYXQgaXQgYXMgYSBu
b3JtYWwgZmlsZS4gKi8NCisJCSAgIFRyZWF0IGl0IGxpa2UgYSBzeW1saW5r
LiAgVGhpcyBpcyByZXF1aXJlZCB0byB0ZWxsIGFuDQorCQkgICBsc3RhdCBj
YWxsZXIgdGhhdCB0aGUgImRyaXZlIiBpcyBhY3R1YWxseSBwb2ludGluZw0K
KwkJICAgc29tZXdoZXJlIGVsc2UsIHRodXMsIGl0J3MgYSBzeW1saW5rIGlu
IFBPU0lYIHNwZWFrLiAqLw0KIAkJaWYgKHVwYXRoLkxlbmd0aCA9PSAxNCkJ
LyogXD8/XFg6XCAqLw0KLQkJICBnb3RvIGZpbGVfbm90X3N5bWxpbms7DQor
CQkgIHsNCisJCSAgICBmaWxlYXR0ciAmPSB+RklMRV9BVFRSSUJVVEVfRElS
RUNUT1JZOw0KKwkJICAgIHBhdGhfZmxhZ3MgfD0gUEFUSF9TWU1MSU5LOw0K
KwkJICB9DQogCQkvKiBGb3IgZmluYWwgcGF0aHMgZGlmZmVyaW5nIGluIGlu
bmVyIHBhdGggY29tcG9uZW50cyByZXR1cm4NCiAJCSAgIGxlbmd0aCBhcyBu
ZWdhdGl2ZSB2YWx1ZS4gIFRoaXMgaW5mb3JtcyBwYXRoX2NvbnY6OmNoZWNr
DQogCQkgICB0byBza2lwIHJlYWxwYXRoIGhhbmRsaW5nIG9uIHRoZSBsYXN0
IHBhdGggY29tcG9uZW50LiAqLw0KLS0gDQoyLjMxLjEud2luZG93cy4xDQoN
Cg==

--28205050232832-1075604823-1622402219=:30039
Content-Type: text/plain; charset=US-ASCII; name=0002-Cygwin-respect-PC_SYM_FOLLOW-and-PC_SYM_NOFOLLOW_REP.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2105301216591.30039@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0002-Cygwin-respect-PC_SYM_FOLLOW-and-PC_SYM_NOFOLLOW_REP.patch

RnJvbSA5YTFkODY4YzNlMDI3NDE2ODc2ZDliZDExMDE2MTU2MmY4Yjc3YjBh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFNhdCwgMjkgTWF5IDIwMjEg
MTE6NDg6MTEgLTA3MDANClN1YmplY3Q6IFtQQVRDSCAyLzJdIEN5Z3dpbjog
cmVzcGVjdCBQQ19TWU1fRk9MTE9XIGFuZCBQQ19TWU1fTk9GT0xMT1dfUkVQ
DQogd2l0aCBpbm5lciBsaW5rcy4NCg0KVGhlIG5ldyBHZXRGaW5hbFBhdGhO
YW1lVyBoYW5kbGluZyBmb3IgbmF0aXZlIHN5bWxpbmtzIGluIGlubmVyIHBh
dGgNCmNvbXBvbmVudHMgaXMgZGlzYWJsZWQgaWYgY2FsbGVyIGRvZXNuJ3Qg
d2FudCB0byBmb2xsb3cgc3ltbGlua3MsIG9yDQpkb2Vzbid0IHdhbnQgdG8g
Zm9sbG93IHJlcGFyc2UgcG9pbnRzLiAgU2V0IGZsYWcgdG8gbm90IGZvbGxv
dyByZXBhcnNlDQpwb2ludHMgaW4gY2hkaXIsIGFsbG93aW5nIG5hdGl2ZSBw
cm9jZXNzZXMgdG8gc2VlIHRoZWlyIGN3ZCBwb3RlbnRpYWxseQ0KaW5jbHVk
aW5nIG5hdGl2ZSBzeW1saW5rcywgcmF0aGVyIHRoYW4gZGVyZWZlcmVuY2lu
ZyB0aGVtLg0KLS0tDQogd2luc3VwL2N5Z3dpbi9wYXRoLmNjIHwgOSArKysr
KystLS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9wYXRo
LmNjIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjDQppbmRleCBlNjJmOGZlMmIu
LjJjZTVhZWY4MSAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vcGF0aC5j
Yw0KKysrIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjDQpAQCAtNzIyLDkgKzcy
Miw5IEBAIHBhdGhfY29udjo6Y2hlY2sgKGNvbnN0IGNoYXIgKnNyYywgdW5z
aWduZWQgb3B0LA0KIAkgIGludCBzeW1sZW4gPSAwOw0KIA0KIAkgIC8qIE1h
a2Ugc3VyZSB0byBjaGVjayBjZXJ0YWluIGZsYWdzIG9uIGxhc3QgY29tcG9u
ZW50IG9ubHkuICovDQotCSAgZm9yICh1bnNpZ25lZCBwY19mbGFncyA9IG9w
dCAmIChQQ19OT19BQ0NFU1NfQ0hFQ0sgfCBQQ19LRUVQX0hBTkRMRSk7DQor
CSAgZm9yICh1bnNpZ25lZCBwY19mbGFncyA9IG9wdCAmIChQQ19OT19BQ0NF
U1NfQ0hFQ0sgfCBQQ19LRUVQX0hBTkRMRSB8IFBDX1NZTV9GT0xMT1cgfCBQ
Q19TWU1fTk9GT0xMT1dfUkVQKTsNCiAJICAgICAgIDsNCi0JICAgICAgIHBj
X2ZsYWdzID0gMCkNCisJICAgICAgIHBjX2ZsYWdzID0gb3B0ICYgKFBDX1NZ
TV9GT0xMT1cgfCBQQ19TWU1fTk9GT0xMT1dfUkVQKSkNCiAJICAgIHsNCiAJ
ICAgICAgY29uc3Qgc3VmZml4X2luZm8gKnN1ZmY7DQogCSAgICAgIGNoYXIg
KmZ1bGxfcGF0aDsNCkBAIC0zNDUyLDYgKzM0NTIsOCBAQCByZXN0YXJ0Og0K
IAkgICAgYnJlYWs7DQogCX0NCiANCisgICAgICBpZiAoKHBjX2ZsYWdzICYg
KFBDX1NZTV9GT0xMT1cgfCBQQ19TWU1fTk9GT0xMT1dfUkVQKSkgPT0gUENf
U1lNX0ZPTExPVykNCisgICAgICB7DQogICAgICAgLyogQ2hlY2sgaWYgdGhl
IGlubmVyIHBhdGggY29tcG9uZW50cyBjb250YWluIG5hdGl2ZSBzeW1saW5r
cyBvcg0KIAkganVuY3Rpb25zLCBvciBpZiB0aGUgZHJpdmUgaXMgYSB2aXJ0
dWFsIGRyaXZlLiAgQ29tcGFyZSBpbmNvbWluZw0KIAkgcGF0aCB3aXRoIHBh
dGggcmV0dXJuZWQgYnkgR2V0RmluYWxQYXRoTmFtZUJ5SGFuZGxlQS4gIElm
IHRoZXkNCkBAIC0zNTIyLDYgKzM1MjQsNyBAQCByZXN0YXJ0Og0KIAkgICAg
ICB9DQogCSAgfQ0KICAgICAgIH0NCisgICAgICB9DQogDQogICAgIC8qIE5v
cm1hbCBmaWxlLiAqLw0KICAgICBmaWxlX25vdF9zeW1saW5rOg0KQEAgLTM3
MDQsNyArMzcwNyw3IEBAIGNoZGlyIChjb25zdCBjaGFyICppbl9kaXIpDQog
DQogICAgICAgLyogQ29udmVydCBwYXRoLiAgUENfTk9OVUxMRU1QVFkgZW5z
dXJlcyB0aGF0IHdlIGRvbid0IGNoZWNrIGZvcg0KIAkgTlVMTC9lbXB0eS9p
bnZhbGlkIGFnYWluLiAqLw0KLSAgICAgIHBhdGhfY29udiBwYXRoIChpbl9k
aXIsIFBDX1NZTV9GT0xMT1cgfCBQQ19QT1NJWCB8IFBDX05PTlVMTEVNUFRZ
KTsNCisgICAgICBwYXRoX2NvbnYgcGF0aCAoaW5fZGlyLCBQQ19TWU1fRk9M
TE9XIHwgUENfUE9TSVggfCBQQ19OT05VTExFTVBUWSB8IFBDX1NZTV9OT0ZP
TExPV19SRVApOw0KICAgICAgIGlmIChwYXRoLmVycm9yKQ0KIAl7DQogCSAg
c2V0X2Vycm5vIChwYXRoLmVycm9yKTsNCi0tIA0KMi4zMS4xLndpbmRvd3Mu
MQ0KDQo=

--28205050232832-1075604823-1622402219=:30039--
