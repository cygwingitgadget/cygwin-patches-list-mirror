Return-Path: <cygwin-patches-return-8807-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115209 invoked by alias); 24 Jul 2017 04:15:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49127 invoked by uid 89); 24 Jul 2017 04:11:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=unavailable version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Jul 2017 04:11:47 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id ZUeEdYNrhI8mCZUeFdjYUC; Sun, 23 Jul 2017 22:07:12 -0600
X-Authority-Analysis: v=2.2 cv=HahkdmM8 c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=Up6tEhC2y6cmVspmuR4A:9 a=QEXdDO2ut3YA:10 a=tOlO8ef7fwwkDf0Z4y0A:9 a=CdiWusdWvyIA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: Cygwin strptime() is missing "%s" which strftime() has
To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca>
Date: Wed, 02 Aug 2017 06:11:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com>
Content-Type: multipart/mixed; boundary="------------7A56D5B5DA3497A139629A78"
X-CMAE-Envelope: MS4wfBRPJzZKfq2KNLeQv7MaSQGjMhEUyhuNVmZDLdwMh41y4t3XlmNfC69Q1WIeHKaJHZiVzzoB97YUIcBXfW17xa1+I+1rFTL/pHWuVqfEQdyaHsrSUbha lZ86zueKdZ7OsLz6zRoG6Tx/t29IlfUzWi2ccXBAJ1NATe0+iCHrKUHD859TmOveW1SpJu4d1dto/Izp8icVdcqBVOjTAV1+nOw=
X-SW-Source: 2017-q3/txt/msg00009.txt.bz2
Message-ID: <20170802061100.MSPpi8vwneY5QJXHS5V-2OKZmSWG4GsxxqTayB3NgD4@z>

This is a multi-part message in MIME format.
--------------7A56D5B5DA3497A139629A78
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 910

On 2017-07-23 20:09, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
>> But that's just scanning a decimal integer to time_t.
> 
> It's not a question of whether I can or can't convert a string into an integer, rather it's a question about portability of code that uses %s for both functions and expects it to work unchanged in the Cygwin environment.  Also, strptime() was designed to be a reversal to strftime() (from the man-pages: the  strptime() function is the converse function to strftime(3)) so both are supposed to "understand" the same basic set of formats.  Because of Cygwin's strptime() missing "%s", the following also does not work even from command line:
> 
> $ date +"%s" | strptime "%s"

Attached diff for proposed strptime %s and %F support.
Let me know if you would prefer a different approach before I submit a git
format-patch.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

--------------7A56D5B5DA3497A139629A78
Content-Type: text/plain; charset=UTF-8;
 name="0001-add-strptime-%s-%F.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-add-strptime-%s-%F.patch"
Content-length: 1700

ZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL3RpbWUvc3RycHRpbWUuYyBiL25l
d2xpYi9saWJjL3RpbWUvc3RycHRpbWUuYwppbmRleCBjMDg2MWViODcuLmIz
NTJiY2JhYiAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvdGltZS9zdHJwdGlt
ZS5jCisrKyBiL25ld2xpYi9saWJjL3RpbWUvc3RycHRpbWUuYwpAQCAtMzgs
NiArMzgsNyBAQAogI2luY2x1ZGUgPHN0cmluZ3MuaD4KICNpbmNsdWRlIDxj
dHlwZS5oPgogI2luY2x1ZGUgPHN0ZGxpYi5oPgorI2luY2x1ZGUgPGludHR5
cGVzLmg+CiAjaW5jbHVkZSAiLi4vbG9jYWxlL3NldGxvY2FsZS5oIgogCiAj
ZGVmaW5lIF9jdGxvYyh4KSAoX0N1cnJlbnRUaW1lTG9jYWxlLT54KQpAQCAt
MjMwLDYgKzIzMSwxMyBAQCBzdHJwdGltZV9sIChjb25zdCBjaGFyICpidWYs
IGNvbnN0IGNoYXIgKmZvcm1hdCwgc3RydWN0IHRtICp0aW1lcHRyLAogCQli
dWYgPSBzOwogCQl5bWQgfD0gU0VUX01EQVk7CiAJCWJyZWFrOworCSAgICBj
YXNlICdGJyA6CQkvKiAlWS0lbS0lZCAqLworCQlzID0gc3RycHRpbWVfbCAo
YnVmLCAiJVktJW0tJWQiLCB0aW1lcHRyLCBsb2NhbGUpOworCQlpZiAocyA9
PSBOVUxMKQorCQkgICAgcmV0dXJuIE5VTEw7CisJCWJ1ZiA9IHM7CisJCXlt
ZCB8PSBTRVRfWU1EOworCQlicmVhazsKIAkgICAgY2FzZSAnSCcgOgogCSAg
ICBjYXNlICdrJyA6CiAJCXJldCA9IHN0cnRvbF9sIChidWYsICZzLCAxMCwg
bG9jYWxlKTsKQEAgLTMwMCw2ICszMDgsMjEgQEAgc3RycHRpbWVfbCAoY29u
c3QgY2hhciAqYnVmLCBjb25zdCBjaGFyICpmb3JtYXQsIHN0cnVjdCB0bSAq
dGltZXB0ciwKIAkJICAgIHJldHVybiBOVUxMOwogCQlidWYgPSBzOwogCQli
cmVhazsKKwkgICAgY2FzZSAncycgOiB7CisJCSAgICBpbnRtYXhfdCBzZWM7
CisJCSAgICB0aW1lX3QgdDsKKworCQkgICAgc2VjID0gc3RydG9pbWF4IChi
dWYsICZzLCAxMCk7CisJCSAgICB0ID0gKHRpbWVfdClzZWM7CisJCSAgICBp
ZiAocyA9PSBidWYKKwkJCXx8IChpbnRtYXhfdCl0ICE9IHNlYworCQkJfHwg
bG9jYWx0aW1lX3IgKCZ0LCB0aW1lcHRyKSAhPSB0aW1lcHRyKQorCQkJcmV0
dXJuIE5VTEw7CisJCSAgICA7CisJCSAgICBidWYgPSBzOworCQkgICAgeW1k
IHw9IFNFVF9ZREFZIHwgU0VUX1dEQVkgfCBTRVRfWU1EOworCQkgICAgYnJl
YWs7CisJCX0KIAkgICAgY2FzZSAnUycgOgogCQlyZXQgPSBzdHJ0b2xfbCAo
YnVmLCAmcywgMTAsIGxvY2FsZSk7CiAJCWlmIChzID09IGJ1ZikK

--------------7A56D5B5DA3497A139629A78--
