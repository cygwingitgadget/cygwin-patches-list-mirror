Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id A27643842400
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 17:41:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A27643842400
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id tx1njQLiRYYpxtx1ojDGRS; Fri, 10 Jul 2020 11:41:40 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=D-hjUeOzi2gWLipTs3oA:9
 a=f0xZFoIWU-LcT3Pn:21 a=QEXdDO2ut3YA:10 a=WK-i71OpKu4A:10 a=uvLZkzHzGa8A:10
 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Clarify FAQ 1.5 What version of Cygwin is this,
 anyway? Relate Cygwin DLL to Unix kernel, add required options to command
 examples, differentiate Unix and Cygwin commands; mention that the cygwin
 package contains the DLL.
To: cygwin-patches@cygwin.com
References: <20200710011544.28272-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200710011544.28272-2-Brian.Inglis@SystematicSW.ab.ca>
 <20200710083530.GE514059@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Autocrypt: addr=Brian.Inglis@SystematicSw.ab.ca; prefer-encrypt=mutual;
 keydata=
 mDMEXopx8xYJKwYBBAHaRw8BAQdAnCK0qv/xwUCCZQoA9BHRYpstERrspfT0NkUWQVuoePa0
 LkJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3RlbWF0aWNTdy5hYi5jYT6IlgQTFggA
 PhYhBMM5/lbU970GBS2bZB62lxu92I8YBQJeinHzAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAAAoJEB62lxu92I8Y0ioBAI8xrggNxziAVmr+Xm6nnyjoujMqWcq3oEhlYGAO
 WacZAQDFtdDx2koSVSoOmfaOyRTbIWSf9/Cjai29060fsmdsDLg4BF6KcfMSCisGAQQBl1UB
 BQEBB0Awv8kHI2PaEgViDqzbnoe8B9KMHoBZLS92HdC7ZPh8HQMBCAeIfgQYFggAJhYhBMM5
 /lbU970GBS2bZB62lxu92I8YBQJeinHzAhsMBQkJZgGAAAoJEB62lxu92I8YZwUBAJw/74rF
 IyaSsGI7ewCdCy88Lce/kdwX7zGwid+f8NZ3AQC/ezTFFi5obXnyMxZJN464nPXiggtT9gN5
 RSyTY8X+AQ==
Organization: Systematic Software
Message-ID: <06e5b3b4-ad8a-27fa-1b40-8d30ef58655c@SystematicSw.ab.ca>
Date: Fri, 10 Jul 2020 11:41:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710083530.GE514059@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKF2/GP+l861rSzkkWD2ESRqWFdCvIcaivLuUNRjLokOT3+l3CCoNmjxuWskuxDPmF0Lb2Af1xxqfF+yh8uoNYeeilukb9O7Awhn7kHewqRugy7rrI/v
 kOj64gLCLFUIOpFvRfcG06cfnveluDNfjxoLxpwvwk7BRErrzaW2XF8nNIndlD3V6qQSEKP+71FoEg==
X-Spam-Status: No, score=-14.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 10 Jul 2020 17:41:43 -0000

Thanks, Gotcha - sent all rather than waiting for chance to edit 2/2 - ops do
sometimes seem to squash commit messages - fixed - added refs to list threads -
sent v3 - learned do do something new in git.

On 2020-07-10 02:35, Corinna Vinschen wrote:
> I'd like to suggest to merge the two patches into one.  Also, check your
> log message of patch 2.  It looks like there's an empty line missing in
> line 2.
> On Jul  9 19:15, Brian Inglis wrote:
>> ---
>>  faq/faq.html | 25 ++++++++++++++-----------
>>  1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/faq/faq.html b/faq/faq.html
>> index 846e087e..8659db5d 100644
>> --- a/faq/faq.html
>> +++ b/faq/faq.html
>> @@ -57,10 +57,12 @@ freedoms, so it is free software.
>>  <tr class="question"><td align="left" valign="top"><a name="faq.what.version"></a><p><b>1.5.</b></p></td>
>>      <td align="left" valign="top"><p>What version of Cygwin <span class="emphasis"><em>is</em></span> this, anyway?</p></td></tr>
>>  <tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top">
>> -    <p>As the Cygwin DLL takes the place of a Unix kernel,
>> -	to find the version of the Cygwin DLL installed,
>> -	you can use any of the Unix compatible commands:
>> +    <p>To find the version of the Cygwin DLL installed,
>> +	you can use:
>>  	<code class="command"><strong>uname&nbsp;-a</strong></code>;
>> +        as you would for a Unix kernel.
>> +        As the Cygwin DLL takes the place of a Unix kernel,
>> +	you can also use any of the Unix compatible commands:
>>  	<code class="command"><strong>uname&nbsp;-srvm</strong></code>;
>>  	<code class="command"><strong>head&nbsp;/proc/version</strong></code>;
>>  	or the Cygwin command:
>> @@ -72,17 +74,18 @@ freedoms, so it is free software.
>>      <p>If you are looking for the version number for the whole Cygwin release,
>>  	there is none.
>>  	Each package in the Cygwin release has its own version, and the
>> -	<code class="package">cygwin</code> package containing the Cygwin DLL and
>> -	Cygwin system specific utilities is just another (but very important!) package.
>> +	<code class="package">cygwin</code> package containing the Cygwin DLL
>> +	and Cygwin system specific utilities is just another (but very
>> +	important!) package.
>>  	The packages in Cygwin are continually improving, thanks to
>>  	the efforts of net volunteers who maintain the Cygwin binary ports.
>>  	Each package has its own version numbers and its own release process.
>>  </p><p>So, how do you get the most up-to-date version of Cygwin?  Easy.  Just
>>  download the Cygwin Setup program by following the instructions
>>  <a class="ulink" href="https://cygwin.com/install.html" target="_top">here</a>.
>> -The setup program will handle the task of updating the packages on your system
>> -to the latest version. For more information about using Cygwin's
>> -<code class="filename">setup.exe</code>, see 
>> +The Setup program will handle the task of updating the packages on your system
>> +to the latest version. For more information about using Cygwin's Setup program,
>> +see 
>>  <a class="ulink" href="https://cygwin.com/cygwin-ug-net/setup-net.html" target="_top">Setting Up Cygwin</a>
>>  in the Cygwin User's Guide. 
>>  </p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.what.who"></a><p><b>1.6.</b></p></td><td align="left" valign="top"><p>Who's behind the project?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p><span class="bold"><strong>(Please note that if you have cygwin-specific
>> @@ -706,7 +709,8 @@ user with <code class="literal">cygrunsrv -u</code> (see
>>  information).
>>  </p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.using.path"></a><p><b>4.5.</b></p></td><td align="left" valign="top"><p>How should I set my PATH?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p>This is done for you in the file /etc/profile, which is sourced by bash
>>  when you start it from the Desktop or Start Menu shortcut, created by
>> -<code class="literal">setup.exe</code>.  The line is
>> +the Cygwin Setup program.
>> +The line is
>>  </p><pre class="screen">
>>  	PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
>>  </pre><p>Effectively, this <span class="bold"><strong>prepends</strong></span> /usr/local/bin and /usr/bin to your
>> @@ -903,8 +907,7 @@ services like sshd) beforehand.</p><p>The only DLL that is sanctioned by the Cyg
>>  you get by running <a class="ulink" href="https://cygwin.com/install.html" target="_top">setup-x86.exe or setup-x86_64.exe</a>,
>>  installed in a directory controlled by this program.  If you have other
>>  versions on your system and desire help from the cygwin project, you should
>> -delete or rename all DLLs that are not installed by
>> -<code class="filename">setup.exe</code>.
>> +delete or rename all DLLs that are not installed by the Cygwin Setup program.
>>  </p><p>If you're trying to find multiple versions of the DLL that are causing
>>  this problem, reboot first, in case DLLs still loaded in memory are the
>>  cause.  Then use the Windows System find utility to search your whole
>> -- 
>> 2.27.0
> 

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
