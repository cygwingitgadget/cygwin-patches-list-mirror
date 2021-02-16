Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 5FA40384400A
 for <cygwin-patches@cygwin.com>; Tue, 16 Feb 2021 16:51:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5FA40384400A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id C3Z6lad1rnRGtC3Z7lwoFL; Tue, 16 Feb 2021 09:51:09 -0700
X-Authority-Analysis: v=2.4 cv=cagXElPM c=1 sm=1 tr=0 ts=602bf7fd
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20210215223540.18256-1-Brian.Inglis@SystematicSW.ab.ca>
 <YCus7LynfyqkvjWl@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH v2] winsup/doc/posix.xml: add note for getrlimit,
 setrlimit, xrefs to notes
Message-ID: <39425336-2abc-793e-f2fd-ac6ade12d55c@SystematicSw.ab.ca>
Date: Tue, 16 Feb 2021 09:51:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCus7LynfyqkvjWl@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMGhVfwOYvFOgXI+oRYEWnnI9aYnFowbOnhHmrrzjtSS2I3uZTIE6es4SVc2Wmk0auMisn6eN6dSlUF8mVPhfNvcb18NF/G9o4ZlctQ32RybWX78MY6I
 C0vwspBxs6cTwEAebJ1aC8fZiXfIDUd6oEwveQqWnGAZ6lpesdao8/UfnfVlAtzz87XvRRQBvfPPcvlmGZ+DavVx+G/0rSTST/Y=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 16 Feb 2021 16:51:11 -0000

On 2021-02-16 04:30, Corinna Vinschen via Cygwin-patches wrote:
> On Feb 15 15:35, Brian Inglis wrote:
>> change notes to see "Implementation Notes" to xref to std-notes;
>> add xref to std-notes to getrlimit, setrlimit;
>> add note to document limitations of getrlimit, setrlimit resources support
>> ---
>>   winsup/doc/posix.xml | 101 ++++++++++++++++++++++++-------------------
>>   1 file changed, 57 insertions(+), 44 deletions(-)

> Pushed with a change:
>    <xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
> -->
>    (see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
> The reason is how xref is handled when creating html docs.  The result
> of an xref is always 'the section called "..."'.  With the above change,
> the text works (albeit differently) in html and info file.

Cheers, thanks, I'll bear that in mind in future, and read the generated output 
more carefully.

I'm not seeing .info generated with Note:... links, is that okay?

Also ...api.pdf is not being regenerated, so what have I lost or am missing?

I have the following doc tools (and others):

$ apt l asciidoc dblatex poppler\$ xmlto
asciidoc 8.6.9-1 x86_64 [installed, manual]
dblatex 0.3.10-1 x86_64 [installed, automatic]
poppler 21.01.0-1 x86_64 [installed, manual]
xmlto 0.0.28-1 x86_64 [installed, automatic]

What else is needed?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
