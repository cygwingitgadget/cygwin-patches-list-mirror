Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 5B5CB384B801
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 17:40:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5B5CB384B801
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 32BD2CB61
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 13:40:19 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 21F63CB5E
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 13:40:19 -0400 (EDT)
Date: Tue, 6 Jul 2021 10:40:19 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v4] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
In-Reply-To: <YORvS4cn1fQX3O70@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2107061038250.56404@resin.csoft.net>
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
 <alpine.BSO.2.21.2106031321380.30039@resin.csoft.net>
 <alpine.BSO.2.21.2106031355540.30039@resin.csoft.net>
 <YORvS4cn1fQX3O70@calimero.vinschen.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1891484557-1625593219=:56404"
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 06 Jul 2021 17:40:22 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1891484557-1625593219=:56404
Content-Type: text/plain; charset=US-ASCII

The new GetFinalPathNameW handling for native symlinks in inner path
components is disabled if caller doesn't want to follow symlinks, or
doesn't want to follow reparse points.
---
 winsup/cygwin/path.cc | 88 ++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index e62f8fe2b..1869fb8c8 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -722,9 +722,10 @@ path_conv::check (const char *src, unsigned opt,
 	  int symlen = 0;

 	  /* Make sure to check certain flags on last component only. */
-	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE);
+	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE
+					 | PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP);
 	       ;
-	       pc_flags = 0)
+	       pc_flags = opt & (PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP))
 	    {
 	      const suffix_info *suff;
 	      char *full_path;
@@ -3480,48 +3481,49 @@ restart:
 	    goto file_not_symlink;
 	}
 #endif /* __i386__ */
-      {
-	PWCHAR fpbuf = tp.w_get ();
-	DWORD ret;
-
-	ret = GetFinalPathNameByHandleW (h, fpbuf, NT_MAX_PATH, 0);
-	if (ret)
-	  {
-	    UNICODE_STRING fpath;
+      if ((pc_flags & (PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP)) == PC_SYM_FOLLOW)
+	{
+	  PWCHAR fpbuf = tp.w_get ();
+	  DWORD ret;

-	    RtlInitCountedUnicodeString (&fpath, fpbuf, ret * sizeof (WCHAR));
-	    fpbuf[1] = L'?';	/* \\?\ --> \??\ */
-	    if (!RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
-	      {
-		issymlink = true;
-		/* upath.Buffer is big enough and unused from this point on.
-		   Reuse it here, avoiding yet another buffer allocation. */
-		char *nfpath = (char *) upath.Buffer;
-		sys_wcstombs (nfpath, NT_MAX_PATH, fpbuf);
-		res = posixify (nfpath);
-
-		/* If the incoming path consisted of a drive prefix only,
-		   we just handle a virtual drive, created with, e.g.
-
-		     subst X: C:\foo\bar
-
-		   Treat it like a symlink.  This is required to tell an
-		   lstat caller that the "drive" is actually pointing
-		   somewhere else, thus, it's a symlink in POSIX speak. */
-		if (upath.Length == 14)	/* \??\X:\ */
-		  {
-		    fileattr &= ~FILE_ATTRIBUTE_DIRECTORY;
-		    path_flags |= PATH_SYMLINK;
-		  }
-		/* For final paths differing in inner path components return
-		   length as negative value.  This informs path_conv::check
-		   to skip realpath handling on the last path component. */
-		else
-		  res = -res;
-		break;
-	      }
-	  }
-      }
+	  ret = GetFinalPathNameByHandleW (h, fpbuf, NT_MAX_PATH, 0);
+	  if (ret)
+	    {
+	      UNICODE_STRING fpath;
+
+	      RtlInitCountedUnicodeString (&fpath, fpbuf, ret * sizeof (WCHAR));
+	      fpbuf[1] = L'?';	/* \\?\ --> \??\ */
+	      if (!RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
+	        {
+		  issymlink = true;
+		  /* upath.Buffer is big enough and unused from this point on.
+		     Reuse it here, avoiding yet another buffer allocation. */
+		  char *nfpath = (char *) upath.Buffer;
+		  sys_wcstombs (nfpath, NT_MAX_PATH, fpbuf);
+		  res = posixify (nfpath);
+
+		  /* If the incoming path consisted of a drive prefix only,
+		     we just handle a virtual drive, created with, e.g.
+
+		       subst X: C:\foo\bar
+
+		     Treat it like a symlink.  This is required to tell an
+		     lstat caller that the "drive" is actually pointing
+		     somewhere else, thus, it's a symlink in POSIX speak. */
+		  if (upath.Length == 14)	/* \??\X:\ */
+		    {
+		      fileattr &= ~FILE_ATTRIBUTE_DIRECTORY;
+		      path_flags |= PATH_SYMLINK;
+		    }
+		  /* For final paths differing in inner path components return
+		     length as negative value.  This informs path_conv::check
+		     to skip realpath handling on the last path component. */
+		  else
+		    res = -res;
+		  break;
+	        }
+	    }
+	}

     /* Normal file. */
     file_not_symlink:
-- 
2.32.0.windows.1

--0-1891484557-1625593219=:56404
Content-Type: text/plain; charset=US-ASCII; name=0001-Cygwin-respect-PC_SYM_FOLLOW-and-PC_SYM_NOFOLLOW_REP.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2107061040190.56404@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0001-Cygwin-respect-PC_SYM_FOLLOW-and-PC_SYM_NOFOLLOW_REP.patch

RnJvbSA2N2EyNzZjMzVhM2I0ODY5N2M2YjYxY2FhZjRmZmVhNWExNzRjNzVi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFNhdCwgMjkgTWF5IDIwMjEg
MTE6NDg6MTEgLTA3MDANClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiByZXNw
ZWN0IFBDX1NZTV9GT0xMT1cgYW5kIFBDX1NZTV9OT0ZPTExPV19SRVAgd2l0
aA0KIGlubmVyIGxpbmtzLg0KDQpUaGUgbmV3IEdldEZpbmFsUGF0aE5hbWVX
IGhhbmRsaW5nIGZvciBuYXRpdmUgc3ltbGlua3MgaW4gaW5uZXIgcGF0aA0K
Y29tcG9uZW50cyBpcyBkaXNhYmxlZCBpZiBjYWxsZXIgZG9lc24ndCB3YW50
IHRvIGZvbGxvdyBzeW1saW5rcywgb3INCmRvZXNuJ3Qgd2FudCB0byBmb2xs
b3cgcmVwYXJzZSBwb2ludHMuDQotLS0NCiB3aW5zdXAvY3lnd2luL3BhdGgu
Y2MgfCA4OCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDQz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9w
YXRoLmNjIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjDQppbmRleCBlNjJmOGZl
MmIuLjE4NjlmYjhjOCAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vcGF0
aC5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjDQpAQCAtNzIyLDkg
KzcyMiwxMCBAQCBwYXRoX2NvbnY6OmNoZWNrIChjb25zdCBjaGFyICpzcmMs
IHVuc2lnbmVkIG9wdCwNCiAJICBpbnQgc3ltbGVuID0gMDsNCiANCiAJICAv
KiBNYWtlIHN1cmUgdG8gY2hlY2sgY2VydGFpbiBmbGFncyBvbiBsYXN0IGNv
bXBvbmVudCBvbmx5LiAqLw0KLQkgIGZvciAodW5zaWduZWQgcGNfZmxhZ3Mg
PSBvcHQgJiAoUENfTk9fQUNDRVNTX0NIRUNLIHwgUENfS0VFUF9IQU5ETEUp
Ow0KKwkgIGZvciAodW5zaWduZWQgcGNfZmxhZ3MgPSBvcHQgJiAoUENfTk9f
QUNDRVNTX0NIRUNLIHwgUENfS0VFUF9IQU5ETEUNCisJCQkJCSB8IFBDX1NZ
TV9GT0xMT1cgfCBQQ19TWU1fTk9GT0xMT1dfUkVQKTsNCiAJICAgICAgIDsN
Ci0JICAgICAgIHBjX2ZsYWdzID0gMCkNCisJICAgICAgIHBjX2ZsYWdzID0g
b3B0ICYgKFBDX1NZTV9GT0xMT1cgfCBQQ19TWU1fTk9GT0xMT1dfUkVQKSkN
CiAJICAgIHsNCiAJICAgICAgY29uc3Qgc3VmZml4X2luZm8gKnN1ZmY7DQog
CSAgICAgIGNoYXIgKmZ1bGxfcGF0aDsNCkBAIC0zNDgwLDQ4ICszNDgxLDQ5
IEBAIHJlc3RhcnQ6DQogCSAgICBnb3RvIGZpbGVfbm90X3N5bWxpbms7DQog
CX0NCiAjZW5kaWYgLyogX19pMzg2X18gKi8NCi0gICAgICB7DQotCVBXQ0hB
UiBmcGJ1ZiA9IHRwLndfZ2V0ICgpOw0KLQlEV09SRCByZXQ7DQotDQotCXJl
dCA9IEdldEZpbmFsUGF0aE5hbWVCeUhhbmRsZVcgKGgsIGZwYnVmLCBOVF9N
QVhfUEFUSCwgMCk7DQotCWlmIChyZXQpDQotCSAgew0KLQkgICAgVU5JQ09E
RV9TVFJJTkcgZnBhdGg7DQorICAgICAgaWYgKChwY19mbGFncyAmIChQQ19T
WU1fRk9MTE9XIHwgUENfU1lNX05PRk9MTE9XX1JFUCkpID09IFBDX1NZTV9G
T0xMT1cpDQorCXsNCisJICBQV0NIQVIgZnBidWYgPSB0cC53X2dldCAoKTsN
CisJICBEV09SRCByZXQ7DQogDQotCSAgICBSdGxJbml0Q291bnRlZFVuaWNv
ZGVTdHJpbmcgKCZmcGF0aCwgZnBidWYsIHJldCAqIHNpemVvZiAoV0NIQVIp
KTsNCi0JICAgIGZwYnVmWzFdID0gTCc/JzsJLyogXFw/XCAtLT4gXD8/XCAq
Lw0KLQkgICAgaWYgKCFSdGxFcXVhbFVuaWNvZGVTdHJpbmcgKCZ1cGF0aCwg
JmZwYXRoLCAhIWNpX2ZsYWcpKQ0KLQkgICAgICB7DQotCQlpc3N5bWxpbmsg
PSB0cnVlOw0KLQkJLyogdXBhdGguQnVmZmVyIGlzIGJpZyBlbm91Z2ggYW5k
IHVudXNlZCBmcm9tIHRoaXMgcG9pbnQgb24uDQotCQkgICBSZXVzZSBpdCBo
ZXJlLCBhdm9pZGluZyB5ZXQgYW5vdGhlciBidWZmZXIgYWxsb2NhdGlvbi4g
Ki8NCi0JCWNoYXIgKm5mcGF0aCA9IChjaGFyICopIHVwYXRoLkJ1ZmZlcjsN
Ci0JCXN5c193Y3N0b21icyAobmZwYXRoLCBOVF9NQVhfUEFUSCwgZnBidWYp
Ow0KLQkJcmVzID0gcG9zaXhpZnkgKG5mcGF0aCk7DQotDQotCQkvKiBJZiB0
aGUgaW5jb21pbmcgcGF0aCBjb25zaXN0ZWQgb2YgYSBkcml2ZSBwcmVmaXgg
b25seSwNCi0JCSAgIHdlIGp1c3QgaGFuZGxlIGEgdmlydHVhbCBkcml2ZSwg
Y3JlYXRlZCB3aXRoLCBlLmcuDQotDQotCQkgICAgIHN1YnN0IFg6IEM6XGZv
b1xiYXINCi0NCi0JCSAgIFRyZWF0IGl0IGxpa2UgYSBzeW1saW5rLiAgVGhp
cyBpcyByZXF1aXJlZCB0byB0ZWxsIGFuDQotCQkgICBsc3RhdCBjYWxsZXIg
dGhhdCB0aGUgImRyaXZlIiBpcyBhY3R1YWxseSBwb2ludGluZw0KLQkJICAg
c29tZXdoZXJlIGVsc2UsIHRodXMsIGl0J3MgYSBzeW1saW5rIGluIFBPU0lY
IHNwZWFrLiAqLw0KLQkJaWYgKHVwYXRoLkxlbmd0aCA9PSAxNCkJLyogXD8/
XFg6XCAqLw0KLQkJICB7DQotCQkgICAgZmlsZWF0dHIgJj0gfkZJTEVfQVRU
UklCVVRFX0RJUkVDVE9SWTsNCi0JCSAgICBwYXRoX2ZsYWdzIHw9IFBBVEhf
U1lNTElOSzsNCi0JCSAgfQ0KLQkJLyogRm9yIGZpbmFsIHBhdGhzIGRpZmZl
cmluZyBpbiBpbm5lciBwYXRoIGNvbXBvbmVudHMgcmV0dXJuDQotCQkgICBs
ZW5ndGggYXMgbmVnYXRpdmUgdmFsdWUuICBUaGlzIGluZm9ybXMgcGF0aF9j
b252OjpjaGVjaw0KLQkJICAgdG8gc2tpcCByZWFscGF0aCBoYW5kbGluZyBv
biB0aGUgbGFzdCBwYXRoIGNvbXBvbmVudC4gKi8NCi0JCWVsc2UNCi0JCSAg
cmVzID0gLXJlczsNCi0JCWJyZWFrOw0KLQkgICAgICB9DQotCSAgfQ0KLSAg
ICAgIH0NCisJICByZXQgPSBHZXRGaW5hbFBhdGhOYW1lQnlIYW5kbGVXICho
LCBmcGJ1ZiwgTlRfTUFYX1BBVEgsIDApOw0KKwkgIGlmIChyZXQpDQorCSAg
ICB7DQorCSAgICAgIFVOSUNPREVfU1RSSU5HIGZwYXRoOw0KKw0KKwkgICAg
ICBSdGxJbml0Q291bnRlZFVuaWNvZGVTdHJpbmcgKCZmcGF0aCwgZnBidWYs
IHJldCAqIHNpemVvZiAoV0NIQVIpKTsNCisJICAgICAgZnBidWZbMV0gPSBM
Jz8nOwkvKiBcXD9cIC0tPiBcPz9cICovDQorCSAgICAgIGlmICghUnRsRXF1
YWxVbmljb2RlU3RyaW5nICgmdXBhdGgsICZmcGF0aCwgISFjaV9mbGFnKSkN
CisJICAgICAgICB7DQorCQkgIGlzc3ltbGluayA9IHRydWU7DQorCQkgIC8q
IHVwYXRoLkJ1ZmZlciBpcyBiaWcgZW5vdWdoIGFuZCB1bnVzZWQgZnJvbSB0
aGlzIHBvaW50IG9uLg0KKwkJICAgICBSZXVzZSBpdCBoZXJlLCBhdm9pZGlu
ZyB5ZXQgYW5vdGhlciBidWZmZXIgYWxsb2NhdGlvbi4gKi8NCisJCSAgY2hh
ciAqbmZwYXRoID0gKGNoYXIgKikgdXBhdGguQnVmZmVyOw0KKwkJICBzeXNf
d2NzdG9tYnMgKG5mcGF0aCwgTlRfTUFYX1BBVEgsIGZwYnVmKTsNCisJCSAg
cmVzID0gcG9zaXhpZnkgKG5mcGF0aCk7DQorDQorCQkgIC8qIElmIHRoZSBp
bmNvbWluZyBwYXRoIGNvbnNpc3RlZCBvZiBhIGRyaXZlIHByZWZpeCBvbmx5
LA0KKwkJICAgICB3ZSBqdXN0IGhhbmRsZSBhIHZpcnR1YWwgZHJpdmUsIGNy
ZWF0ZWQgd2l0aCwgZS5nLg0KKw0KKwkJICAgICAgIHN1YnN0IFg6IEM6XGZv
b1xiYXINCisNCisJCSAgICAgVHJlYXQgaXQgbGlrZSBhIHN5bWxpbmsuICBU
aGlzIGlzIHJlcXVpcmVkIHRvIHRlbGwgYW4NCisJCSAgICAgbHN0YXQgY2Fs
bGVyIHRoYXQgdGhlICJkcml2ZSIgaXMgYWN0dWFsbHkgcG9pbnRpbmcNCisJ
CSAgICAgc29tZXdoZXJlIGVsc2UsIHRodXMsIGl0J3MgYSBzeW1saW5rIGlu
IFBPU0lYIHNwZWFrLiAqLw0KKwkJICBpZiAodXBhdGguTGVuZ3RoID09IDE0
KQkvKiBcPz9cWDpcICovDQorCQkgICAgew0KKwkJICAgICAgZmlsZWF0dHIg
Jj0gfkZJTEVfQVRUUklCVVRFX0RJUkVDVE9SWTsNCisJCSAgICAgIHBhdGhf
ZmxhZ3MgfD0gUEFUSF9TWU1MSU5LOw0KKwkJICAgIH0NCisJCSAgLyogRm9y
IGZpbmFsIHBhdGhzIGRpZmZlcmluZyBpbiBpbm5lciBwYXRoIGNvbXBvbmVu
dHMgcmV0dXJuDQorCQkgICAgIGxlbmd0aCBhcyBuZWdhdGl2ZSB2YWx1ZS4g
IFRoaXMgaW5mb3JtcyBwYXRoX2NvbnY6OmNoZWNrDQorCQkgICAgIHRvIHNr
aXAgcmVhbHBhdGggaGFuZGxpbmcgb24gdGhlIGxhc3QgcGF0aCBjb21wb25l
bnQuICovDQorCQkgIGVsc2UNCisJCSAgICByZXMgPSAtcmVzOw0KKwkJICBi
cmVhazsNCisJICAgICAgICB9DQorCSAgICB9DQorCX0NCiANCiAgICAgLyog
Tm9ybWFsIGZpbGUuICovDQogICAgIGZpbGVfbm90X3N5bWxpbms6DQotLSAN
CjIuMzIuMC53aW5kb3dzLjENCg0K

--0-1891484557-1625593219=:56404--
