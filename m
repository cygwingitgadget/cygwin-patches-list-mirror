Return-Path: <cygwin-patches-return-8922-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106208 invoked by alias); 13 Nov 2017 18:51:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105442 invoked by uid 89); 13 Nov 2017 18:51:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=contacting, company
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Nov 2017 18:51:05 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id EJp0ebNGG8LPZEJp1eHXL5; Mon, 13 Nov 2017 11:51:03 -0700
X-Authority-Analysis: v=2.2 cv=e552ceh/ c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=w_pzkKWiAAAA:8 a=6piXWs4INij3eSCn8cQA:9 a=pILNOxqGKmIA:10 a=buB1NfXUTBUA:10 a=c-7DRuc6jdiwQKRuLdAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=uvLZkzHzGa8A:10 a=rFA1MAFG28cA:10 a=CdiWusdWvyIA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Add FAQ How do I fix find_fast_cwd warnings?
To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu> <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca> <8be9463b-1349-c309-afe1-828712489f74@cornell.edu> <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca> <20171113120509.GA3881@calimero.vinschen.de> <50152c8a-8086-57c5-0b4e-603a771ed7b8@SystematicSw.ab.ca>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <3a0ad9a8-0cb7-00ca-e698-dca59bc600e4@SystematicSw.ab.ca>
Date: Mon, 13 Nov 2017 18:51:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <50152c8a-8086-57c5-0b4e-603a771ed7b8@SystematicSw.ab.ca>
Content-Type: multipart/mixed; boundary="------------37B3C108C08722936493AAED"
X-CMAE-Envelope: MS4wfAZpdpbx06Gg6zXLAA0sxo/stX3XaqkPyKAKPM9ErL/eIB2bJ0bpXMjWaS7EXlTImHm+bVfKLc6qYBX7SXVPGxDZUnUU81ga30yWLdvNrV05FL4+gt3l LjYai4xKVzkZH4GckAHUEFYjimcgOAzveO+617ZEacGSpnONtlS0h2ZEwbWS6PmsC6EYUUFOnvI6L1xFpLOS70p2j0HTU+DvyKU=
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------37B3C108C08722936493AAED
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-length: 3212

On 2017-11-13 10:12, Brian Inglis wrote:
> On 2017-11-13 05:05, Corinna Vinschen wrote:
>> On Nov 13 00:04, Brian Inglis wrote:
>>> On 2017-11-12 16:02, Ken Brown wrote:
>>>> On 11/12/2017 4:27 PM, Brian Inglis wrote:
>>>>> +    <para>Some ancient Cygwin releases asked users to report problems that were
>>>>> +      difficult to diagnose to the mailing list with the message:</para>
>>>>> +
>>>>> +    <screen>find_fast_cwd: WARNING: Couldn't compute FAST_CWD pointer. Please
>>>>> report
>>>>> +    this problem to the public mailing listcygwin@cygwin.com</screen>
>>>>> +
>>>>> +    <para>These problems were fixed long ago in updated Cygwin releases.</para>
>>>>
>>>> The wording of the warning message was changed 3 years ago, in commit 0793492. 
>>>> I'm not sure that qualifies as ancient.  I also don't think it's accurate to
>>>> refer to the problem as "difficult to diagnose" or to say that the problems
>>>> "were fixed long ago".
>>>
>>> The original message was added in 2011 - 1.7.10 maybe earlier - NT4 support was
>>> dropped around then - pretty ancient in Cygwin terms of how many Windows
>>> releases have had support dropped since then!
>>>
>>>> The issue (Corinna will correct me if I'm wrong) is simply that new releases of
>>>> Windows sometimes require changes in how Cygwin finds the fast_cwd pointer.  So
>>>> users of old versions of Cygwin on new versions of Windows might have problems,
>>>> and this can certainly happen again in the future.  But the FAQ doesn't need to
>>>> go into that.  Why not just say what the warning currently says (see
>>>> path.cc:find_fast_cwd()):
>>>>
>>>> "This typically occurs if you're using an older Cygwin version on a newer
>>>> Windows.  Please update to the latest available Cygwin version from
>>>> https://cygwin.com/.  If the problem persists, please see
>>>> https://cygwin.com/problems.html."
>>>>
>>>> You can also add your sentence about contacting the vendor who provided the old
>>>> Cygwin release.
>>>
>>> We are trying in the FAQ entry to persuade an annoyed user that it may be in
>>> their best interest to do some remediation, rather than just complain in an
>>> email to an org they think is a company (cygwin.com) they have never heard of,
>>> who they expect from their application message to take care of their problem
>>> with no other effort on their part, and who they can blame if nothing happens.
>>>
>>> Assuming they find the FAQ entry, emphatic language may persuade them to do
>>> something more than the message says they should do.
>>
>> Nevertheless, Ken has a point.
>>
>> s/ancient/older and the text should really explain the "older Cygwin on
>> newer Windows" problem without necessarily going into too much detail.
>> "The problem has been fixed" just doesn't fit the facts.
> 
> I guess I may have been a little enthusiastic to get something out there we
> could refer to in future - and reduce the annoyance level for both posters and
> subscribers - attaching a hopefully more accurate diff for comment, also
> addressing some of the other points I suggested.

Made all URIs in messages links, fixed tags, links, improved flow and wording.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

--------------37B3C108C08722936493AAED
Content-Type: text/plain; charset=UTF-8;
 name="0001-add-FAQ-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-add-FAQ-How-do-I-fix-find_fast_cwd-warnings.patch"
Content-length: 3697

diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index b6b152e4e..498315896 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1419,4 +1419,65 @@ such as virtual memory paging and file caching.</para>
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
+    <para>This happens when the Cygwin release you installed can not find out
+	how to get your current directory from the Windows release you are
+	using.</para>
+    <para>Unfortunately some projects and products still distribute older
+	Cygwin releases which do not support newer Windows releases, instead of
+	installing the current release from the Cygwin project.
+	They also may not provide any obvious way to keep the Cygwin packages
+	their application uses up to date with fixes for security issues and
+	upgrades.</para>
+    <para>The fix is simply downloading and running Cygwin Setup, following the
+	instructions in the Internet Setup section of
+	<ulink url="https://cygwin.com/cygwin-ug-net/setup-net.html">
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
+	<ulink url="mailto:cygwin@cygwin.com?subject=Source%20of%20application%20providing%20Cygwin%20warning%20about%20FAST_CWD">
+	    email</ulink> to let us know where you obtained the application
+	which installed the older Cygwin release: whether it was purchased from
+	a vendor or a project downloaded from the Internet, any related web
+	pages, or other details you may have readily available.</para>
+  </answer>
+</qandaentry>
 </qandadiv>

--------------37B3C108C08722936493AAED--
