Return-Path: <cygwin-patches-return-8982-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103384 invoked by alias); 21 Dec 2017 02:26:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103368 invoked by uid 89); 21 Dec 2017 02:26:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=PDF, calgary, Calgary, HTo:U*cygwin-patches
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 21 Dec 2017 02:26:27 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with ESMTP	id RqYyed3Y8Yy1iRqYzekiYH; Wed, 20 Dec 2017 19:26:26 -0700
X-Authority-Analysis: v=2.2 cv=f8g4PK6M c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=N659UExz7-8A:10 a=b4eMD0GmHX_ZvWjD-W0A:9 a=pILNOxqGKmIA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] winsup/doc/etc.postinstall.cygwin-doc.sh fix shell variable typo
To: cygwin-patches@cygwin.com
References: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca> <0a3543fb-d85a-90c5-65f0-dedbaee5ad28@redhat.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <66aa6880-5c66-7b02-12bf-9550a54b9f8f@SystematicSw.ab.ca>
Date: Thu, 21 Dec 2017 02:26:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <0a3543fb-d85a-90c5-65f0-dedbaee5ad28@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNBsVS9OuzU5+2KyJbQc55p3hMkVLzjyfaGO8oa+9CjLVb79AVd/j/fJXSqSsZMjl2QJSqqIVagJaFLI/CY/j2BozN9fBGPrtHHsnDOvTkV2uDVQzZuH giCcLN1d42vjAHKTk8tCu1BC14WFZWovVSNii/bR+qt38UzZmlxiyScpsfuqVS4a5AsIzdkBfFfqxo+ThIo4cYmxO68IgBY4Grc=
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00112.txt.bz2

On 2017-12-20 16:10, Eric Blake wrote:
> On 12/20/2017 05:01 PM, Brian Inglis wrote:
>> ---
>>   winsup/doc/etc.postinstall.cygwin-doc.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh
>> b/winsup/doc/etc.postinstall.cygwin-doc.sh
>> index 2873d9395..935bd94e1 100755
>> --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
>> +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
>> @@ -52,7 +52,7 @@ fi
>>   # create User Guide and API PDF and HTML shortcuts
>>   while read target name desc
>>   do
>> -    [ -r $t ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target
>> +    [ -r $target ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" --
>> $target
> 
> Wrong.  Needs to be [ -r "$target" ] to be properly quoted.

From working with Windows paths, I feel I often overdo the quotes: originally
had both uses quoted, then seeing the diff, took them off again, pre-commit.
Those are base Cygwin paths - don't *need* quotes - unless you feel shell var
uses should be quoted just in case, or just in tests?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
