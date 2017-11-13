Return-Path: <cygwin-patches-return-8919-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53079 invoked by alias); 13 Nov 2017 07:05:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52005 invoked by uid 89); 13 Nov 2017 07:05:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=downloaded, routine, contacting, company
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Nov 2017 07:05:04 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id E8njeBlNbDJTWE8nkeKvCR; Mon, 13 Nov 2017 00:05:02 -0700
X-Authority-Analysis: v=2.2 cv=B4DJ6KlM c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=N659UExz7-8A:10 a=w_pzkKWiAAAA:8 a=Dgg3EY1OnwZhjXBHfeEA:9 a=pILNOxqGKmIA:10 a=buB1NfXUTBUA:10 a=hf7a2FvunDcA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Add FAQ 4.46. How do I fix find_fast_cwd warnings?
To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu> <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca> <8be9463b-1349-c309-afe1-828712489f74@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca>
Date: Mon, 13 Nov 2017 07:05:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8be9463b-1349-c309-afe1-828712489f74@cornell.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNbr3IXAnpe5gWx23e434fXRlU0NfiT2SNNQK98rQgco87Wp/oz35PydO3fi2K5Py+Wi6NgUi2sd1DaEg8JafNd3nVZQgE8UtRU9ywuvVQV1z1ZF0JB3 Sw7A+XlL7P4xoutLBSBNMwUaEjz9e+S5nOx5iW511A4Uq3UmIlE7FmcSlvExTX2P6zlzEjNFhtakyRUPER2eMRGSGFELoMdYAMY=
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00049.txt.bz2

On 2017-11-12 16:02, Ken Brown wrote:
> On 11/12/2017 4:27 PM, Brian Inglis wrote:
>> +    <para>Some ancient Cygwin releases asked users to report problems that were
>> +      difficult to diagnose to the mailing list with the message:</para>
>> +
>> +    <screen>find_fast_cwd: WARNING: Couldn't compute FAST_CWD pointer. Please
>> report
>> +    this problem to the public mailing listcygwin@cygwin.com</screen>
>> +
>> +    <para>These problems were fixed long ago in updated Cygwin releases.</para>
> 
> The wording of the warning message was changed 3 years ago, in commit 0793492. 
> I'm not sure that qualifies as ancient.  I also don't think it's accurate to
> refer to the problem as "difficult to diagnose" or to say that the problems
> "were fixed long ago".

The original message was added in 2011 - 1.7.10 maybe earlier - NT4 support was
dropped around then - pretty ancient in Cygwin terms of how many Windows
releases have had support dropped since then!

> The issue (Corinna will correct me if I'm wrong) is simply that new releases of
> Windows sometimes require changes in how Cygwin finds the fast_cwd pointer.  So
> users of old versions of Cygwin on new versions of Windows might have problems,
> and this can certainly happen again in the future.  But the FAQ doesn't need to
> go into that.  Why not just say what the warning currently says (see
> path.cc:find_fast_cwd()):
> 
> "This typically occurs if you're using an older Cygwin version on a newer
> Windows.  Please update to the latest available Cygwin version from
> https://cygwin.com/.  If the problem persists, please see
> https://cygwin.com/problems.html."
> 
> You can also add your sentence about contacting the vendor who provided the old
> Cygwin release.

We are trying in the FAQ entry to persuade an annoyed user that it may be in
their best interest to do some remediation, rather than just complain in an
email to an org they think is a company (cygwin.com) they have never heard of,
who they expect from their application message to take care of their problem
with no other effort on their part, and who they can blame if nothing happens.

Assuming they find the FAQ entry, emphatic language may persuade them to do
something more than the message says they should do.

First time anyone has mentioned the updated error message - I just hashed
together some emphatic comments folks on the list have made in response to
posts, to get things started.

Messages like "Couldn't compute FAST_CWD pointer" do not tell users what has
gone wrong in terms they can understand, indicate if it is something they might
be able to work around, or whether they can not do anything and should report a
problem, and how to do so usefully.

It would probably be best if such messages provided only a simplified
explanation like "Cygwin could not find how to get your current directory in
this Windows release" with a simple FAQ entry URI e.g.
...#current-directory-not-found for elaboration, and in this case maybe we could
just use the slow RtlGetCurrentDirectory_U routine.

We are getting little information on what apps these users are installing and
from where, that drop a Cygwin instance on their systems, with maybe no
information on how to upgrade, whether they are commercial products, or
abandonware downloaded from e.g. SourceForge.
Perhaps we should also be asking for some of these questions to be answered in
the FAQ entry.

Could we perhaps persuade the sourceware admins to add an email filter to
auto-reply with a link to the FAQ to any original FAST_CWD messages from
non-subscribers and also send the reply to the list to show it has done so?

I think we also need a FAQ entry advising developers on the best approach to
incorporate Cygwin Setup into their install and upgrade processes.
Should we recommend they develop their own packages using cygport and provide
their own local or remote mirror as in https://cygwin.com/package-server.html?
Is there an easy way to let their users pick an official mirror and add their
own mirror as in the section on "Creating an overlay Cygwin package server"?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
