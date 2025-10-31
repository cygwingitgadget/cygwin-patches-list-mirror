Return-Path: <SRS0=5Fpr=5I=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 3874B3860C36
	for <cygwin-patches@cygwin.com>; Fri, 31 Oct 2025 19:30:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3874B3860C36
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3874B3860C36
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761939025; cv=none;
	b=iy+ap6xQRu9npT+RKgPxLZyMeLy5xLur0xgj1G6oxvK2KGkTAQvXiAuP4H7lbSdwJ4N98fsY5DcnVDkzX6CwiCHQkosvBHcFvy7gjmHlC9D3lgGwN7os5MfxL0Tz7nEvEDMv3+m70mBtNr+lKDlkng9LNUR1fCSfItTIZa9gWPE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761939025; c=relaxed/simple;
	bh=5ajEqkZ7hbaxA2C4uW9v1vgPSm9IX2YL4kpYMu3y37k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=R+z/Se9a8/tmweGdLJnIf5CCU202hjuyelAFAjL9tR9uPdnvInH+Nv1hDnIkQ8JCf4Q9fALsSfeEy8wH++PYzw7E2mwiHG59DrGwqNOyQ2C1h369ZewETBQrj9/e3YHOAjTs4nIbQ037bjaNl9J3tYsECGD/Xg4bgU6KUrNyLtE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3874B3860C36
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=aB1gJNN8
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 9D9C788C52
	for <cygwin-patches@cygwin.com>; Fri, 31 Oct 2025 19:30:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf18.hostedemail.com (Postfix) with ESMTPA id 34BF52E
	for <cygwin-patches@cygwin.com>; Fri, 31 Oct 2025 19:30:23 +0000 (UTC)
Message-ID: <9f69ae8d-4f17-49dd-9b64-0083eba62a1d@SystematicSW.ab.ca>
Date: Fri, 31 Oct 2025 13:30:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: Re: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <39e50846-f6d2-4dec-9d9e-ce4c4e963ace@maxrnd.com>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <39e50846-f6d2-4dec-9d9e-ce4c4e963ace@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 34BF52E
X-Stat-Signature: bc9irfreetdqyts4dh9n4qbrbczehmpc
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/t9Xq9JSMd3hVfKKTpYsuSdFLMI7pNuek=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:subject:reply-to:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=mPFhv46S+RX/gufRcWaF8mhJIYW0Ubjc6hdXakyB+JI=; b=aB1gJNN8Sgs7ay64Uk699y/ByuSAACeQmpYOALCM5JSaQJSRSKsLwFqdjWQHWaj1Tl+SaOPXP1Qzznm2TMBUx68Tn9HaPepweQ1eZfDl5GRgR7hEo4GcsuNxXOJSgsTp2vqQo2r6zXQT5otLbkn8ZYNgTQ1EdjJXPzRBYIaidmmKvI6oKeEnjXtEI696DJYXU9i5lwYe1wUuid/6M9q6axXwv03nG4B5Sp/+zPAspLrAyntgpe2FgBLt3n2TN+et0MIGHlc24dZTLwnlpRC2Ok5369iroj6YbOuCeAneh/P5uYHtQCEuoKkGom/qQs7OUpx6ISc7Vjh91ShmL8M4gA==
X-HE-Tag: 1761939023-940267
X-HE-Meta: U2FsdGVkX18bf5odr1A0qipI1yYxL/fh7CBEhDx3XfLM4S+KsPxPPgVc39jLt3qv8OrUHpSQ2onDapSzuPlkCBs125iFDKJ20yk0aT/iUm/oXr/jJscoEgSErF30x31V3MfcM44w38JGmHn599JYBfg9gyCDlYUSgn9WFcdVZ2IgdDxwJ7BuSSuIJ2fvUzlKbRjdXB0CuwAlmudoCQEUrqBfmmqdSATqzHgLVIAjAifGVz8UFzAzzlyGlV0AIjnrcTUUStaaaRkmt0ucPXa240eVWt4/4tlnwBrizCQvlN1JGFWCrtxoS+FJzTp7p0QytPAdgbBExftScZ/0BcZbqsJs8AS2nOMKTh1sk3dORXHQ5K6dhFdqcEBxWY3ILgdzyKvpZ6U5L1iWYMbJhPVJ94VjMeg8lJoo+klK3gFA6LxAjcJ+ydqLMxTcNilbHNIhlq2Iyn5QIwoHo4sGMDTxiLs+/19JuGNSTSrfTCRB6Y0I/ctwmJAxa23fHV7bPSG4
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-10-30 21:49, Mark Geisert wrote:
> Hi Thirumalai,
> 
> On 10/27/2025 1:23 AM, Thirumalai Nagalingam wrote:
>> Hi Everyone,
>>
>> Please find the below attached patch for review.
>>
>>    *   This patch fixes function declarations in shmtest.c by converting 
>> definitions to
>>
>> standard ANSI C prototypes to ensure compatibility with GCC 15.
>>
>> Thanks & regards
>> Thirumalai Nagalingam
>>
>> ============
>> In-lined patch:
>>
>> diff --git a/winsup/testsuite/winsup.api/shmtest.c b/winsup/testsuite/ 
>> winsup.api/shmtest.c
>> index e0b7acf7d..2c6c74e7a 100644
>> --- a/winsup/testsuite/winsup.api/shmtest.c
>> +++ b/winsup/testsuite/winsup.api/shmtest.c
>> @@ -74,10 +74,7 @@ key_t    shmkey;
>>
>>   size_t pgsize;
>>
>> -int
>> -main(argc, argv)
>> -   int argc;
>> -   char *argv[];
>> +int main(int argc, char **argv)
>>   {
>>      struct sigaction sa;
>>      struct shmid_ds s_ds;
>> @@ -177,18 +174,14 @@ main(argc, argv)
>>      exit (1);
>>   }
> 
> Thanks for looking into this issue.  Our Cygwin coding conventions specify that 
> function names should be at the left margin.  So...
> 
> int
> main(int argc, char **argv)
> {
>      ...
> }

Follow the GNU Coding Standards:

	https://www.gnu.org/prep/standards/

distributed as part of the autoconf2.7 package:

	$ info standards

although that is a few years out of date compared to the upstream

	https://savannah.gnu.org/projects/gnustandards/

It may be useful to include "Information for Maintainers of GNU Software" with 
cygport (and include the PDF in doc/ as well as info - ditto Standards)?

	https://www.gnu.org/prep/maintain/

> I've not patched the testsuite before so I'm unsure if the same submission 
> format applies here as applies to Cygwin DLL patches.
> 
> Namely, make the change in your git repo and commit it, use 'git format-patch 
> -1' to create a patch file, and then 'git send-email <filename>' to mail it to 
> cygwin-patches@cygwin.com.  Between the last two steps, use an editor to add a 
> patch description between the email headers and your patch.
> 
> I am doubly unsure if all the tracking info added to DLL patches needs to be 
> added to testsuite patches.  Here I mean Reported-by:, Addresses:, Signed-off- 
> by:, and Fixes:.  Maybe someone else can chime in on this?

We need to provide:

	git format-patch -s|--signoff
	git config format.signOff=true

to follow secure software development guidelines:

	https://sourceware.org/cyber-security-faq.html

• Encourage signed git commits and store public keys in gitsigur.

• Record all review actions in the final commit using tags like Co-Authored-By, 
Approved-By, Reviewed-By, Tested-By, Acked-by and add links to bugzilla and 
review threads on inbox.sourceware.org
[or cygwin.com/pipermail/cygwin{,-apps,-developers,-patches}/
or sourceware.org/newlib/]

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
