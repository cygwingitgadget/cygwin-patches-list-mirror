Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id D8F623857815
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 00:57:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D8F623857815
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id jtzKkR9yZbYg3jtzLkpZzO; Mon, 30 Nov 2020 17:57:51 -0700
X-Authority-Analysis: v=2.4 cv=Q4RsX66a c=1 sm=1 tr=0 ts=5fc5950f
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=CCpqsmhAAAAA:8 a=w_pzkKWiAAAA:8 a=cFFeOHI6LFvp-UQmzUoA:9
 a=QEXdDO2ut3YA:10 a=xzThDHTN9DUA:10 a=IfQ-iFkkCvMA:10
 a=ul9cdbp4aOFLsgKbc677:22 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
 <20201130104755.GE303847@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH v2 0/2] proc(5) man page
Message-ID: <f6be8646-4e4c-9133-f9ac-00a89a437aad@SystematicSw.ab.ca>
Date: Mon, 30 Nov 2020 17:57:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130104755.GE303847@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKAu3bMi49eEH9bC248xZJVM9CmkB/eZEPRnyJyfQl/AFBHq3zNWcA+jXtePuGHLuh6m9R4w0A9zKtXqj3s5WTIF9EpZFG6nWgVrmr6S2MYZg3+SSJwR
 pS/ukS5WYRQRQDynEQh59CiJHICl+EPpnmE28pkdXrOH0fp86/iFi0mbuO31oRJF/iOoMPb+l9A+zDX9MU1DNm2YssczOtUQFBY=
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 01 Dec 2020 00:57:53 -0000

On 2020-11-30 03:47, Corinna Vinschen wrote:
> On Nov 24 23:49, Brian Inglis wrote:
>> Brian Inglis (2):
>>    specialnames.xml: add proc(5) Cygwin man page
>>    winsup/doc/Makefile.in: create man5 dir and install generated proc.5
>>
>>   winsup/doc/Makefile.in      |    4 +
>>   winsup/doc/specialnames.xml | 2094 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 2098 insertions(+)

> It would be helpful if you could outline the changes from v1.

Those were fairly minor fixes to content and some processing outlined in the 
(lengthy) responses to Jon's (lengthy) comments under:
https://sourceware.org/pipermail/cygwin-patches/2020q4/010829.html

and I have copied them below, so please clarify if the below is not what you want?

> I'm not sure how you generated this email.  But sending the patch inline 
> (using 'git-send-email'?), rather than as an attachment makes it a lot easier
> to make review comments inline.
It's right from git send-email which creates the MIME sections in the patches:

"
...
  X-Mailer: git-send-email 2.29.2
...
  This is a multi-part message in MIME format.
  --------------2.29.2
  Content-Type: text/plain; charset=UTF-8; format=fixed
  Content-Transfer-Encoding: 8bit

  ---
  winsup/doc/specialnames.xml | 2100 +++++++++++++++++++++++++++++++++++
  1 file changed, 2100 insertions(+)

  --------------2.29.2
  Content-Type: text/x-patch; name="0001-specialnames.xml-add-proc-5-Cygwin-man- 
page.patch"
  Content-Transfer-Encoding: 8bit
  Content-Disposition: attachment; 
filename="0001-specialnames.xml-add-proc-5-Cygwin-man-page.patch"
..."

so it may be down to how your MUA displays those, and we are running the same 
release of TB, which on mine shows the patch "inline" after a filename separator 
like any other text attachment.
Ctrl-U displays email source including headers; search for 'User-Agent:' or 
'Mailer:' in headers.

 > A few lines have trailing whitespace, which should be removed.

Not in the patched lines, which appear in *RED* in git diff, and I just 
rechecked that they are in context lines, so I left them alone for separate 
cleanup, as I have been chastised on previous occasions. ;^>

 >> diff --git a/winsup/doc/specialnames.xml b/winsup/doc/specialnames.xml
 >> index a1f7401e16b9..6b86187f39e9 100644
 >> --- a/winsup/doc/specialnames.xml
 >> +++ b/winsup/doc/specialnames.xml
 >> @@ -486,6 +486,2106 @@ one in Linux, but it provides significant 
capabilities. The
 >>  <systemitem>procps</systemitem> package contains several utilities
 >>  that use it.
 >>  </para>
 >> +  <refentry id="proc">
 >> +    <!-- from Linux manpages project proc(5)
 >
 > Should this say 'based on', to make it clear this isn't a literal copy of that?

K

 >> +
 >> +    <refentryinfo><date>2020-11-11</date></refentryinfo>
 >> +    <refmeta>
 >> +      <refentrytitle>proc</refentrytitle>
 >> +      <manvolnum>5</manvolnum>
 >> +      <refmiscinfo class='date'>2020-11-11</refmiscinfo>
 >> +      <refmiscinfo class='source'>Cygwin</refmiscinfo>
 >> +      <refmiscinfo class='manual'>Cygwin User's Manual</refmiscinfo>
 >> +    </refmeta>
 >
 > I think the <date>s here should be omitted (rather than hoping someone 
remembers to update them when the relevant content is updated), which causes the 
build date to be used.

That's the point - showing how current the information is, not when it was last 
built.

 >> +      <varlistentry>
 >> +        <term><filename>/proc/loadavg</filename></term>
 >> +        <listitem>
 >> +          <para>
 >> +            The first three fields in this file are load average figures
 >> +            giving the number of jobs in the run queue (state R) or waiting
 >> +            for disk I/O (state D) averaged over 1, 5, and 15 minutes.
 >> +        They are the same as the load average numbers given by
 >
 > As mentioned by Corinna previously, we don't know the 'D' state, so the 
loadavg is just computed from the run queue length.

Code dispatches on 'D' state so I thought that statement was mistaken: will remove.

 >> +      <varlistentry>
 >> +        <term><filename>/proc/registry</filename></term>
 >> +        <listitem>
 >> +          <para>
 >> +            Under Windows, this directory contains subdirectories for
 >> +            registry paths, keys, and subkeys, and files named for registry
 >> +            values which contain registry data, for the current process.
 >> +          </para>
 >> +
 >
 > 'Under Windows' seems redundant :)

Will change to 'Cygwin' as the intent is to clarify this is a custom variation, 
not to be expected on Linux or Unix variations.

 >> +      <varlistentry>
 >> +        <term><filename>/proc/version</filename></term>
 >> +        <listitem>
 >> +          <para>
 >> +            This string identifies the kernel version that is currently
 >
 > Kernel?

Missed another edit to 'Cygwin'.

 >> +    <para>
 >> +      Many files contain strings (e.g., the environment and command
 >> +      line) that are in the internal format, with subfields terminated
 >> +      by null bytes (&apos;&bsol;0&apos;).
 >> +      When inspecting such files, you may find that the results are
 >> +      more readable if you use a command of the following form to
 >> +      display them:
 >> +
 >> +      <screen>
 >> +        <prompt>$</prompt> <userinput>cat -A <emphasis 
remap='I'>file</emphasis></userinput>
 >> +      </screen>
 >> +    </para>
 >> +
 >> +    <para>
 >> +      This manual page is incomplete, possibly inaccurate, and is the kind
 >> +      of thing that needs to be updated very often.
 >> +    </para>
 >
 > The above should be in a section 'BUGS' ?

It looks like .SH Notes and Copyright have been docliftered, edited into, or 
generated in the wrong place: I didn't notice that and will check the ins and outs.
In my proc.5 collection, these comments are mainly under .SH Notes except RH 
uses Caveats, not really appropriate for free/libre/open systems, but Bugs might be.

 >> +
 >> +    <refsect1 id='proc-colophon'><title>Colophon</title>
 >> +      <para>
 >> +    This page is part of the <emphasis remap='I'>Cygwin</emphasis> project.
 >
 > I'm guessing these 'remap' attributes are doclifter detritus and can be 
discarded.

I was hoping as they are in Docbook that they were rendering hints that would 
maintain the original format. So can I safely eliminate them?

 >> +    A description of the project, information about reporting bugs, and the
 >> +    latest documentation, can be found on
 >> +    <ulink
 >> +    url="https://cygwin.com/docs.html">the Cygwin project web pages</ulink>.
 >> +      </para>
 >> +    </refsect1>
 >
 > It would be nice to include this colophon on all our manpages, but that 
probably requires more effort.

Perhaps in other patches including trailing space cleanups?

 >> There also seem to be some docbook processing quirks which could bear 
further investigation:
 >
 > A lot that seem to result from the purely declarative syntax of the tags, 
that are not easy to ameliorate: I've dug, delved, tried and backed out changes 
and extra .xsl rules for some renderings.
 >
 >> The copyright section from legal.xml doesn't seem to make it into the proc.5 
manpage, unlike all the others.
 >
 > I only checked specialnames not the utility manpages as the content is so 
different, so I will check there to see how that works.
 >
 >> The proc.5 section appears as a manpage, and in the pdf output, but not in 
the html output.
 >
 > I'll see what differs between the HTML and PDF rendering, and the UG utility 
HTML manpages, but suspect content and paper dependent LaTeX and/or TeX 
intermediates for PDFs may be one difference.
 > [I prefer declarative epub xhtml+xml formats that are not pre-rendered onto 
A4/Letter substrates and that obey my CSS preferences on each of my devices.]

Colophon with embedded <ulink... truncated Copyright section to only the 
heading, and included link endnote appeared as final Notes section, so removed 
Colophon section and Copyright section appears complete.

Have not yet removed remap hints as unsure if they are used or useful.

Attached rendered outputs FYI.

Will regenerate and email patches.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
