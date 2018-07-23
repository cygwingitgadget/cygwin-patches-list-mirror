Return-Path: <cygwin-patches-return-9136-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15654 invoked by alias); 23 Jul 2018 15:15:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14714 invoked by uid 89); 23 Jul 2018 15:15:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS,TIME_LIMIT_EXCEEDED autolearn=unavailable version=3.3.2 spammy=ser, Glad, gid, cygwin-patches
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 23 Jul 2018 15:15:21 +0000
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w6NFF8SL020801	for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 11:15:08 -0400
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w6NFF6lv019830	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 11:15:07 -0400
Subject: Re: getfacl output
To: cygwin-patches <cygwin-patches@cygwin.com>
References: <48785885-6501-f00e-1949-d923fe7ed41b@cornell.edu> <20180723150622.GB3312@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <2961960c-9b29-708d-8491-72f938728f90@cornell.edu>
Date: Mon, 23 Jul 2018 15:15:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723150622.GB3312@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------51AFC99528B4CC0F8F535F34"
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00031.txt.bz2

This is a multi-part message in MIME format.
--------------51AFC99528B4CC0F8F535F34
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 649

[Redirecting to cygwin-patches.]

On 7/23/2018 11:06 AM, Corinna Vinschen wrote:
> On Jul 23 10:43, Ken Brown wrote:
>> This is obviously very minor, but I bumped into it because of a failing
>> emacs test.
>>
>> Cygwin's getfacl prints only one colon after "mask" and "other", but Linux's
>> prints two.  I'm sure this was done for a reason, but I'm wondering if it
>> would be better to follow Linux.
> 
> The original version was designed after Solaris documentation,
> but the layout is supposed to look like Linux for a while, so
> ther missing colon is a bug.
> 
>>    I'll be glad to submit a patch.
> 
> Glad to review it :)

Attached.

Ken

--------------51AFC99528B4CC0F8F535F34
Content-Type: text/plain; charset=UTF-8;
 name="0001-getfacl-and-setfacl-Align-with-Linux.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-getfacl-and-setfacl-Align-with-Linux.patch"
Content-length: 3120

RnJvbSBkZTg0MWJmNDBlY2RiZjkzZTg3ZDA5MDBkNGRkNTY3YWYzMmIwNzJm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogTW9uLCAyMyBKdWwgMjAxOCAxMDox
MDowMyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGdldGZhY2wgYW5kIHNldGZh
Y2w6IEFsaWduIHdpdGggTGludXgKCk1ha2UgZ2V0ZmFjbCBwcmludCB0d28g
Y29sb25zIGluc3RlYWQgb2Ygb25lIGFmdGVyICJvdGhlciIgYW5kICJtYXNr
Ii4KQ2hhbmdlIHRoZSBoZWxwIHRleHQgZm9yIHNldGZhY2wgdG8gaW5kaWNh
dGUgdGhhdCB0aGVyZSBjYW4gYmUgZWl0aGVyCm9uZSBjb2xvbiBvciB0d28u
Ci0tLQogd2luc3VwL3V0aWxzL2dldGZhY2wuYyB8IDEyICsrKysrKy0tLS0t
LQogd2luc3VwL3V0aWxzL3NldGZhY2wuYyB8ICA2ICsrKy0tLQogMiBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvd2luc3VwL3V0aWxzL2dldGZhY2wuYyBiL3dpbnN1cC91
dGlscy9nZXRmYWNsLmMKaW5kZXggNTdjNThmYjZhLi4zNjMyMjZkNmUgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC91dGlscy9nZXRmYWNsLmMKKysrIGIvd2luc3Vw
L3V0aWxzL2dldGZhY2wuYwpAQCAtOTgsMTQgKzk4LDE0IEBAIHVzYWdlIChG
SUxFICogc3RyZWFtKQogCSIgICAgIHVzZXI6bmFtZSBvciB1aWQ6cGVybVxu
IgogCSIgICAgIGdyb3VwOjpwZXJtXG4iCiAJIiAgICAgZ3JvdXA6bmFtZSBv
ciBnaWQ6cGVybVxuIgotCSIgICAgIG1hc2s6cGVybVxuIgotCSIgICAgIG90
aGVyOnBlcm1cbiIKKwkiICAgICBtYXNrOjpwZXJtXG4iCisJIiAgICAgb3Ro
ZXI6OnBlcm1cbiIKIAkiICAgICBkZWZhdWx0OnVzZXI6OnBlcm1cbiIKIAki
ICAgICBkZWZhdWx0OnVzZXI6bmFtZSBvciB1aWQ6cGVybVxuIgogCSIgICAg
IGRlZmF1bHQ6Z3JvdXA6OnBlcm1cbiIKIAkiICAgICBkZWZhdWx0Omdyb3Vw
Om5hbWUgb3IgZ2lkOnBlcm1cbiIKLQkiICAgICBkZWZhdWx0Om1hc2s6cGVy
bVxuIgotCSIgICAgIGRlZmF1bHQ6b3RoZXI6cGVybVxuIgorCSIgICAgIGRl
ZmF1bHQ6bWFzazo6cGVybVxuIgorCSIgICAgIGRlZmF1bHQ6b3RoZXI6OnBl
cm1cbiIKIAkiXG4iKTsKICAgICB9CiB9CkBAIC0yNjUsMTAgKzI2NSwxMCBA
QCBtYWluIChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCW4gKz0gcHJpbnRm
ICgiZ3JvdXA6JXM6IiwgZ3JvdXBuYW1lIChhY2xzW2ldLmFfaWQpKTsKIAkg
ICAgICBicmVhazsKIAkgICAgY2FzZSBDTEFTU19PQko6Ci0JICAgICAgcHJp
bnRmICgibWFzazoiKTsKKwkgICAgICBwcmludGYgKCJtYXNrOjoiKTsKIAkg
ICAgICBicmVhazsKIAkgICAgY2FzZSBPVEhFUl9PQko6Ci0JICAgICAgcHJp
bnRmICgib3RoZXI6Iik7CisJICAgICAgcHJpbnRmICgib3RoZXI6OiIpOwog
CSAgICAgIGJyZWFrOwogCSAgICB9CiAJICBuICs9IHByaW50ZiAoIiVzIiwg
cGVybXN0ciAoYWNsc1tpXS5hX3Blcm0pKTsKZGlmZiAtLWdpdCBhL3dpbnN1
cC91dGlscy9zZXRmYWNsLmMgYi93aW5zdXAvdXRpbHMvc2V0ZmFjbC5jCmlu
ZGV4IDM3MzI2NWJmMC4uMjU3N2FiNzc2IDEwMDY0NAotLS0gYS93aW5zdXAv
dXRpbHMvc2V0ZmFjbC5jCisrKyBiL3dpbnN1cC91dGlscy9zZXRmYWNsLmMK
QEAgLTExOSw3ICsxMTksNyBAQCBnZXRhY2xlbnRyeSAoYWN0aW9uX3QgYWN0
aW9uLCBjaGFyICpjLCBhY2xlbnRfdCAqYWNlKQogICAgIH0KICAgZWxzZSBp
ZiAoIShhY2UtPmFfdHlwZSAmIChVU0VSX09CSiB8IEdST1VQX09CSikpKQog
ICAgIHsKLSAgICAgIC8qIE1hc2sgYW5kIG90aGVyIGVudHJpZXMgbWF5IGNv
bnRhaW4gYW4gZXh0cmEgY29sb24uICovCisgICAgICAvKiBNYXNrIGFuZCBv
dGhlciBlbnRyaWVzIG1heSBjb250YWluIG9uZSBvciB0d28gY29sb25zLiAq
LwogICAgICAgaWYgKCpjID09ICc6JykKIAkrK2M7CiAgICAgfQpAQCAtNTU4
LDggKzU1OCw4IEBAIHVzYWdlIChGSUxFICpzdHJlYW0pCiAiICAgIHVbc2Vy
XTp1aWQ6cGVybVxuIgogIiAgICBnW3JvdXBdOjpwZXJtXG4iCiAiICAgIGdb
cm91cF06Z2lkOnBlcm1cbiIKLSIgICAgbVthc2tdOnBlcm1cbiIKLSIgICAg
b1t0aGVyXTpwZXJtXG4iCisiICAgIG1bYXNrXTpbOl1wZXJtXG4iCisiICAg
IG9bdGhlcl06WzpdcGVybVxuIgogIlxuIgogIiAgRGVmYXVsdCBlbnRyaWVz
IGFyZSBsaWtlIHRoZSBhYm92ZSB3aXRoIHRoZSBhZGRpdGlvbmFsIGRlZmF1
bHQgaWRlbnRpZmllci5cbiIKICIgIEZvciBleGFtcGxlOiBcbiIKLS0gCjIu
MTcuMAoK

--------------51AFC99528B4CC0F8F535F34--
