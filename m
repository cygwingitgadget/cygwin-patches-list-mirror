Return-Path: <cygwin-patches-return-8917-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8793 invoked by alias); 12 Nov 2017 21:27:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8775 invoked by uid 89); 12 Nov 2017 21:27:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Ken, para, products, HTo:U*cygwin-patches
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 12 Nov 2017 21:27:48 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id Dzn6eWICB8LPZDzn7eEjEf; Sun, 12 Nov 2017 14:27:46 -0700
X-Authority-Analysis: v=2.2 cv=e552ceh/ c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=1LwG1xpoD61sQaDc14UA:9 a=pILNOxqGKmIA:10 a=7vT8eNxyAAAA:8 a=w_pzkKWiAAAA:8 a=UGG5QBNCQIk9SjjIvqsA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=uvLZkzHzGa8A:10 a=CdiWusdWvyIA:10 a=Mzmg39azMnTNyelF985k:22 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Add FAQ 4.46. How do I fix find_fast_cwd warnings?
To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca>
Date: Sun, 12 Nov 2017 21:27:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu>
Content-Type: multipart/mixed; boundary="------------F9FDFD1FA0F01B64754D85EA"
X-CMAE-Envelope: MS4wfAO6Fv4s/aQXIZZzh30pOtNsuYbZoSuV42KGHVJwKsYdghkf1ZQ9m1cBDFgN13MWWQFS5eDAtQpo9b1PsV3ZwtwfOq0olCRYyTZFZzbCp95xk5nP+EB5 x99ZwMEXLxWMvL0yxqq9JK+FozD7vwvtTp2PJlfQnrRaBTfKcgxslmsgbGVdV8LbTb+KGnvJBFmZj7j9ZObK1whLNd1Ll+ZMd+Q=
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00047.txt.bz2

This is a multi-part message in MIME format.
--------------F9FDFD1FA0F01B64754D85EA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-length: 727

On 2017-11-12 12:07, Ken Brown wrote:
> On 11/12/2017 1:39 PM, Brian Inglis wrote:
>> Having responded to some of these posts and being prompted by the suggestion in
>> a reply to one by "Cyg simple", I attach an offering, in the off chance that
>> anyone affected might actually check the FAQ or find it in a search. ;^>
> 
> Even if they don't find it, we can refer them to the FAQ rather than re-writing
> variations on the same answer each time.  But your patch should be to
> winsup/doc/faq-using.xml.

Darn, it looked generated but I only looked around htdocs for sources.
Resubmitting against original winsup/doc/ source, which was much easier to edit.
;^>

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

--------------F9FDFD1FA0F01B64754D85EA
Content-Type: text/plain; charset=UTF-8;
 name="0001-add-FAQ-4.46.-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-add-FAQ-4.46.-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-length: 2563

From ebd6307c5aed2fc4b48945a335fcd216fa46ca01 Mon Sep 17 00:00:00 2001
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Date: Sun, 12 Nov 2017 14:25:32 -0700
Subject: [PATCH] add FAQ 4.46. How do I fix find_fast_cwd warnings?

---
 winsup/doc/faq-using.xml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index b6b152e4e..165da5c68 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1419,4 +1419,37 @@ such as virtual memory paging and file caching.</para>
   difficult to make <literal>fork()</literal> work reliably.</para>
 </answer>
 </qandaentry>
+
+<qandaentry id='faq.using.fixing-find_fast_cwd-warnings'>
+  <question><para>How do I fix <literal>find_fast_cwd</literal> warnings?</para></question>
+  <answer>
+    <para>Some ancient Cygwin releases asked users to report problems that were
+      difficult to diagnose to the mailing list with the message:</para>
+
+    <screen>find_fast_cwd: WARNING: Couldn't compute FAST_CWD pointer. Please report
+    this problem to the public mailing list cygwin@cygwin.com</screen>
+
+    <para>These problems were fixed long ago in updated Cygwin releases.</para>
+    <para>Unfortunately some projects and products still distribute these ancient
+	Cygwin releases, which do not support newer Windows releases, rather than
+	having their product install the current Cygwin release over the Internet.
+	They also provide no information about keeping Cygwin up to date with
+	upgrades and fixes.</para>
+    <para>The fix is simply downloading and running Cygwin Setup, using the
+	instructions at: 
+	<ulink url="https://cygwin.com/cygwin-ug-net/setup-net.html">
+	    setup-net.html</ulink>.</para>
+    <para>When running Setup, you should not change most of the values
+	presented, just select the <strong>Next</strong> button in most cases,
+	as you already have a Cygwin release installed and only want to upgrade
+	your current installation.  You should make your own selection if the
+	internet connection to your system requires a proxy, and to pick the
+	nearest up to date Cygwin download (mirror) site to your system for
+	faster downloads.</para>
+    <para>Cygwin Setup will download and apply updates to all packages required
+	for Cygwin itself and installed applications.
+	Any problems with applying updates or the application after updates should be
+	reported to the project or product vendor for follow up action.</para>
+  </answer>
+</qandaentry>
 </qandadiv>
-- 
2.15.0


--------------F9FDFD1FA0F01B64754D85EA--
