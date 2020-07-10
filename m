Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 247693857015
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 18:20:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 247693857015
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id txdHjQb3PYYpxtxdIjDPP2; Fri, 10 Jul 2020 12:20:24 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=aB2g5wahJ4JDfyxa0twA:9
 a=qjWx9TJRr6gat1BG:21 a=-hbMTUNa-e8o7ceb:21 a=QEXdDO2ut3YA:10
 a=daI9ojH3vpgA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: cygwin-patches@cygwin.com
Subject: Update FAQ 1.6 Who's behind the project?
To: cygwin-patches@cygwin.com
References: <20200710011544.28272-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200710011544.28272-2-Brian.Inglis@SystematicSW.ab.ca>
 <20200710083530.GE514059@calimero.vinschen.de>
 <06e5b3b4-ad8a-27fa-1b40-8d30ef58655c@SystematicSw.ab.ca>
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
Message-ID: <910b7d17-eb5b-6a94-2992-23b2df3b936b@SystematicSw.ab.ca>
Date: Fri, 10 Jul 2020 12:20:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <06e5b3b4-ad8a-27fa-1b40-8d30ef58655c@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNhWsTAwCsC9DxiCLIOLFW8B9rjbR7VxQ1mIkuHXyu5yD4LBh66Tjmcp/VQERI6QkJTxaUsx3dY+eHdotxHwUq3almdO19Za2chVSSUd8S3uz4oxPAza
 6PCEg36kYHClgptqhInlrN+/yunZ0Cro/rnPtNhUSeLLLnJeh/E8BaWKtLJRqulMVk6K5rU4i8C+qQ==
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 10 Jul 2020 18:20:26 -0000

Suggest also under 1.6:

	https://cygwin.com/faq.html#faq.what.who

which seems to be from when Redhat sold Cygwin, so:

- omit Redhat from Corinna's entry, and clean up:

"Corinna Vinschen is the current project lead. Corinna is a senior Red Hat
engineer. Corinna is responsible for the Cygwin library and maintains a couple
of packages, for instance OpenSSH, OpenSSL, and a lot more."

	Corinna Vinschen is the current project lead, responsible for the Cygwin
library and maintains OpenSSH, OpenSSL and a lot more.

- comment out or credit Yaakov;

...

- change "people; a complete list can be found _here_" link to just _maintainers_:

"The packages in the Net release are maintained by a large group of people; a
complete list can be found _here_."

	The packages are maintained by a large group of _maintainers_.

- anyone else with committer rights who should be added/credited?

Following para:

"Please note that all of us working on Cygwin try to be as responsive as
possible and deal with patches and questions as we get them, but realistically
we don't have time to answer all of the email that is sent to the main mailing
list. Making Net releases of the Win32 tools and helping people on the Net out
is not our primary job function, so some email will have to go unanswered."

"working" to "volunteering";
remove "Win32" and "Net" there and earlier paras;
change "is not our primary job function" to "is an activity in our spare time":

	Please note that all of us volunteering on Cygwin try to be as responsive as
possible and deal with patches and questions as we get them, but realistically
we don't have time to answer all of the email that is sent to the main mailing
list. Making releases of the tools and packages and helping people out is an
activity in our spare time, so some email will have to go unanswered.

OR

... Making releases of the tools and packages is an activity in our spare time,
helping people out is not our primary focus, so some email will have to go
unanswered.

Perhaps remove or change all FAQ references to Net releases and Win32 in a
separate patch?

Any other comments, suggestions, issues to address?
I don't mind hacking docs - I've done a lot of it for work and IRL.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
