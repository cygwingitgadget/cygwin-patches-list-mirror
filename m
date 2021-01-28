Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id BC30D3851C26
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 10:20:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BC30D3851C26
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MEV7U-1lBA0q0xQ2-00G0x4 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021
 11:20:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 792B0A80D85; Thu, 28 Jan 2021 11:20:29 +0100 (CET)
Date: Thu, 28 Jan 2021 11:20:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Message-ID: <20210128102029.GY4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128025150.46708-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:Iratl5QqjJxU4yfWayZjGDMUAtCU+hVtRiGRMNkrzVJSXIr3fwi
 vj+Wv5ooHmfzcz6Xkccml9dtmQqJDJ4R1dYkGQQeHQjpwsV14aJI0XScl7ylxySTW+CIgCQ
 XwSDRR5ejbNtkyZ9oY/FVZyuq5EWFNefReLU/6Z1WL1jvIHXqMxNvdXevICRbPt11t1hDH6
 H+gRth6lMsIHMd/mDn9fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qK4A1pIBrJc=:LP5wB83yiA8iQxi8MSARMY
 H0UyVQQJ2bRWqeC+wJ4b8Sh4C+GQLp1JdswtFX7DXnwC2p3brIqk2noYrIvdpxH0I0fX92/WC
 3VW61JXNksqX3+sadQIWjbB8JLaOqMR2k1wAZeCeo0JSIZxyLlHdSTOxU9dNusvWPZQ9olmC7
 RHaQzKzZRxkFWg4lzIiJ+S8rD+VzeMrDKybdmh1CrInMSUTbK/eQUZLYYfyYRBGO3mWvQXVwR
 2k5nwmpOq1LUJprMoJceJv6qwANhkxpb+A2rQg+r5h0E/pvKkCiVdNWvVN84r1hfRUqfrsP3C
 qSJv7rnHaYtNUvj4wr1CI6yQAI1RjCaCOmcFDF1pzIa1i4E5Raxkz1dQSBiqhrAYJL3t16a7q
 k+LW2AZ6U3tz7Q5QQt5MyIfhwbmy6C+rQijWi71d1zchdEaWAquvRepmRJVLgNl/d4I4Jky90
 QMSkdjom8Q==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 28 Jan 2021 10:20:33 -0000

On Jan 27 21:51, Ken Brown via Cygwin-patches wrote:
> According to the Linux man page for getdtablesize(3), the latter is
> supposed to return "the maximum number of files a process can have
> open, one more than the largest possible value for a file descriptor."
> The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
> now return that.
> 
> Previously getdtablesize returned the current size of cygheap->fdtab,
> Cygwin's internal file descriptor table.  But this is a dynamically
> growing table, and its current size does not reflect an actual limit
> on the number of open files.
> 
> With this change, gnulib now reports that getdtablesize and
> fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
> corresponding gnulib modules will no longer use gnulib replacements on
> Cygwin.
> ---
>  winsup/cygwin/syscalls.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 5da05b18a..1f16d54b9 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -2887,7 +2887,7 @@ setdtablesize (int size)
>  extern "C" int
>  getdtablesize ()
>  {
> -  return cygheap->fdtab.size;
> +  return OPEN_MAX_MAX;
>  }

getdtablesize is used internally, too.  After this change, the values
returned by sysconf and getrlimit should be revisited as well.


Thanks,
Corinna
