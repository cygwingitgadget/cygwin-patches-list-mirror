Return-Path: <cygwin-patches-return-8110-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10790 invoked by alias); 2 Apr 2015 18:05:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10774 invoked by uid 89); 2 Apr 2015 18:05:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham version=3.3.2
X-HELO: aibo.runbox.com
Received: from aibo.runbox.com (HELO aibo.runbox.com) (91.220.196.211) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 02 Apr 2015 18:04:58 +0000
Received: from [10.9.9.241] (helo=rmm6prod02.runbox.com)	by bars.runbox.com with esmtp (Exim 4.71)	(envelope-from <dwheeler@dwheeler.com>)	id 1YdjU6-0004mg-VZ	for cygwin-patches@sourceware.org; Thu, 02 Apr 2015 20:04:55 +0200
Received: from mail by rmm6prod02.runbox.com with local (Exim 4.76)	(envelope-from <dwheeler@dwheeler.com>)	id 1YdjU7-0007zi-Bw	for cygwin-patches@sourceware.org; Thu, 02 Apr 2015 20:04:55 +0200
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received: from [Authenticated user (258406)] by secure.runbox.com with http (RMM6); for <cygwin-patches@sourceware.org>; Thu, 02 Apr 2015 18:04:55 GMT
From: "David A. Wheeler" <dwheeler@dwheeler.com>
Reply-To: dwheeler@dwheeler.com
To: "cygwin-patches" <cygwin-patches@sourceware.org>
Subject: [PATCH] Add FAQ entry on how Cygwin counters install and update MITM attacks
Date: Thu, 02 Apr 2015 18:05:00 -0000
Message-Id: <E1YdjU7-0007zi-Bw@rmm6prod02.runbox.com>
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00011.txt.bz2

	* faq-setup.xml: Document how Cygwin secures installation and
	update against man-in-the-middle (MITM) attacks.  Note that
	setup embeds a public key to check the signature of setup.ini,
	and that setup.ini includes SHA-512 cryptographic hashes.

Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>
---
 winsup/doc/faq-setup.xml | 121 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index 614d4a9..2a4c507 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -156,6 +156,120 @@ and that installing the older version will not help i=
mprove Cygwin.
 </para>
 </answer></qandaentry>
=20
+<qandaentry id=3D"faq.setup.install-security">
+<question><para>How does Cygwin secure the installation and update process=
?</para></question>
+<answer>
+
+<para>
+Here is how Cygwin secures the installation and update process to counter
+<ulink url=3D"https://en.wikipedia.org/wiki/Man-in-the-middle_attack">man-=
in-the-middle (MITM) attacks</ulink>:
+</para>
+
+<orderedlist>
+<listitem><para>The Cygwin website provides the setup program
+(<literal>setup-x86.exe</literal> or <literal>setup-x86_64.exe</literal>)
+using HTTPS (SSL/TLS).
+This authenticates that the setup program
+came from the Cygwin website
+(users simply use their web browsers to download the setup program).
+You can use tools like Qualsys' SSL Server Test,
+<ulink url=3D"https://www.ssllabs.com/ssltest/"/>,
+to check the HTTPS configuration of Cygwin.
+The cygwin.com site supports HTTP Strict Transport Security (HSTS),
+which forces the browser to keep using HTTPS once the browser has seen
+it before (this counters many downgrade attacks).
+</para></listitem>
+<listitem><para>The setup program has the
+Cygwin public key embedded in it.
+The Cygwin public key is protected from attacker subversion
+during transmission by the previous step, and this public
+key is then used to protect all later steps.
+You can confirm that the key is in setup by looking at the setup project
+(<ulink url=3D"http://sourceware.org/cygwin-apps/setup.html"/>)
+source code file <literal>cyg-pubkey.h</literal>
+(the key is automatically generated from file <literal>cygwin.pub</literal=
>).
+</para></listitem>
+<listitem><para>The setup program downloads
+the package list <literal>setup.ini</literal> from a mirror
+and checks its digital signature.
+The package list is in the file
+<literal>setup.bz2</literal> (compressed) or
+<literal>setup.ini</literal> (uncompressed) on the selected mirror.
+The package list includes for every official Cygwin package
+the package name, cryptographic hash, and length (in bytes).
+The setup program also gets the relevant <literal>.sig</literal>
+(signature) file for that package list, and checks that the package list
+is properly signed with the Cygwin public key embedded in the setup progra=
m.
+A mirror could corrupt the package list and/or signature, but this
+would be detected by setup program's signature detection
+(unless you use the <literal>-X</literal> option to disable signature chec=
king).
+The setup program also checks the package list
+timestamp/version and reports to the user if the file
+goes backwards in time; that process detects downgrade attacks
+(e.g., where an attacker subverts a mirror to send a signed package list
+that is older than the currently-downloaded version).
+</para></listitem>
+<listitem><para>The packages to be installed
+(which may be updates) are downloaded and both their
+lengths and cryptographic hashes
+(from the signed <literal>setup.{bz2,ini}</literal> file) are checked.
+Non-matching packages are rejected, countering any attacker's
+attempt to subvert the files on a mirror.
+Cygwin currently uses the cryptographic hash function SHA-512
+for the <literal>setup.ini</literal> files.
+</para></listitem>
+</orderedlist>
+
+<para>
+Cygwin uses the cryptographic hash algorithm SHA-512 as of 2015-03-23.
+The earlier 2015-02-06 update of the setup program added support for SHA-5=
12
+(Cygwin previously used MD5).
+There are no known practical exploits of SHA-512 (SHA-512 is part of the
+widely-used SHA-2 suite of cryptographic hashes).
+</para>
+
+</answer></qandaentry>
+
+<qandaentry id=3D"faq.setup.increase-install-security">
+<question><para>What else can I do to ensure that my installation and upda=
tes are secure?</para></question>
+<answer>
+
+<para>
+To best secure your installation and update process, download
+the setup program <literal>setup-x86.exe</literal> (32-bit) or
+<literal>setup-x86_64.exe</literal> (64-bit), and then
+check its signature (using a signature-checking tool you trust)
+using the Cygwin public key
+(<ulink url=3D"https://cygwin.com/key/pubring.asc"/>).
+This was noted on the front page for installing and updating.
+</para>
+<para>
+If you use the actual Cygwin public key, and have an existing secure
+signature-checking process, you will counter many other
+attacks such as subversion of the Cygwin website and
+malicious certificates issued by untrustworthy certificate authorities (CA=
s).
+One challenge, of course, is ensuring that
+you have the actual Cygwin public key.
+You can increase confidence in the Cygwin public key by checking older cop=
ies
+of the Cygwin public key (to see if it's been the same over time).
+Another challenge is having a secure signature-checking process.
+You can use GnuPG to check signatures; if you have a trusted Cygwin
+installation you can install GnuPG.
+Otherwise, to check the signature you must use an existing trusted tool or
+install a signature-checking tool you can trust.
+</para>
+<para>
+Not everyone will go through this additional effort,
+but we make it possible for those who want that extra confidence.
+We also provide automatic mechanisms
+(such as our use of HTTPS) for those with limited time and
+do not want to perform the signature checking on the setup program itself.
+Once the correct setup program is running, it will counter other attacks
+as described in
+<ulink url=3D"https://cygwin.com/faq/faq.html#faq.setup.install-security"/=
>.
+</para>
+</answer></qandaentry>
+
 <qandaentry id=3D"faq.setup.virus">
 <question><para>Is Cygwin Setup, or one of the packages, infected with a v=
irus?</para></question>
 <answer>
@@ -197,8 +311,13 @@ disk if you are paranoid.
 </orderedlist>
=20
 <para>This should be safe, but only if Cygwin Setup is not substituted by
-something malicious, and no mirror has been compromised.
+something malicious.
+See also
+<ulink url=3D"https://cygwin.com/faq/faq.html#faq.setup.install-security"/>
+for a description of how the
+Cygwin project counters man-in-the-middle (MITM) attacks.
 </para>
+
 <para>See also <ulink url=3D"https://cygwin.com/faq/faq.html#faq.using.blo=
da"/>
 for a list of applications that have been known, at one time or another, to
 interfere with the normal functioning of Cygwin.
--=20
2.1.4

