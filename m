Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta24-re.btinternet.com
 [213.120.69.117])
 by sourceware.org (Postfix) with ESMTPS id 26556383E82D
 for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2020 14:48:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 26556383E82D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20201124144845.WXGT14484.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
 Tue, 24 Nov 2020 14:48:45 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C2FD1B9A5F44
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetleffgeetieduueetheffveelvdfffeefkefghffhhedvhffghfetheetleetkeenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeouehrihgrnhdrkfhnghhlihhssefuhihsthgvmhgrthhitgfuhgdrrggsrdgtrgeqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C2FD1B9A5F44; Tue, 24 Nov 2020 14:48:45 +0000
Subject: Re: [PATCH 1/2] specialnames.xml: add proc(5) Cygwin man page
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201123221101.16864-1-Brian.Inglis@SystematicSW.ab.ca>
 <20201123221101.16864-2-Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <4bb19539-82d9-d30b-3944-39b4183af1c0@dronecode.org.uk>
Date: Tue, 24 Nov 2020 14:48:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123221101.16864-2-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1200.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 24 Nov 2020 14:48:49 -0000

On 23/11/2020 22:11, Brian Inglis wrote:
> ---
>   winsup/doc/specialnames.xml | 2100 +++++++++++++++++++++++++++++++++++
>   1 file changed, 2100 insertions(+)

I'm not sure how you generated this email.  But sending the patch inline 
(using 'git-send-email'?), rather than as an attachment makes it a lot 
easier to make review comments inline.

A few lines have trailing whitespace, which should be removed.

> diff --git a/winsup/doc/specialnames.xml b/winsup/doc/specialnames.xml
> index a1f7401e16b9..6b86187f39e9 100644
> --- a/winsup/doc/specialnames.xml
> +++ b/winsup/doc/specialnames.xml
> @@ -486,6 +486,2106 @@ one in Linux, but it provides significant capabilities. The
>  <systemitem>procps</systemitem> package contains several utilities
>  that use it.
>  </para>
> +  <refentry id="proc">
> +    <!-- from Linux manpages project proc(5)

Should this say 'based on', to make it clear this isn't a literal copy 
of that?

> +
> +    <refentryinfo><date>2020-11-11</date></refentryinfo>
> +    <refmeta>
> +      <refentrytitle>proc</refentrytitle>
> +      <manvolnum>5</manvolnum>
> +      <refmiscinfo class='date'>2020-11-11</refmiscinfo>
> +      <refmiscinfo class='source'>Cygwin</refmiscinfo>
> +      <refmiscinfo class='manual'>Cygwin User's Manual</refmiscinfo>
> +    </refmeta>

I think the <date>s here should be omitted (rather than hoping someone 
remembers to update them when the relevant content is updated), which 
causes the build date to be used.

> +	  <varlistentry>
> +	    <term><filename>/proc/loadavg</filename></term>
> +	    <listitem>
> +	      <para>
> +	        The first three fields in this file are load average figures
> +	        giving the number of jobs in the run queue (state R) or waiting
> +	        for disk I/O (state D) averaged over 1, 5, and 15 minutes.
> +		They are the same as the load average numbers given by

As mentioned by Corinna previously, we don't know the 'D' state, so the 
loadavg is just computed from the run queue length.

> +	  <varlistentry>
> +	    <term><filename>/proc/registry</filename></term>
> +	    <listitem>
> +	      <para>
> +	        Under Windows, this directory contains subdirectories for
> +	        registry paths, keys, and subkeys, and files named for registry
> +	        values which contain registry data, for the current process.
> +	      </para>
> +

'Under Windows' seems redundant :)

> +	  <varlistentry>
> +	    <term><filename>/proc/version</filename></term>
> +	    <listitem>
> +	      <para>
> +	        This string identifies the kernel version that is currently

Kernel?

> +	<para>
> +	  Many files contain strings (e.g., the environment and command
> +	  line) that are in the internal format, with subfields terminated
> +	  by null bytes (&apos;&bsol;0&apos;).
> +	  When inspecting such files, you may find that the results are
> +	  more readable if you use a command of the following form to
> +	  display them:
> +
> +	  <screen>
> +	    <prompt>$</prompt> <userinput>cat -A <emphasis remap='I'>file</emphasis></userinput>
> +	  </screen>
> +	</para>
> +
> +	<para>
> +	  This manual page is incomplete, possibly inaccurate, and is the kind
> +	  of thing that needs to be updated very often.
> +	</para>

The above should be in a section 'BUGS' ?

> +
> +    <refsect1 id='proc-colophon'><title>Colophon</title>
> +      <para>
> +	This page is part of the <emphasis remap='I'>Cygwin</emphasis> project.

I'm guessing these 'remap' attributes are doclifter detritus and can be 
discarded.

> +	A description of the project, information about reporting bugs, and the
> +	latest documentation, can be found on
> +	<ulink
> +	url="https://cygwin.com/docs.html">the Cygwin project web pages</ulink>.
> +      </para>
> +    </refsect1>

It would be nice to include this colophon on all our manpages, but that 
probably requires more effort.

Nice work.

There also seem to be some docbook processing quirks which could bear 
further investigation:

The copyright section from legal.xml doesn't seem to make it into the 
proc.5 manpage, unlike all the others.

The proc.5 section appears as a manpage, and in the pdf output, but not 
in the html output.
