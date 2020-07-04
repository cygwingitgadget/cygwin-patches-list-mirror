Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 540A73844041
 for <cygwin-patches@cygwin.com>; Sat,  4 Jul 2020 17:31:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 540A73844041
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id rm0zj6IKYFXePrm10jAkcH; Sat, 04 Jul 2020 11:31:50 -0600
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=1aXmNyeANRQqbgJahQUA:9
 a=qtViSuBYugYqSnX2:21 a=jrT4zNLgkUQeh_RB:21 a=QEXdDO2ut3YA:10
 a=FhXMovWKs60A:10 a=daI9ojH3vpgA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Clarify FAQ 1.5 What version of Cygwin is this, anyway?
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200703231716.24076-1-Brian.Inglis@SystematicSW.ab.ca>
 <c30067ad-2a47-bd21-1ca4-21d4c3c217ba@SystematicSw.ab.ca>
 <f525fe8f-8c72-3c28-2910-0e0cdc58b62d@dronecode.org.uk>
Cc: Jon Turney <jon.turney@dronecode.org.uk>
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
Message-ID: <8d92bc01-f5a0-73e0-8715-4e155abaa9d8@SystematicSw.ab.ca>
Date: Sat, 4 Jul 2020 11:31:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f525fe8f-8c72-3c28-2910-0e0cdc58b62d@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfACVcY2Eb/2ehFJ4YBhvyGk7GV5Hb8fuy34Q53Dl7tHQcASlsn3AZ8yF4Qmu1sj6DolsjFPFgpCxmtBcOth1n4vV/BdBKQ7FIyO4G+FDunAuPeTU2f6l
 uWmoGXwEneaNFX3qE4gkMQgrXpzHs93Zy+K4bYlOhszBASrZ6cfkH7jg3pcIFLNjSiYr2fpSrY+i4eBfAJhYXgjYdgA0AbOu9brwR+YYgVdTq6U5mMyzKje/
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00, BODY_8BITS,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sat, 04 Jul 2020 17:31:53 -0000

On 2020-07-04 09:35, Jon Turney wrote:
> On 04/07/2020 04:47, Brian Inglis wrote:
>> On 2020-07-03 17:17, Brian Inglis wrote:
>>> Relate Cygwin DLL to Unix kernel,
>>> add required options to command examples,
>>> differentiate Unix and Cygwin commands;
>>> mention that the cygwin package contains the DLL.
>>>
>>> ---
>>>   faq/faq.html | 34 ++++++++++++++++++++++++----------
>>>   1 file changed, 24 insertions(+), 10 deletions(-)
>>
>> Patch to:
>>     https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html;hb=HEAD
>> as a result of thread:
>>     https://cygwin.com/pipermail/cygwin/2020-July/245442.html
> 
> Thanks for looking at this.
> 
> My perspective is that, if (as appears to be the case here) the problem is with
> people who can't or won't read and *absorb* the available information, the
> solution is not to add more words reiterating and expanding, but rather to focus
> on clarifying the existing words.
> 
> So, I'd think this faq should start with a paragraph consisting of a single
> sentence similar to:
> 
> "To find the version of the Cygwin DLL installed, you can use `uname -a`, as you
> would for a Unix kernel".
> 
> Feel free to elaborate on alternatives and refinements on that in later paragraphs.
> 
> If you're touching this FAQ, please also replace the literal `setup.exe` with
> `the setup program` or similar circumlocutions, as we no longer use that literal
> name.

Thanks Jon,

Good point, this will now read:

"1.5. What version of Cygwin is this, anyway?

To find the version of the Cygwin DLL installed, you can use: *uname -a*; as you
would for a Unix kernel. As the Cygwin DLL takes the place of a Unix kernel, you
can also use any of the Unix compatible commands: *uname -srvm*;
*head /proc/version*; or the Cygwin command: *cygcheck -V*. Refer to each
command's `--help` output or the _Cygwin User's Guide_ for more information.

If you are looking for the version number for the whole Cygwin release, there is
none. Each package in the Cygwin release has its own version, and the cygwin
package containing the Cygwin DLL and Cygwin system specific utilities is just
another (but very important!) package. The packages in Cygwin are continually
improving, thanks to the efforts of net volunteers who maintain the Cygwin
binary ports. Each package has its own version numbers and its own release process.

So, how do you get the most up-to-date version of Cygwin? Easy. Just download
the Cygwin Setup program by following the instructions _here_. The Setup program
will handle the task of updating the packages on your system to the latest
version. For more information about using Cygwin's Setup program, see _Setting
Up Cygwin_ in the Cygwin User's Guide."

and I have also changed the other occurrences of setup.exe to use the Cygwin
Setup program or similar.

In the above, I think we should also change the link _here_ (so '90s!) to
_installation instructions_.

Maybe also under 1.6:

	https://cygwin.com/faq.html#faq.what.who

which seems to be from when Redhat sold Cygwin, so:
- comment out or otherwise memorialize Yaakov;
- omit Redhat from Corinna's entry, and clean up;
- change "people; a complete list can be found _here_" link to just _maintainers_;
- anyone else with committer rights who should be added?
- maybe update that guy Jon? ;^>

In the following para:

"Please note that all of us working on Cygwin try to be as responsive as
possible and deal with patches and questions as we get them, but realistically
we don't have time to answer all of the email that is sent to the main mailing
list. Making Net releases of the Win32 tools and helping people on the Net out
is not our primary job function, so some email will have to go unanswered."

"working" to "volunteering";
remove "Win32" and "Net" there and earlier paras;
change "is not our primary job function" to "is an activity in our spare time":

Anyhting else that comes to mind?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
