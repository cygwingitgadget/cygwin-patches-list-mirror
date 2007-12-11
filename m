Return-Path: <cygwin-patches-return-6186-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2998 invoked by alias); 11 Dec 2007 15:55:00 -0000
Received: (qmail 2986 invoked by uid 22791); 11 Dec 2007 15:54:59 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 15:54:55 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Tue, 11 Dec 2007 15:54:52 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM> <20071211141852.GA3619@ednor.casa.cgf.cx> <0b1e01c83c01$cb11e2c0$2e08a8c0@CAM.ARTIMI.COM> <20071211143847.GA3719@ednor.casa.cgf.cx> <0b2301c83c09$f075e6d0$2e08a8c0@CAM.ARTIMI.COM> <20071211153658.GB9398@calimero.vinschen.de>
Subject: RE: Cygheap page boundary allocation bug.
Date: Tue, 11 Dec 2007 15:55:00 -0000
Message-ID: <0b2a01c83c0e$2b025140$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071211153658.GB9398@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00038.txt.bz2

On 11 December 2007 15:37, Corinna Vinschen wrote:

> On Dec 11 15:24, Dave Korn wrote:
>>   Applied, thanks.  (Found some problems in w32api's wincrypt.h which I'll
>> report to mingw list later today.  Appears to have been there for at least
>> a fortnight.  Am I the only one who builds with WINVER >= 0x0501?)
> 
> Unlikely but possible.  Cygwin is using _WIN32_WINNT=0x0501 in winsup.h
> and it doesn't have a build problem.


  AFAICT, there's no way on earth that what's in cvs could possibly compile.  It
uses the PCERT_POLICY_MAPPING structure typedef for a member of another struct
before it (PCERT_POLICY_MAPPING) has been defined.  There's also an undefined
type referenced in one of the function prototypes.  I had to do this:


Index: winsup/w32api/include/wincrypt.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/wincrypt.h,v
retrieving revision 1.22
diff -p -u -r1.22 wincrypt.h
--- winsup/w32api/include/wincrypt.h	22 Nov 2007 03:16:15 -0000	1.22
+++ winsup/w32api/include/wincrypt.h	11 Dec 2007 15:17:30 -0000
@@ -658,6 +658,8 @@ typedef struct _CRYPT_ENCODE_PARA {
 } CRYPT_ENCODE_PARA, 
  *PCRYPT_ENCODE_PARA;
 
+/* Definition missing. */
+typedef struct _CRYPT_DECODE_PARA *PCRYPT_DECODE_PARA;
 
 typedef UINT ALG_ID;
 typedef struct _VTableProvStruc {FARPROC FuncVerifyImage;}
VTableProvStruc,*PVTableProvStruc;
@@ -982,16 +984,16 @@ typedef struct _CERT_POLICY_CONSTRAINTS_
  *PCERT_POLICY_CONSTRAINTS_INFO;
 #endif /* (WINVER >= 0x0410) */ /* Windows 98 */
 #if (WINVER >= 0x0501) /* Windows Server 2003, Windows XP */
-typedef struct _CERT_POLICY_MAPPINGS_INFO {
-  DWORD cPolicyMapping;
-  PCERT_POLICY_MAPPING rgPolicyMapping;
-} CERT_POLICY_MAPPINGS_INFO, 
- *PCERT_POLICY_MAPPINGS_INFO;
 typedef struct _CERT_POLICY_MAPPING {
   LPSTR pszIssuerDomainPolicy;
   LPSTR pszSubjectDomainPolicy;
 } CERT_POLICY_MAPPING, 
  *PCERT_POLICY_MAPPING;
+typedef struct _CERT_POLICY_MAPPINGS_INFO {
+  DWORD cPolicyMapping;
+  PCERT_POLICY_MAPPING rgPolicyMapping;
+} CERT_POLICY_MAPPINGS_INFO, 
+ *PCERT_POLICY_MAPPINGS_INFO;
 #endif /* (WINVER >= 0x0501) */ /* Windows Server 2003, Windows XP */
 
 BOOL WINAPI CertCloseStore(HCERTSTORE,DWORD);


before I could build winsup.  Dunno why it's not affecting everyone else too.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
