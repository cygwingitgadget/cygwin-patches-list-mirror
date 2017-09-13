Return-Path: <cygwin-patches-return-8849-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57833 invoked by alias); 2 Sep 2017 14:17:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57800 invoked by uid 89); 2 Sep 2017 14:17:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_PASS autolearn=ham version=3.3.2 spammy=shortcuts, wave, Properties, para
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 02 Sep 2017 14:17:19 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 723228CDC10	for <cygwin-patches@cygwin.com>; Sat,  2 Sep 2017 14:17:17 +0000 (UTC)
Received: from Gertrud (p57b9de88.dip0.t-ipconnect.de [87.185.222.136])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 41155CDFA0	for <cygwin-patches@cygwin.com>; Sat,  2 Sep 2017 14:17:15 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Remove some dangerous advice from the FAQ
Date: Wed, 13 Sep 2017 15:44:00 -0000
Message-ID: <87pob95gns.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-VADE-STATUS: LEGIT
X-SW-Source: 2017-q3/txt/msg00051.txt.bz2


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-Remove-some-dangerous-advice-from-the-FAQ.patch
Content-length: 2081

From f19ff76eb48e82dcc15fd02bc97a503f1f4a3344 Mon Sep 17 00:00:00 2001
From: Achim Gratz <Stromeko@Stromeko.DE>
Date: Sat, 2 Sep 2017 16:14:02 +0200
Subject: [PATCH] Remove some dangerous advice from the FAQ

---
 winsup/doc/faq-setup.xml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index 3917f2d30..b242fbae4 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -610,16 +610,20 @@ folders that are causing the error.  For example, sometimes files used by
 system services end up owned by the SYSTEM account and not writable by regular
 users.</para>
 <para>The quickest way to delete the entire tree if you run into this problem
-is to change the ownership of all files and folders to your account.  To do
+is to take ownership of all files and folders to your account.  To do
 this in Windows Explorer, right click on the root Cygwin folder, choose
 Properties, then the Security tab.  If you are using Simple File Sharing, you
 will need to boot into Safe Mode to access the Security tab.  Select Advanced,
 then go to the Owner tab and make sure your account is listed as the owner.
 Select the 'Replace owner on subcontainers and objects' checkbox and press Ok.
 After Explorer applies the changes you should be able to delete the entire tree
-in one operation.  Note that you can also achieve this in Cygwin by typing
-<literal>chown -R user /</literal> or by using other tools such as
-<literal>icacls.exe</literal>. 
+in one operation.  Note that you can also achieve by using other tools such as
+<literal>icacls.exe</literal> or directly from Cygwin by using
+<literal>chown</literal>.  Please note that you shouldn't use the
+recursive form of chown on directories that have other file systems
+mounted under them (specifically you must avoid
+<literal>/proc</literal>) since you'd change ownership of the files under those
+mount points as well.
 </para>
 </listitem>
 <listitem><para>Delete the Cygwin shortcuts on the Desktop and Start Menu, and
-- 
2.14.1


--=-=-=
Content-Type: text/plain
Content-length: 182



Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables

--=-=-=--
