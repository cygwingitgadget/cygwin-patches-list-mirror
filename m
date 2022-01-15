Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id 90BA93858D3C
 for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2022 23:00:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 90BA93858D3C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id 8rHNnZSLG5Rf18s2TnLU53; Sat, 15 Jan 2022 23:00:49 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id 8s2SnLpP1Nat48s2SnDS9a; Sat, 15 Jan 2022 23:00:49 +0000
X-Authority-Analysis: v=2.4 cv=e9cV9Il/ c=1 sm=1 tr=0 ts=61e35221
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=2oDss0_NZfxSFxwdtH8A:9 a=QEXdDO2ut3YA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <6eeba4f9-6951-d018-cbee-7dc6e40c924b@SystematicSw.ab.ca>
Date: Sat, 15 Jan 2022 16:00:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: Conditionally build documentation
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
 <06431ef7-3239-b2e7-06c1-b9b4e4090df1@dronecode.org.uk>
 <DM8PR09MB70955355574135F9CB346D82A5559@DM8PR09MB7095.namprd09.prod.outlook.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <DM8PR09MB70955355574135F9CB346D82A5559@DM8PR09MB7095.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFp0ugJ50GbOVlYnayAw1DvFgfuaAEY6W73kyR45wEGmDHt1w7f045Q479fn6ljTAxbPZr1BmtYUBDMjVf0rFWomzoKFipkAIrATKgg3DSJIBhdn8V3k
 9Wx+VNicQCao+VRpEnLBXa6MMS81dbwiiey+8bbMpYTmz/VfCmpur5A7SBDQlVXfn0uTaS7Q/kbCFje75f6TiiDMEclah2eBzoU=
X-Spam-Status: No, score=-1160.7 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Sat, 15 Jan 2022 23:00:50 -0000

On 2022-01-15 12:06, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via 
Cygwin-patches wrote:
>> It is reported by 'configure --help', at the appropriate level (although
>> since enable is the default, I probably should have written
>> '--disable-doc' here).
> 
> I'm sorry if I'm missing anything, but I updated y'day and this is what I see regarding the doc in configure:
> 
> $ ./configure --help | grep doc
>    --infodir=DIR           info documentation [DATAROOTDIR/info]
>    --mandir=DIR            man documentation [DATAROOTDIR/man]
>    --docdir=DIR            documentation root [DATAROOTDIR/doc/PACKAGE]
>    --htmldir=DIR           html documentation [DOCDIR]
>    --dvidir=DIR            dvi documentation [DOCDIR]
>    --pdfdir=DIR            pdf documentation [DOCDIR]
>    --psdir=DIR             ps documentation [DOCDIR]

It looks like it's not propagated to newlib-cygwin/configure, and 
newlib-cygwin/configure --help=recursive seems to loop recursing on 
newlib 4.2.0, so it's only shown by winsup/configure:

$ ../winsup/configure --help=short
Configuration of Cygwin 0:

Optional Features:
   --disable-option-checking  ignore unrecognized --enable/--with options
   --disable-FEATURE       do not include FEATURE (same as 
--enable-FEATURE=no)
   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
   --enable-silent-rules   less verbose build output (undo: "make V=1")
   --disable-silent-rules  verbose build output (undo: "make V=0")
   --enable-dependency-tracking
                           do not reject slow dependency extractors
   --disable-dependency-tracking
                           speeds up one-time build
   --enable-debugging      Build a cygwin DLL which has more consistency
                           checking for debugging
   --enable-doc            Build documentation

Optional Packages:
   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
   --with-cross-bootstrap  do not build programs using the MinGW 
toolchain or
                           check for MinGW libraries (useful for 
bootstrapping
                           a cross-compiler)

Some influential environment variables:
   CC          C compiler command
   CFLAGS      C compiler flags
   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
               nonstandard directory <lib dir>
   LIBS        libraries to pass to the linker, e.g. -l<library>
   CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
               you have headers in a nonstandard directory <include dir>
   CXX         C++ compiler command
   CXXFLAGS    C++ compiler flags
   CPP         C preprocessor
   CCAS        assembler compiler command (defaults to CC)
   CCASFLAGS   assembler compiler flags (defaults to CFLAGS)

Use these variables to override the choices made by `configure' or to help
it to find libraries and programs with nonstandard names/locations.

Report bugs to <cygwin@cygwin.com>.
Cygwin home page: <https://cygwin.com>.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
