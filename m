Return-Path: <cygwin-patches-return-7983-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18121 invoked by alias); 23 May 2014 13:40:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18019 invoked by uid 89); 23 May 2014 13:40:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: smtpout17.bt.lon5.cpcloud.co.uk
Received: from smtpout17.bt.lon5.cpcloud.co.uk (HELO smtpout17.bt.lon5.cpcloud.co.uk) (65.20.0.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 May 2014 13:40:50 +0000
X-CTCH-RefID: str=0001.0A090208.537F4FE0.0053,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=8/97,refid=2.7.2:2014.5.19.53621:17:8.129,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __CT, __CTYPE_HAS_BOUNDARY, __CTYPE_MULTIPART, __CTYPE_MULTIPART_MIXED, __BAT_BOUNDARY, __ANY_URI, __URI_NO_MAILTO, __URI_NO_WWW, __URI_NO_PATH, __STOCK_PHRASE_7, BODY_SIZE_1900_1999, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS, MIME_TEXT_ONLY_MP_MIXED
X-CTCH-Spam: Unknown
Received: from [192.168.1.93] (86.139.179.106) by smtpout17.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 536B69E600FDF881 for cygwin-patches@cygwin.com; Fri, 23 May 2014 14:40:33 +0100
Message-ID: <537F4FD9.8050203@dronecode.org.uk>
Date: Fri, 23 May 2014 13:40:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Rename detached debug info as cygwin1.dll.dbg
Content-Type: multipart/mixed; boundary="------------060509030308040103020502"
X-SW-Source: 2014-q2/txt/msg00006.txt.bz2

This is a multi-part message in MIME format.
--------------060509030308040103020502
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 439


Not sure if this is wanted, and it obviously has some knock on effects 
on package and snapshot generation.

But, cygport names detached debug info files by appending the .dbg 
suffix.  This is 'obviously correct' as it means that both a foo.exe and 
foo.dll can exist and have detached debug info.

For consistency, the attached patch changes the name of the detached 
debug info file for cygwin1.dll from cygwin1.dbg to cygwin1.dll.dbg

--------------060509030308040103020502
Content-Type: text/plain; charset=windows-1252;
 name="consistent_dbg_name.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="consistent_dbg_name.patch"
Content-length: 989

SW5kZXg6IGN5Z3dpbi9NYWtlZmlsZS5pbgo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9NYWtl
ZmlsZS5pbix2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4yNzIKZGlmZiAtdSAt
dSAtcCAtcjEuMjcyIE1ha2VmaWxlLmluCi0tLSBjeWd3aW4vTWFrZWZpbGUu
aW4JOSBGZWIgMjAxNCAxOTo0NDo1NCAtMDAwMAkxLjI3MgorKysgY3lnd2lu
L01ha2VmaWxlLmluCTIzIE1heSAyMDE0IDEzOjI4OjE1IC0wMDAwCkBAIC00
MzcsNyArNDM3LDcgQEAgJChURVNUX0RMTF9OQU1FKTogJChMRFNDUklQVCkg
ZGxsZml4ZGJnIAogCS1lICQoRExMX0VOVFJZKSAkKERFRl9GSUxFKSAkKERM
TF9PRklMRVMpIHZlcnNpb24ubyB3aW52ZXIubyBcCiAJJChNQUxMT0NfT0JK
KSAkKExJQlNFUlZFUikgJChMSUJNKSAkKExJQkMpIFwKIAktbGdjYyAkKERM
TF9JTVBPUlRTKSAtV2wsLU1hcCxjeWd3aW4ubWFwCi0JQCQod29yZCAyLCRe
KSAkKE9CSkRVTVApICQoT0JKQ09QWSkgJEAgJHtwYXRzdWJzdCAlMC5kbGws
JTEuZGJnLCRAfQorCUAkKHdvcmQgMiwkXikgJChPQkpEVU1QKSAkKE9CSkNP
UFkpICRAICR7cGF0c3Vic3QgJTAuZGxsLCUxLmRsbC5kYmcsJEB9CiAJQGxu
IC1mICRAIG5ldy0kKERMTF9OQU1FKQogCiAjIFJ1bGUgdG8gYnVpbGQgbGli
Y3lnd2luLmEK

--------------060509030308040103020502--
