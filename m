Return-Path: <cygwin-patches-return-5980-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29765 invoked by alias); 15 Sep 2006 15:03:13 -0000
Received: (qmail 29751 invoked by uid 22791); 15 Sep 2006 15:03:12 -0000
X-Spam-Check-By: sourceware.org
Received: from mout.perfora.net (HELO mout.perfora.net) (217.160.230.40)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 15 Sep 2006 15:03:08 +0000
Received: from [204.251.225.15] (helo=[127.0.0.1]) 	by mrelay.perfora.net (node=mrelayus0) with ESMTP (Nemesis), 	id 0MKoyl-1GOFDd0NH8-0002k0; Fri, 15 Sep 2006 11:03:06 -0400
Message-ID: <450AC0A3.6000903@OutOfHanwell.com>
Date: Fri, 15 Sep 2006 15:03:00 -0000
From: Matthias Miller <Blog@OutOfHanwell.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [PATCH] add CRYPTPROTECT definitions to w32api's wincrypt.h
Content-Type: multipart/mixed;  boundary="------------010803060604030706030103"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00075.txt.bz2

This is a multi-part message in MIME format.
--------------010803060604030706030103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 120

I am needing CRYPTPROTECT definitions in wincrypt.h and have attached a 
patch to add them.

Regards,

-Matthias Miller

--------------010803060604030706030103
Content-Type: text/plain;
 name="wincrypt.h-CRYPTPROTECT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wincrypt.h-CRYPTPROTECT.patch"
Content-length: 1602

--- wincrypt.h.orig	Thu Sep 14 04:19:36 2006
+++ wincrypt.h	Thu Sep 14 04:20:37 2006
@@ -371,6 +371,21 @@
 #define SCHANNEL_MAC_KEY    0x00000000
 #define SCHANNEL_ENC_KEY    0x00000001
 #define INTERNATIONAL_USAGE 0x00000001
+#define CRYPTPROTECT_DEFAULT_PROVIDER   { 0xdf9d8cd0, 0x1501, 0x11d1, {0x8c, 0x7a, 0x00, 0xc0, 0x4f, 0xc2, 0x97, 0xeb} }
+#define CRYPTPROTECT_PROMPT_ON_UNPROTECT     0x1
+#define CRYPTPROTECT_PROMPT_ON_PROTECT       0x2
+#define CRYPTPROTECT_PROMPT_RESERVED         0x04
+#define CRYPTPROTECT_PROMPT_STRONG           0x08
+#define CRYPTPROTECT_PROMPT_REQUIRE_STRONG   0x10
+#define CRYPTPROTECT_UI_FORBIDDEN        0x1
+#define CRYPTPROTECT_LOCAL_MACHINE       0x4
+#define CRYPTPROTECT_CRED_SYNC           0x8
+#define CRYPTPROTECT_AUDIT              0x10
+#define CRYPTPROTECT_NO_RECOVERY        0x20
+#define CRYPTPROTECT_VERIFY_PROTECTION  0x40
+#define CRYPTPROTECT_CRED_REGENERATE    0x80
+#define CRYPTPROTECT_FIRST_RESERVED_FLAGVAL    0x0FFFFFFF
+#define CRYPTPROTECT_LAST_RESERVED_FLAGVAL     0xFFFFFFFF
 
 #define szOID_RSA 	"1.2.840.113549"
 #define szOID_PKCS 	"1.2.840.113549.1"
@@ -785,6 +800,13 @@
 	BYTE* pbOuterString;
 	DWORD cbOuterString;
 } HMAC_INFO, *PHMAC_INFO;
+typedef struct  _CRYPTPROTECT_PROMPTSTRUCT
+{
+    DWORD cbSize;
+    DWORD dwPromptFlags;
+    HWND  hwndApp;
+    LPCWSTR szPrompt;
+} CRYPTPROTECT_PROMPTSTRUCT, *PCRYPTPROTECT_PROMPTSTRUCT;
 
 BOOL WINAPI CertCloseStore(HCERTSTORE,DWORD);
 BOOL WINAPI CertGetCertificateChain(HCERTCHAINENGINE,PCCERT_CONTEXT,LPFILETIME,HCERTSTORE,PCERT_CHAIN_PARA,DWORD,LPVOID,PCCERT_CHAIN_CONTEXT*);

--------------010803060604030706030103--
