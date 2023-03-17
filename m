Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	by sourceware.org (Postfix) with ESMTPS id 3855838582A4
	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2023 19:15:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3855838582A4
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MKsWr-1pwHRO1XWH-00LArW; Fri, 17 Mar 2023 20:15:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DF844A8073F; Fri, 17 Mar 2023 20:15:53 +0100 (CET)
Date: Fri, 17 Mar 2023 20:15:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: YO4 <ysno@ac.auone-net.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: YO4 <ysno@ac.auone-net.jp>, cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230317144346.871-1-ysno@ac.auone-net.jp>
X-Provags-ID: V03:K1:TVXPlbmFwG63CRzkAkmQdEyJvMbnP7Jbbx541vyFTdOwQKMkRXL
 7CPoH7BNyTP/9c3gTXuUyYxja0/JgyVjkALOWNrS9ZNN5eUwcpVtGitgJ4MGsahWLcgcA2I
 CADO5gTCnI0w5P4Q9DZGLgr4yIOjEXvSKBbyU7Zsegu4Ut8Y2XYM0B/wVNExb/pMqvtoqdw
 NpLAfwLT4Rf2G2JriDVUw==
UI-OutboundReport: notjunk:1;M01:P0:i7R05E/hTPk=;V+UTjjJEY/Ssleh9HsGmPqoSJNk
 afFIXfPymWi3M0S8t2kKcAkNXSXX/J60PYSNmo6q7kG9PWkDXmYy+XXcKJkpKTSCN0tzh/Jo8
 FxTah0glEmGbmtaETqrx+ARUGQ2kSNPYQsLzvVlK8n5guXH8Z9POSJrZDvM7rvcuK1r4hmhX1
 VaAJ+v2XKymc16supcNCFmgPyVy7/O9zDkQTXgFPvZmaoxiBqrdMr/m8iGTt1uGVzD36qa2NE
 QBbF4mJtN+78aMEcPZrbgyi4I+ugDuP/SHCwTjqtJvGjQalmL2h///9ZlRVSCz/PQ8mWsz2Pn
 wGAXMLzKsEdduuYPcGelzMJPeg+N7MD7vwo9Es1831RbBMD8Rx/jbYpu35E7UkrHiqPDE/5pl
 /mO6c4TXB8fzLS6DRqCu3xZu7KUMSSPprY6UxafBsxHGUcUPdFuQNPNK1HuH5MN7XDLyhfkAk
 8yR/zq+Df8pQigtRBR1pPktj3bR82YW+96T/WLc23BQmvXjH9BG7nDcGW8mK6hoobhDq/6byl
 rQ7HUzifTZdBnIx3FjILtyx4cbMlNmvJSwKyFT5snHA+nXnSlpddLSsgCmYPQ09k4YoebnNov
 YLbWtCUuO/OcRVOfVTS+nfj6ZI6d6Rni+P4nZOl0BDoaLtenmzT+IH+xS/ne37XJz07jnPnXc
 wRXsqI99S9fCsiZyMuCiAnjIGtwGGcw6MMuJHaMTrg==
X-Spam-Status: No, score=-97.5 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi,

On Mar 17 23:43, YO4 wrote:
> Hello, cygwin developers.
> I am using msys2 and it is based on the cygwin codebase.
> I was working inside a windows container and encountered rm.exe and mv.exe failures.
> I would be honored if you could merge my patch into upstream.

The patchset looks basically ok, and I'm not opposed to apply it.
But I do wonder if we cant't come up with a better solution somehow.

The problem is that you will suffer another performance hit on top
of the fact that Cygwin is already slow anyway.  Every time you
run rm or rename, you will have to call the OS function twice.
So rm -r will become even slower.

The question here is, do we have a way to recognize a Hyper-V mount?

Have a look at fs_info::update() in mount.cc.  There's a lot of checking
for various filesystems and their quirks.  If we have a way to
distinguish a Hyper-V mount from a "normal" NTFS, we could add it as a
filesystem type of its own, and the "use_posix_semantics" flag would
simply never be set.

If we can do that, it's the cleaner solution, IMHO.

For that, can we start with you running 

  $ cd <your Hyper-V dir>
  $ /usr/lib/csih/getVolInfo .

and paste the output here?  If there's any chance we can recognize
a Hyper-V dir, we should take it.

Oh, and, btw., would you mind to recreate your git patches with your
real name, please?  I'm not hot on adding pseudonyms into the git
repo.  We all use our real names.  Also, a matching `Signed-Off-By:'
would be helpful.


Thanks,
Corinna
