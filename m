Return-Path: <cygwin-patches-return-9026-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50360 invoked by alias); 21 Feb 2018 21:20:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50245 invoked by uid 89); 21 Feb 2018 21:20:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=para, claims, HTo:U*cygwin-patches, Canada
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Feb 2018 21:20:34 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with ESMTP	id oboVe9IAoLkozoboWervy6; Wed, 21 Feb 2018 14:20:33 -0700
X-Authority-Analysis: v=2.3 cv=OeS28CbY c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=N659UExz7-8A:10 a=b4eMD0GmHX_ZvWjD-W0A:9 a=pILNOxqGKmIA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca>
Date: Wed, 21 Feb 2018 21:20:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221210534.GA7576@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCYfKKf/8eZikQQDb2qXGAKl/lM3L/U0ND1YogQAE1OMcP9mkhQte/jI20Do404loi5b13zs9h3tufIFoJbs4F+auo0G16PYcp/DpOtJNRwuzk+9K7TU qanfVYvI6Igd4Ic59olzrEHrC+rs6ZZSZmgneRKaKy8l6i4RC8/W1KFMiXyGdqgz551SITpSvskIQGmsUzso4tjwekhGVTKwpRE=
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00034.txt.bz2

On 2018-02-21 14:05, Corinna Vinschen wrote:
> Hi David,
> 
> On Feb 21 18:09, David Macek wrote:
>> ---
>>  winsup/doc/ntsec.xml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
>> index df1d54930..03293591b 100644
>> --- a/winsup/doc/ntsec.xml
>> +++ b/winsup/doc/ntsec.xml
>> @@ -914,7 +914,7 @@ This is not valid:
>>  </screen>
>>  <para>
>> -Apart from this restriction, the reminder of the line can have as
>> +Apart from this restriction, the remainder of the line can have as
>>  many spaces and TABs as you like.
>>  </para>
>> -- 
>> 2.16.2.windows.1
> 
> The patch is malformed.  It claims to contain 7 lines (6 lines context,
> one line changed), but actually it has only 4 lines context.  Please
> check your git settings.

"It's an een-justice!" -- Calimero
Check your mail client blank line squishing settings; I see:

> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
> index df1d54930..03293591b 100644
> --- a/winsup/doc/ntsec.xml
> +++ b/winsup/doc/ntsec.xml
> @@ -914,7 +914,7 @@ This is not valid:
>  </screen>
>  
>  <para>
> -Apart from this restriction, the reminder of the line can have as
> +Apart from this restriction, the remainder of the line can have as
>  many spaces and TABs as you like.
>  </para>
>  

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
