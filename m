Return-Path: <cygwin-patches-return-8037-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1784 invoked by alias); 28 Nov 2014 18:51:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1752 invoked by uid 89); 28 Nov 2014 18:51:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 28 Nov 2014 18:51:55 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sASIpsj5009861	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)	for <cygwin-patches@cygwin.com>; Fri, 28 Nov 2014 13:51:54 -0500
Received: from [10.10.116.29] ([10.10.116.29])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sASIpqHT020315	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 28 Nov 2014 13:51:53 -0500
Message-ID: <5478C44E.5040903@cygwin.com>
Date: Fri, 28 Nov 2014 18:51:00 -0000
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] build PDFs with xmlto (was: Instability with signals and threads)
References: <alpine.DEB.2.02.1411202055420.8559@artax.karlin.mff.cuni.cz> <alpine.DEB.2.02.1411211451420.108656@artax.karlin.mff.cuni.cz> <20141121144333.GA6633@calimero.vinschen.de> <546F5F37.9010509@gmail.com> <20141121160608.GF3810@calimero.vinschen.de> <546F9B5E.80707@cygwin.com> <20141121203628.GA17637@calimero.vinschen.de>
In-Reply-To: <20141121203628.GA17637@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------080903050900080502080700"
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00016.txt.bz2

This is a multi-part message in MIME format.
--------------080903050900080502080700
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1269

On 2014-11-21 14:36, Corinna Vinschen wrote:
> On Nov 21 14:06, Yaakov Selkowitz wrote:
>> On 2014-11-21 10:06, Corinna Vinschen wrote:
>>> On Nov 21 16:50, Marco Atzeri wrote:
>>>> On 11/21/2014 3:43 PM, Corinna Vinschen wrote:
>>>>>> On 32-bit. The rebuild of cygwin1.dll requires large number of packages to
>>>>>> create the documentation (including tex and java) and I haven't bloated
>>>>>
>>>>> Java?!?
>>>>
>>>> FOP is a Java application....grrr...
>>>
>>> Oh, right.
>>
>> https://cygwin.com/ml/cygwin-developers/2013-07/msg00008.html
>>
>> Which resulted in:
>>
>> https://sourceware.org/viewvc/src/winsup/doc/Makefile.in?r1=1.33&r2=1.34
>>
>> Has this bug been fixed yet in TeX Live?  I had no problems building the
>> PDFs after reverting this commit.  I'll have to try on Fedora 20 and 21,
>> unless someone else can get to it first.
>
> Again, if you have another way to create pdf files from xml input, which
> works on Cygwin and Linux, please feel free to provide one.  I had no
> problems creating pdfs on Linux using fop, so I had no incentive to
> switch.  Just provide a patch to cygwin-patches.  If it works it's as
> good as applied.

Attached.  Tested and works on Cygwin and Fedora 19 through 21, but 
still fails on RHEL/CentOS 7.

--
Yaakov


--------------080903050900080502080700
Content-Type: text/plain; charset=windows-1252;
 name="winsup-doc-dblatex.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="winsup-doc-dblatex.patch"
Content-length: 2196

MjAxNC0xMS0yOCAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
PgoKCSogTWFrZWZpbGUuaW4gKFhTTFRQUk9DKTogUmVtb3ZlLgoJKGN5Z3dp
bi11Zy1uZXQvY3lnd2luLXVnLW5ldC5wZGYpOiBCdWlsZCB3aXRoIHhtbHRv
IHBkZi4KCShjeWd3aW4tYXBpL2N5Z3dpbi1hcGkucGRmKTogRGl0dG8uCgko
ZmFxL2ZhcS5odG1sKTogRml4IGV4dHJhbmVvdXMgYW5jaG9yIHJlbW92YWwu
CgpJbmRleDogTWFrZWZpbGUuaW4KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9kb2MvTWFrZWZpbGUuaW4s
dgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzgKZGlmZiAtdSAtcCAtcjEuMzgg
TWFrZWZpbGUuaW4KLS0tIE1ha2VmaWxlLmluCTIyIE9jdCAyMDE0IDIwOjA0
OjQyIC0wMDAwCTEuMzgKKysrIE1ha2VmaWxlLmluCTI4IE5vdiAyMDE0IDE3
OjEyOjE3IC0wMDAwCkBAIC0yNCw3ICsyNCw2IEBAIE1LRElSUDo9JChJTlNU
QUxMKSAtbSA3NTUgLWQKIENDOj1AQ0NACiBDQ19GT1JfVEFSR0VUOj1AQ0NA
CiAKLVhTTFRQUk9DOj14c2x0cHJvYyAtLXhpbmNsdWRlCiBYTUxUTzo9eG1s
dG8gLS1za2lwLXZhbGlkYXRpb24gLS13aXRoLWRibGF0ZXgKIAogaW5jbHVk
ZSAkKHNyY2RpcikvLi4vTWFrZWZpbGUuY29tbW9uCkBAIC04MCwxOSArNzks
MTcgQEAgY3lnd2luLXVnLW5ldC9jeWd3aW4tdWctbmV0Lmh0bWwgOiBjeWd3
aQogCS0kKFhNTFRPKSBodG1sIC1vIGN5Z3dpbi11Zy1uZXQvIC1tICQoc3Jj
ZGlyKS9jeWd3aW4ueHNsICQ8CiAKIGN5Z3dpbi11Zy1uZXQvY3lnd2luLXVn
LW5ldC5wZGYgOiBjeWd3aW4tdWctbmV0LnhtbCBmby54c2wKLQlAJChNS0RJ
UlApIGN5Z3dpbi11Zy1uZXQKLQktJChYU0xUUFJPQykgJChzcmNkaXIpL2Zv
LnhzbCAkPCB8IGZvcCAtcSAtZm8gLSAkQAorCS0kKFhNTFRPKSBwZGYgLW8g
Y3lnd2luLXVnLW5ldC8gJDwKIAogY3lnd2luLWFwaS9jeWd3aW4tYXBpLmh0
bWwgOiBjeWd3aW4tYXBpLnhtbCBjeWd3aW4ueHNsCiAJLSQoWE1MVE8pIGh0
bWwgLW8gY3lnd2luLWFwaS8gLW0gJChzcmNkaXIpL2N5Z3dpbi54c2wgJDwK
IAogY3lnd2luLWFwaS9jeWd3aW4tYXBpLnBkZiA6IGN5Z3dpbi1hcGkueG1s
IGZvLnhzbAotCUAkKE1LRElSUCkgY3lnd2luLWFwaQotCS0kKFhTTFRQUk9D
KSAkKHNyY2RpcikvZm8ueHNsICQ8IHwgZm9wIC1xIC1mbyAtICRACisJLSQo
WE1MVE8pIHBkZiAtbyBjeWd3aW4tYXBpLyAkPAogCiBmYXEvZmFxLmh0bWwg
OiAkKEZBUV9TT1VSQ0VTKQogCS0kKFhNTFRPKSBodG1sIC1vIGZhcSAtbSAk
KHNyY2RpcikvY3lnd2luLnhzbCAkKHNyY2RpcikvZmFxLnhtbAotCS1zZWQg
LWkgJ3M7PC9hPjxhIG5hbWU9ImlkWzAtOV0qIj48L2E+OzwvYT47ZycgZmFx
L2ZhcS5odG1sCisJLXNlZCAtaSAnczs8YSBuYW1lPSJpZFttcF1bMC05XSoi
PjwvYT47O2cnIGZhcS9mYXEuaHRtbAogCiBUQkZJTEVTID0gY3lnd2luLXVn
LW5ldC5kdmkgY3lnd2luLXVnLW5ldC5ydGYgY3lnd2luLXVnLW5ldC5wcyBc
CiAJICBjeWd3aW4tdWctbmV0LnBkZiBjeWd3aW4tdWctbmV0LnhtbCBcCg==

--------------080903050900080502080700--
