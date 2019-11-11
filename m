Return-Path: <cygwin-patches-return-9829-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18124 invoked by alias); 11 Nov 2019 20:47:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18029 invoked by uid 89); 11 Nov 2019 20:47:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=8:ng, 8:na, passive, zur
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Nov 2019 20:47:35 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id UGayiwksrnCigUGaziq1Q4; Mon, 11 Nov 2019 13:47:33 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] regtool: Ignore /proc/registry{,32,64}/ prefix, with forward or backslashes, allowing path completion
To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca> <20191111091337.GE3372@calimero.vinschen.de> <20191111091909.GG3372@calimero.vinschen.de> <130d853b-1614-0e22-3bdd-c79f311ace0f@SystematicSw.ab.ca> <20191111162853.GI3372@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <5f5ad434-a01b-1609-1624-c47252e56f64@SystematicSw.ab.ca>
Date: Mon, 11 Nov 2019 20:47:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191111162853.GI3372@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00100.txt.bz2

On 2019-11-11 09:28, Corinna Vinschen wrote:
> On Nov 11 08:30, Brian Inglis wrote:
>> On 2019-11-11 02:19, Corinna Vinschen wrote:
>>> On Nov 11 10:13, Corinna Vinschen wrote:
>>>> On Nov 10 09:14, Brian Inglis wrote:
>>>> The patch idea is nice.  Two nits, though.
>>>> Please shorten the commit msg summary line and add a bit of descriptive
>>>> text instead.
>>
>> Sorry, I forget and don't notice longer than standard messages, from using
>> 120x60 or larger windows.
>>
>>>>> ---
>>>>>  winsup/utils/regtool.cc | 13 ++++++++++++-
>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/winsup/utils/regtool.cc b/winsup/utils/regtool.cc
>>>>> index a44d90768..ddb1304cd 100644
>>>>> --- a/winsup/utils/regtool.cc
>>>>> +++ b/winsup/utils/regtool.cc
>>>>> @@ -167,7 +167,9 @@ usage (FILE *where = stderr)
>>>>>        "  users    HKU   HKEY_USERS\n"
>>>>>        "\n"
>>>>>        "If the keyname starts with a forward slash ('/'), the forward slash is used\n"
>>>>> -      "as separator and the backslash can be used as escape character.\n");
>>>>> +      "as separator and the backslash can be used as escape character.\n"
>>>>> +      "If the keyname starts with /proc/registry{,32,64}/, using forward or backward\n"
>>>>> +      "slashes, allowing path completion, that part of the prefix is ignored.\n");
>>>>
>>>> Is that really essential user information?
>>
>> Absolutely essential!
>>
>>>> I assume this behaviour is something you just expected to work but then
>>>> didn't.  With your patch it now works as you expected.  So it's kind of
>>>> a bugfix, rather than a change of behaviour the user needs to learn about.
>>
>> To those with similar background or experience it may appear that it should be
>> supported, but hasn't been until now.
>>
>> It is definitely not expected behaviour, given how regedit, reg, etc. expect
>> only hive paths, and how the the current regtool --help reads, clearly expecting
>> Windows style backslash separated registry paths, probably pasted within single
>> quotes. That expectation is changed somewhat by the forward slash sentence.
>> Further changes to expectation needs more documentation.
>>
>>>> The above text is, IMHO, more confusing than helpful to a user just
>>>> asking for regtool --help.  I'd just drop it.
>>
>> It needs documented because it can not in any way be inferred from the existing
>> regtool ---help, and would not be expected, that it should work. It was never
>> previously supported or seen as helpful or necessary, so it should be seen as a
>> non-obvious "surprising" addition, in the opposite sense to "least surprise".
>>
>> Please someone suggest better wording for the help, as that is the only
>> documentation available, and is needed, to update existing and inform new users.
>> Like the code, I tried to maintain the style of the existing help.
>>
>> As an alternative, how about:
>> "To support path completion, a keyname prefix of /proc/registry{,32,64}/ is
>> ignored."
> 
> Ok, we can add something to the help text, but the text still sounds
> confusing, even the altenative one.  I think the reason is the negative
> expression "ignore" here.  Why not express this in a positive way like
> this:
> 
>   "Use the /proc/registry{,32,64}/ registry path prefix to utilize path
>    completion."
> 
> Something like that anyway.

Maybe something may be misinterpreted from your consideration of International
English wording that is not even considered in my native English; "is ignored"
is passive voice but not negative in English, and neither does it appear to be
so in Deutsch (via Google): "Zur UnterstÃ¼tzung der PfadvervollstÃ¤ndigung wird
das SchlÃ¼sselnamenprÃ¤fix /proc/registry{,32,64}/ ignoriert."
Please advise if you can think why there is a wording issue.

I found the doc/utils.xml entry and added the improved sentence to both,
changing the example to be consistent and the better choice to exemplify the
alternative, and better fit the UG, man pages, and --help.

Please review the resubmission.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
