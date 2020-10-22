Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 56A903857C4D
 for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2020 17:27:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 56A903857C4D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MD5fd-1keD4Z39P7-009602 for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2020
 19:27:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4C74AA8093C; Thu, 22 Oct 2020 19:27:10 +0200 (CEST)
Date: Thu, 22 Oct 2020 19:27:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Remove recursive configure for cygwin
Message-ID: <20201022172710.GS5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
 <20201021194705.19056-4-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021194705.19056-4-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:p7C9jg6bMZjEvOQ1ZXydGd1QVGnS0INw9bM56jB2A3xt4QBFW8+
 n3JgVEgqiXIgb1cQqacUymJAqNCRGyrhSinOJHnx35x1RqFy+nuS2E9C6EnpuS2yfw/5HNQ
 aKLfuE22LHhM1dZ0srhwemJXsZY4674qycpEBUlIUudoZFm2bgy7CwYyWY7tjTB4PIImVyY
 KLv5LRbCylcf470Pqup7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:16gx+oDFYWE=:dcYCkwGit7M3KZYFlKGtO3
 a2tXWY0ZphnD7EWLcIAE6lHYeWOasH1Cs4WRyiBEL4MKWO7HoF9fVaNe016tD/64YcapmMaGs
 NVpyzTGufSzALNp/PbE7Pp5hW/jtvvVjZ1wm837d75pk36fMqMPsVJo6pfastguzjv9z3aFN3
 6wA6btaWYr2WVacA4NBavSZ4I3rGyKqDMlpRL3EVyBEAOAB7UYZweyp2+SrWyMvs3EgRdQDWM
 dckqQxxliPM5HnCmRGi5wYiqXjcMdS30OsqZv7rBPfm77BgS6xBmkZT+tbpiZ3j6Q3e3W54J/
 w6n2OcUsu/NY+L8KK9N77plf/ojvmG8Fwr1RY10A/NWgZYnXnW2NVArPP5dhutAO5c1geySS8
 Eh6/fJc7bPGtjGeT85DUt+OyDP96jPU4yUrL7Kh+xu0/kScWH1EwAmCFWJx2saRIkYvwjEkst
 bAL5+hiLuw==
X-Spam-Status: No, score=-100.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 22 Oct 2020 17:27:13 -0000

On Oct 21 20:47, Jon Turney wrote:
> There's doesn't seem to be much use in independently building these
> subdirectories,

Uhm... that doesn't match how I'm working in these dirs.  I'm building
the subdirs independently all the time, especially during debugging
sessions.  I'd not want to lose the ability to build in the
cygwin or utils dirs independently.

> so allowing them to be independently configured seems
> pointless and overcomplicated.

There's not much of a reason to allow independent configuring, I guess,
but apart from the base configure run during a build from top-level,
I sometimes run configure only in the dir I change or add files.

> The order in which the subdirectories are built is still a little odd,
> as cygwin is linked with libcygserver, and cygserver is then linked with
> cygwin. So, we build the cygwin directory first, which invokes a build
> of libcygserver in the cygserver directory, and then build in the
> cygserver directory to build the cygserver executable.

Does creating a new subdir called libcygserver just to build the lib
clean up things, perhaps?


Thanks,
Corinna
