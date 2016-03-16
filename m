Return-Path: <cygwin-patches-return-8413-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7430 invoked by alias); 16 Mar 2016 22:08:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7418 invoked by uid 89); 16 Mar 2016 22:08:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=4.9 required=5.0 tests=AWL,BAYES_50,GARBLED_SUBJECT,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=schrieb, separated, Wolff, wolff
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 16 Mar 2016 22:08:54 +0000
Received: from [192.168.178.44] ([95.91.214.87]) by mrelayeu.kundenserver.de (mreue104) with ESMTPSA (Nemesis) id 0LrKW4-1ZfRYl1JNM-013AEx for <cygwin-patches@cygwin.com>; Wed, 16 Mar 2016 23:08:51 +0100
Subject: =?UTF-8?Q?Re:_Console_requested_reports_=e2=80=93_Re:_[ANNOUNCEMENT?= =?UTF-8?Q?]_TEST_RELEASE:_Cygwin_2.5.0-0.6?=
To: cygwin-patches@cygwin.com
References: <announce.20160312232737.GA25791@calimero.vinschen.de> <56E80B4B.5040106@towo.net> <20160315134655.GC4177@calimero.vinschen.de> <56E88137.9020307@towo.net> <20160316092816.GB28452@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
Message-ID: <56E9D974.4030804@towo.net>
Date: Wed, 16 Mar 2016 22:08:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20160316092816.GB28452@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qlnbj5t3sFc=:xk6rYcSrZ2tHqASsW7AONA vz5I+JZtd+quFIDTjhIEExXsM9leEq20RnfoZU1G7TDeHjUBpDQgFkcbTBrshbdXbtqIvq+s0 Y+3ieXZqxPToGfQccDNR53EKmu6iLmMIFWK2KBzRgStRgLpFSSiY092n3CetXdmWbgGzYURmV +TlApcY4uJksY8whwbV2x71w3+XpQYF3WrRthxPeavHZf1u5lCVocuL17+IxrUURQ09UYRkKA 3FiT5peSJYWN4txlaTSvgX2eSclBUPs7HTUa525sKiVYe06rnK33wtIxDUVqReTVMCFzfGcQZ J5FoFkgh/PSJESYlwng+OaIMoWsDgEewRNdmY4VX7NphwI2cWbOoyVdUmcCLo9d5py4eHbNbD UUE7WDFwXIPZWLOwt90fbykCiY5tJY1cBYMA2qqTwbo18KNfcDqwnhT18STveHP2j1Q+Td0ck O1rAU6WFwcbFutM3RrgBzzMh1rCpdy4B9+AeieCyQOt6OtQtkMkJItoUwEvyfJNuLmOiet+HD 9yBL4odwvBBabhJlIZrPvP3PEPWiPPcAO4HxMCU8KMY9Inqi4CiomR9iRTJaHbOpQFYwicu7i PXJOm1+48l751zT3f9l/v1KvVuVX80n4TXxK6QC95fSU4/dOeVvtkz/jh6TqquPOYzrBXlyOS gQG8ArCtIyv26pXMsK4t10QbTHYi4r8QOr0mxF8KYgFJHN+3WvRiKW9GNtVcPhnhGRoyu/4qO 1LPhnjdWcbUbbBax
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00119.txt.bz2

Am 16.03.2016 um 10:28 schrieb Corinna Vinschen:
> On Mar 15 22:40, Thomas Wolff wrote:
>> Hi Corinna,
>> here is my updated patch.
>>> Changelog (old format):
>>> Just drop this line from the comment, please.  If you send the mail
>>> via git format-patch/git send-email I can simply apply it with git am
>>> including the entire text in the git log.
>> I hope the comment format is OK now, I cannot currently use git format-patch
>> due to missing setup.
>>
>> Make requested console reports work, cf https://cygwin.com/ml/cygwin-patches/2012-q3/msg00019.html
>>
>> This enables the following ESC sequences:
>> ESC[c sends primary device attributes
>> ESC[>c sends secondary device attributes
>> ESC[6n sends cursor position report
>>
>>      * fhandler.h (class dev_console): Add console read-ahead buffer.
>>      (class fhandler_console): Add peek function for it (for select).
>>      * fhandler_console.cc (fhandler_console::setup): Init buffer.
>>      (fhandler_console::read): Check console read-aheader buffer.
>>      (fhandler_console::char_command): Put responses to terminal
>>      requests (device status and cursor position reports) into
>>      common console buffer (shared between CONOUT/CONIN)
>>      instead of fhandler buffer (separated).
>>      * select.cc (peek_console): Check console read-ahead buffer.
> Patch applied.  Do you have a short text for the release message?
- Enabled console reports requested by escape sequences:
   Requesting primary and secondary device attributes,
   requesting cursor position report;
   see https://cygwin.com/ml/cygwin-patches/2012-q3/msg00019.html

Thanks
Thomas
