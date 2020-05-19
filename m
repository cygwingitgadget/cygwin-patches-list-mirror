Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id C10C1384A87E
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 19:33:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C10C1384A87E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id b7zAjxSTWng7Kb7zBjpwxT; Tue, 19 May 2020 13:33:10 -0600
X-Authority-Analysis: v=2.3 cv=ecemg4MH c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=Ed7FdIT4gc43trk-okQA:9 a=QEXdDO2ut3YA:10
 a=8pRm4NV5SmQA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: termios: Set ECHOE, ECHOK, ECHOCTL and ECHOKE by
 default.
To: cygwin-patches@cygwin.com
References: <20200517023444.286-1-takashi.yano@nifty.ne.jp>
 <CABPLASQozh_iBkLA-hGpQ88dQ6BHB0m=U_VBSotuM4zFXS3Piw@mail.gmail.com>
 <20200518095027.5965dbaadf685666e126fa13@nifty.ne.jp>
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
Message-ID: <4a536510-8893-3c48-0c16-ff15a7d9a017@SystematicSw.ab.ca>
Date: Tue, 19 May 2020 13:33:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518095027.5965dbaadf685666e126fa13@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI84ZcgZyaj7FK/U1lw0wbASIw+eRd/8CGlxRxsP6JEj6MfzwksoDEXfKdhpbgk1NoKUFvmRqqo4oyXiQSYSV5t/1nOk4redusH75Gkuq7xOP2ofEfte
 aDzYAM2QKMUK/ls/ZWNV2vhl0pVoEpEVmOY0zq6lNLtxHmE8JNjAptM7/S/Hx2TGu15rb0MZqCfw4g==
X-Spam-Status: No, score=-19.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 19 May 2020 19:33:12 -0000

On 2020-05-17 18:50, Takashi Yano wrote:
> On Mon, 18 May 2020 01:21:07 +0200, Kacper Michajlow wrote:
>> On Sun, 17 May 2020 at 04:53, Takashi Yano wrote:

>>> - Backspace key does not work correctly in linux session opend by
>>>   ssh from cygwin console if the shell is bash. This is due to lack
>>>   of these flags.
>>>
>>>   Addresses: https://cygwin.com/pipermail/cygwin/2020-May/244837.html.
>>> ---
>>>  winsup/cygwin/fhandler_termios.cc | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/winsup/cygwin/fhandler_termios.cc
>>> b/winsup/cygwin/fhandler_termios.cc
>>> index b6759b0a7..b03478b87 100644
>>> --- a/winsup/cygwin/fhandler_termios.cc
>>> +++ b/winsup/cygwin/fhandler_termios.cc
>>> @@ -33,7 +33,8 @@ fhandler_termios::tcinit (bool is_pty_master)
>>>        tc ()->ti.c_iflag = BRKINT | ICRNL | IXON | IUTF8;
>>>        tc ()->ti.c_oflag = OPOST | ONLCR;
>>>        tc ()->ti.c_cflag = B38400 | CS8 | CREAD;
>>> -      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN;
>>> +      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN
>>> +       | ECHOE | ECHOK | ECHOCTL | ECHOKE;
>>>
>>>        tc ()->ti.c_cc[VDISCARD] = CFLUSH;
>>>        tc ()->ti.c_cc[VEOL]     = CEOL;
>>> --
>>> 2.21.0

>> Maybe also set  IXANY | IMAXBEL? For reasonable set of default values.

> I don't think so, because they are not set also in xterm in linux.

IMAXBEL defaults in Cygwin mintty and Debian lxterminal:
my non-default settings are in the first output group;
all current settings are in the second output group;
these settings work with no issues across Cygwin and Linux systems;
on BSD YMMV:

Cygwin 3.1.4 mintty 3.1.4 $ stty; echo; stty -a
speed 3000000 baud; line = 0;
erase = ^H;
ixany iutf8

speed 3000000 baud; rows 60; columns 120; line = 0;
intr = ^C; quit = ^\; erase = ^H; kill = ^U; eof = ^D; eol = <undef>; eol2 =
<undef>; swtch = ^Z; start = ^Q; stop = ^S;
susp = ^Z; rprnt = ^R; werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread -clocal -crtscts
-ignbrk brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
-iuclc ixany imaxbel iutf8
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -tostop echoctl echoke -flusho

Debian 10.4 lxterminal 0.3.2 $ stty; echo; stty -a
speed 3000000 baud; line = 0;
erase = ^H; swtch = ^Z;
ixany iutf8

speed 3000000 baud; rows 45; columns 120; line = 0;
intr = ^C; quit = ^\; erase = ^H; kill = ^U; eof = ^D; eol = <undef>; eol2 =
<undef>; swtch = ^Z; start = ^Q; stop = ^S;
susp = ^Z; rprnt = ^R; werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;
-parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts
-ignbrk brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
-iuclc ixany imaxbel iutf8
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt
echoctl echoke -flusho -extproc

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
