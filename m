Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id A4AF33844041
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 16:49:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A4AF33844041
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id k8qXkVIODbYg3k8qYkr9Yq; Tue, 01 Dec 2020 09:49:46 -0700
X-Authority-Analysis: v=2.4 cv=Q4RsX66a c=1 sm=1 tr=0 ts=5fc6742a
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=CCpqsmhAAAAA:8 a=uYT-Tk0qkVT609LjNaIA:9 a=QEXdDO2ut3YA:10
 a=xzThDHTN9DUA:10 a=ul9cdbp4aOFLsgKbc677:22
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
 <20201130104755.GE303847@calimero.vinschen.de>
 <f6be8646-4e4c-9133-f9ac-00a89a437aad@SystematicSw.ab.ca>
 <20201201095554.GK303847@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH v2 0/2] proc(5) man page
Message-ID: <48e990d4-f527-1eb1-f2ce-6fc0e594c99d@SystematicSw.ab.ca>
Date: Tue, 1 Dec 2020 09:49:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201095554.GK303847@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBBzVUhRo2OITPVlkq+r/Ci2rg2alIxVt8746ube5GVvzntmk1GyHblJBzdcZhK2vL6rSJ2MT1VpyTeRRglibiyopureU3ekSbsCQrJcbrT6TRHUoSdp
 cpx6l+hUYGWCv14EGS71DL4jF5PU0U/NZpjuAq56yOXfnivF/dvTOxPrmlJLpSabboETnG59g6wKThr48AZzPzjV6aHl20ANub8=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 01 Dec 2020 16:49:49 -0000

On 2020-12-01 02:55, Corinna Vinschen wrote:
> On Nov 30 17:57, Brian Inglis wrote:
>> On 2020-11-30 03:47, Corinna Vinschen wrote:
>>> On Nov 24 23:49, Brian Inglis wrote:
>>>> Brian Inglis (2):
>>>>     specialnames.xml: add proc(5) Cygwin man page
>>>>     winsup/doc/Makefile.in: create man5 dir and install generated proc.5
>>>>
>>>>    winsup/doc/Makefile.in      |    4 +
>>>>    winsup/doc/specialnames.xml | 2094 +++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 2098 insertions(+)
>>
>>> It would be helpful if you could outline the changes from v1.
>>
>> Those were fairly minor fixes to content and some processing outlined in the
>> (lengthy) responses to Jon's (lengthy) comments under:
>> https://sourceware.org/pipermail/cygwin-patches/2020q4/010829.html
>>
>> and I have copied them below, so please clarify if the below is not what you want?
> 
> I was after a short list with bullet points, ratehr than copying
> an email I have in my inbox anyway :}
> 
> Jon, can you please take another look, too?

* patches are sent directly from git send-email
* trailing whitespace only in Makefile.in context lines so left as is
* comment changed to "based on" Linux manpages project proc(5)
* dates retained to show how current content is, rather than when last built
* /proc/loadavg 'D' state mention removed
* /proc/registry Windows changed to Cygwin to clarify this variation
* /proc/version kernel changed to Cygwin
* Notes subsection missing title and Copyright subsection not included in 
standalone man page due to Colophon subsection messing up man rendering
* removed Colophon subsection and Notes reappears properly and Copyright is 
included; other system show these under Notes except RH uses Caveats
* retain remap attributes as Docbook rendering hints

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
