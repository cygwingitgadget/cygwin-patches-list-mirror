Return-Path: <cygwin-patches-return-8924-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118724 invoked by alias); 14 Nov 2017 20:52:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118705 invoked by uid 89); 14 Nov 2017 20:52:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Alice, White, alarming, H*M:9e56
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Nov 2017 20:52:12 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id EiBleinr68LPZEiBmeM4tV; Tue, 14 Nov 2017 13:52:10 -0700
X-Authority-Analysis: v=2.2 cv=e552ceh/ c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=w_pzkKWiAAAA:8 a=arats3DLAAAA:8 a=q6JOA7gBMXpHF-LnWzcA:9 a=pILNOxqGKmIA:10 a=qCR5CeDlQewA:10 a=c-7DRuc6jdiwQKRuLdAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=buB1NfXUTBUA:10 a=uvLZkzHzGa8A:10 a=rFA1MAFG28cA:10 a=CdiWusdWvyIA:10 a=sRI3_1zDfAgwuvI8zelB:22 a=wReGs9PrLDluCadCDDbJ:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Add FAQ How do I fix find_fast_cwd warnings?
To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu> <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca> <8be9463b-1349-c309-afe1-828712489f74@cornell.edu> <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca> <20171113120509.GA3881@calimero.vinschen.de> <50152c8a-8086-57c5-0b4e-603a771ed7b8@SystematicSw.ab.ca> <3a0ad9a8-0cb7-00ca-e698-dca59bc600e4@SystematicSw.ab.ca> <20171114092902.GF6054@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <d9422d11-f5f0-4f8e-9e56-04efd40cec4b@SystematicSw.ab.ca>
Date: Tue, 14 Nov 2017 20:52:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171114092902.GF6054@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------0CB9941B8636E931FC1C61E4"
X-CMAE-Envelope: MS4wfHuWnPWIuImdBju08j3MtXCdguQ7MJ2d/fYtnS3e+CvfTQNUcoXo3N76XBf8jjrKlhaXWouJo9+lOWdMMF3tPyuD0xU4MFg/sKGbqVUSs9lbboYTBxTc RAsH6Ahm19ID3AjX5FbS5kBX1rlulp5FlO5VyeMSjU7CV3Y38H/Vy0QTQmKEdWpr8iH69KmTMTGVJqG+G/71jI+mPwSVXJknZEs=
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00054.txt.bz2

This is a multi-part message in MIME format.
--------------0CB9941B8636E931FC1C61E4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-length: 2417

On 2017-11-14 02:29, Corinna Vinschen wrote:
> On Nov 13 11:51, Brian Inglis wrote:
>> On 2017-11-13 10:12, Brian Inglis wrote:
> Please send this as `git format-patch' with commit message and all.

One more diff for comment, and I could use some pointer on how to build htdocs
html from doc xml, and whether I need to concatenate the screen ulinks to get
them to render as a single line, which could be answered by the build.

>> +    <para>This happens when the Cygwin release you installed can not find out
>> +	how to get your current directory from the Windows release you are
>> +	using.</para>
> I think this paragraph raises more questions than it answers.  Of course
> Cygwin still can get the CWD, just not in the preferred way.  Even if
> you change it to more technically correct terms, it doesn't give any
> useful info for users.  Let's just drop it.

Reworded to say that it the issue may not be serious, but may be a performance
impact, to put the issue into perspective, and give the user some context.
I think your comment applies best to the message itself. ;^>
Perhaps we should consider dropping it, or rewording to be less alarming?

>> +    <para>As Cygwin is a volunteer project, and we can not provide support for
>> +	older releases installed by projects or products, but would like to be
>> +	able to follow up to reduce reports of these issues if possible, it
>> +	would be helpful if you would send us a quick
>> +	<ulink url="mailto:cygwin@cygwin.com?subject=Source%20of%20application%20providing%20Cygwin%20warning%20about%20FAST_CWD">
>> +	    email</ulink> to let us know where you obtained the application
>> +	which installed the older Cygwin release: whether it was purchased from
>> +	a vendor or a project downloaded from the Internet, any related web
>> +	pages, or other details you may have readily available.</para>
> 
> Do we really want all this information?  It should be sufficient to know
> the name of the project, so it's in the records for later reference.
> But we won't follow up on this anyway.  There are just too many
> well-meaning, but short-lived TPPs on the web using Cygwin under the
> hood.

Scrunched, but I am always reminded of the White Knight's song in Alice
	http://world.std.com/~swmcd/steven/programming/knight.html
when users are asked the name of a project or product e.g. "McAfee"!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

--------------0CB9941B8636E931FC1C61E4
Content-Type: text/plain; charset=UTF-8;
 name="0001-add-FAQ-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-add-FAQ-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-length: 3626

diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index b6b152e4e..6be533652 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1419,4 +1419,64 @@ such as virtual memory paging and file caching.</para>
   difficult to make <literal>fork()</literal> work reliably.</para>
 </answer>
 </qandaentry>
+
+<qandaentry id='faq.using.fixing-find_fast_cwd-warnings'>
+  <question><para>How do I fix <literal>find_fast_cwd</literal> warnings?</para></question>
+  <answer>
+    <para>Older Cygwin releases asked users to report problems to the mailing
+	list with the message:</para>
+
+    <screen>find_fast_cwd: WARNING: Couldn't compute FAST_CWD pointer. Please report
+	this problem to the public mailing list
+	<ulink url="mailto:cygwin@cygwin.com">
+	    cygwin@cygwin.com</ulink></screen>
+
+    <para>Recent Cygwin releases changed this to the message:</para>
+
+    <screen>This typically occurs if you're using an older Cygwin version on a newer Windows.
+	Please update to the latest available Cygwin version from
+	<ulink url="https://cygwin.com/">
+	    https://cygwin.com/</ulink>.
+	If the problem persists, please see
+	<ulink url="https://cygwin.com/problems.html">
+	    https://cygwin.com/problems.html</ulink>.</screen>
+
+    <para>This is usually not a serious issue, just a warning that Cygwin
+	performance may be affected, when the Cygwin release you installed can
+	not find a quick way to get your current directory from the Windows
+	release you are using.</para>
+    <para>Unfortunately some projects and products still distribute older
+	Cygwin releases which may not fully support newer Windows releases,
+	instead of installing the current release from the Cygwin project.
+	They also may not provide any obvious way to keep the Cygwin packages
+	their application uses up to date with fixes for security issues and
+	upgrades.</para>
+    <para>The fix is simply downloading and running Cygwin Setup, following the
+	instructions in the Internet Setup section of
+	<ulink url="https://cygwin.com/cygwin-ug-net/setup-net.html#internet-setup">
+	    Setting Up Cygwin</ulink> in the Cygwin User's Guide.</para>
+    <para>When running Setup, you should not change most of the values
+	presented, just select the <literal>Next</literal> button in most
+	cases, as you already have a Cygwin release installed and only want to
+	upgrade your current installation.
+	You should make your own selection if the internet connection to your
+	system requires a proxy; and you must always pick an up to date Cygwin
+	download (mirror) site, preferably the site nearest to your system for
+	faster downloads, as shown with more details to help you choose on the
+	<ulink url="https://cygwin.com/mirrors.html">
+	    Mirror Sites</ulink> web page.</para>
+    <para>Cygwin Setup will download and apply updates to all packages required
+	for Cygwin itself and installed applications.
+	Any problems with applying updates, or the application after updates,
+	should be reported to the project or product vendor for follow up
+	action.</para>
+    <para>As Cygwin is a volunteer project, and we can not provide support for
+	older releases installed by projects or products, but would like to be
+	able to follow up to reduce reports of these issues if possible, it
+	would be helpful if you would send us a quick
+	<ulink url="mailto:cygwin@cygwin.com?subject=Application%20with%20old%20Cygwin%20warning%20about%20FAST_CWD">
+	    email</ulink> to let us know what project or product you installed
+	with the older Cygwin release.</para>
+  </answer>
+</qandaentry>
 </qandadiv>

--------------0CB9941B8636E931FC1C61E4--
