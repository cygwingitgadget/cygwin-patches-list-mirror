Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 40B433857C74
 for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021 15:51:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 40B433857C74
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id CP78lI9EgHmS3CP79lRPqF; Wed, 17 Feb 2021 08:51:44 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=602d3b90
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=ejknC5xS72zp2OFXFO8A:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20210215223540.18256-1-Brian.Inglis@SystematicSW.ab.ca>
 <YCus7LynfyqkvjWl@calimero.vinschen.de>
 <39425336-2abc-793e-f2fd-ac6ade12d55c@SystematicSw.ab.ca>
 <ac3a2eb5-2d56-c1ba-cd53-adf8adc41b07@SystematicSw.ab.ca>
 <YCzh+lCePeSgiRqf@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH v2] winsup/doc/posix.xml: add note for getrlimit,
 setrlimit, xrefs to notes
Message-ID: <813a08c9-aaac-0ef5-31de-3f92ec240f1c@SystematicSw.ab.ca>
Date: Wed, 17 Feb 2021 08:51:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCzh+lCePeSgiRqf@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHnJmsuDXMJR8m+sGrHtBVNES3aWXDTacE/bf+LEePmDxAW/nKK3Ye1FL4k7Hl2HXjEN+zWL8cF/wqbGuQduGyFTBBMwxXC7deS6r0q4KghV34GLmt+e
 DtO1LImwpZZtc5+cYWynjV7rdA6kFCIl6wHraboMz+46e4Eu4eR23/UKadbnv7EOobSvBDAMmt4ap0jnavnQ04gK5/Ma9QtIuWU=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Wed, 17 Feb 2021 15:51:47 -0000

On 2021-02-17 02:29, Corinna Vinschen via Cygwin-patches wrote:
> On Feb 16 10:00, Brian Inglis wrote:
>> On 2021-02-16 09:51, Brian Inglis wrote:
>>> On 2021-02-16 04:30, Corinna Vinschen via Cygwin-patches wrote:
>>>> On Feb 15 15:35, Brian Inglis wrote:
>>>>> change notes to see "Implementation Notes" to xref to std-notes;
>>>>> add xref to std-notes to getrlimit, setrlimit;
>>>>> add note to document limitations of getrlimit, setrlimit resources support
>>>>> ---
>>>>>    winsup/doc/posix.xml | 101 ++++++++++++++++++++++++-------------------
>>>>>    1 file changed, 57 insertions(+), 44 deletions(-)
>>>
>>>> Pushed with a change:
>>>>     <xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
>>>> -->
>>>>     (see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>>> The reason is how xref is handled when creating html docs.  The result
>>>> of an xref is always 'the section called "..."'.  With the above change,
>>>> the text works (albeit differently) in html and info file.
>>>
>>> Cheers, thanks, I'll bear that in mind in future, and read the generated
>>> output more carefully.
>>>
>>> I'm not seeing .info generated with Note:... links, is that okay?
> 
> db2x_docbook2texi from docbook2X is used for that.

Cygwin provides db2x_texixml in docbook2X 0.8.8

>>> Also ...api.pdf is no longer being regenerated, so what have I lost or am missing?
> 
> xmlto is doing this stuff, maybe the pdf option requires another package?

I thought that was dblatex via TeX and/or poppler

>>> I have the following doc tools (and others):
>>>
>>> $ apt l asciidoc dblatex poppler\$ xmlto
>>> asciidoc 8.6.9-1 x86_64 [installed, manual]
>>> dblatex 0.3.10-1 x86_64 [installed, automatic]
>>> poppler 21.01.0-1 x86_64 [installed, manual]
>>> xmlto 0.0.28-1 x86_64 [installed, automatic]
>>
>> Also as documented plus other dependencies:
>>
>> $ apt l build-docbook-catalog docbook-sgml45 docbook-utils docbook-xml45 \
>> 	docbook-xsl docbook2X
>> build-docbook-catalog 1.5-2 x86_64 [installed, automatic]
>> docbook-sgml45 4.5-1 x86_64 [installed, automatic]
>> docbook-utils 0.6.14-2 x86_64 [installed, manual]
>> docbook-xml45 4.5-1 x86_64 [installed, manual]
>> docbook-xsl 1.77.1-1 x86_64 [installed, automatic]
>> docbook2X 0.8.8-1 x86_64 [installed, manual]
>>
>>> What else is needed?
> 
> Good question.  I'm running that on Fedora with the following docbook
> packages installed:
> 
>    docbook-dtds
>    docbook-style-xsl
>    docbook-style-dsssl
>    docbook-utils
>    docbook2X

Also got docbook-dsssl and all but docbook-xsl-ns - will install that

> xmlto adds a dependency to flex.  docbook2X depends on texinfo, texinfo
> comes with a number of packages on the far side of infinity.

Got bison, byacc, and flex; texinfo requires only a few std libs and perl 
modules, it's not La/TeX.

> Jon?  Any idea?

Last cygwin-api.pdf generated was 2020 Nov 10, last cygwin-ug-net.pdf generated 
was 2020 Dec 17.

Missed error ignored by build:

...
xmlto --skip-validation --with-dblatex pdf -o cygwin-api/ -m 
../../../../winsup/doc/fo.xsl ../../../../winsup/doc/cygwin-api.xml
Traceback (most recent call last):
   File "/usr/bin/dblatex", line 10, in <module>
     from dbtexmf.dblatex import dblatex
ModuleNotFoundError: No module named 'dbtexmf'
make[3]: [Makefile:128: cygwin-api/cygwin-api.pdf] Error 1 (ignored)
...

Looks like it was installed by dblatex in python2.7/site-packages which I wiped 
when I dropped python2 et. al. and upgraded to python3. Oops - my bad!

$ cygcheck -c dblatex
Cygwin Package Information
Package              Version        Status
dblatex              0.3.10-1       Incomplete

Thanks for help and sorry for wasting time.
I need to upgrade anyway as there is a backlog of 187 packages waiting for me to 
download 84MB including dblatex and python3!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
