Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id 6B3313959E5C
 for <cygwin-patches@cygwin.com>; Tue,  2 Feb 2021 05:28:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6B3313959E5C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id 6oEhlwhE3eHr96oEilU0ny; Mon, 01 Feb 2021 22:28:25 -0700
X-Authority-Analysis: v=2.4 cv=Yq/K+6UX c=1 sm=1 tr=0 ts=6018e2f9
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
 a=oSNnQFfLVqoA:10 a=sRI3_1zDfAgwuvI8zelB:22
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
 <20210128100802.GW4393@calimero.vinschen.de>
 <20210128101429.GX4393@calimero.vinschen.de>
 <4d88d636-8274-5dea-67f8-f224a63b49a9@gmail.com>
 <20210201094009.GD375565@calimero.vinschen.de>
 <ff9e2845-7a5c-945c-f742-a79d65ab5909@gmail.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: fhandler_serial.cc: MARK and SPACE parity for serial port
Message-ID: <9257129f-ad1d-6be1-e9c5-d77dc3c658cf@SystematicSw.ab.ca>
Date: Mon, 1 Feb 2021 22:28:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <ff9e2845-7a5c-945c-f742-a79d65ab5909@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOMkRLcNXs8Ovg85UbvFc4wrGsrL7JuMdIdssQkipOE0VIF0EOksk7f/mALiue27UK+MnSVLxDUsquOuOUWbE7XS8NePwfqj1UpUEMduzBjVO1voNd1H
 FGh4AbVdHT9guxsY9m2z0eLfqCVnMy1ERBc0ASiiTNHayBe5AGYMiCpqQ8CfmEecfz8OgSg22o3JHnykV8RK7HUhwhU6I87ndho=
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
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
X-List-Received-Date: Tue, 02 Feb 2021 05:28:27 -0000

On 2021-02-01 14:26, Marek Smetana via Cygwin-patches wrote:
> I'm Sorry, this is my first patch using the mailing list.

I too struggled for ages getting these right;
first set up your ~/.gitconfig something like:

$ grep -v '^#' ~/.gitconfig
[user]
         name = ...
         email = ...

[sendemail]
         bcc = ...
         smtpServer = ...
         confirm = always

[core]
         editor = /usr/bin/gvim -f

When you commit your changes, the first line of the commit message becomes your 
patch file name and email subject, so keep it < 63, leave a blank line, then 
expand on the details in subsequent lines < 80, so I find it easier to run:

$ git diff @^ > COMMIT_MSG

hack away at that then:

$ git commit -F COMMIT_MSG ...

$ git format-patch --to=cygwin-patches@cygwin.com -1

which will write a file like:

0001-fhandler_serial.cc-MARK-and-SPACE-parity-for-serial-port.patch

hack away at that to improve it then:

$ git send-email --to=cygwin-patches@cygwin.com \
	0001-fhandler_serial.cc-MARK-and-SPACE-parity-for-serial-port.patch

and answer the confirmation message if you enabled that above.

Does anyone know of a way to set different default patch email addresses for 
newlib/ and winsup/ trees?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
