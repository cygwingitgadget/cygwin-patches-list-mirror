Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id B0C64385781A
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 18:57:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B0C64385781A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLR5h-1lKxVw1ohP-00IVW1 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021
 19:57:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 48F8EA80D4E; Mon, 25 Jan 2021 19:57:30 +0100 (CET)
Date: Mon, 25 Jan 2021 19:57:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: chown: make sure ctime gets updated when necessary
Message-ID: <20210125185730.GF4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210125172455.64675-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125172455.64675-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:Jrf3NvCMRiX3VowIlXDVEruKNQfXOSgX+FgaqJXz0cGQpnb/nqV
 hnsa6i6Q14LRlbdzLqRFvyWsKCFJB3HJbZzpPLyaPPa/QsGGGB8552KdOkr7u7KIa5Afy2D
 cPlC+w14eeWSjSnFyGgn0OtGzcbuc7YcIdmDzAI3bhCx6d7Rq7WEfJ/p3VkKgssyw07yMBk
 j/j8GnZ9Tp0MMmBTJqGxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k7LLkpAFSMA=:b1eeOm4SOtcjIEli+iMZ9R
 1qZ5qA1hx7CBvR8/XbxE9xCsaG8aYxfFgnV5M/1gYSls/J2Pc3wng8QtobpOeVhIuc4uepWVo
 nRTu3TbDEQT4r40fer0S7ZTKbdYa/+yA+tVRQX++n6uTkSM29dEIzRMg5xxC6lDH0zRGeLgZ3
 UfHAHM7bCJVztpg7Kai57HMN/ecYdS1bQkDF6cJQ7uD5CMX9LUF3RZrDuXX0e7fb1sROHecJF
 kZof3s5a4HMfC0YqhBLMnhkTjraSaLBemySZxLzZK6lV09Io914ZbBkaBvI1qChtoDvRZJ40+
 lgHlymSffSIyh7CDV1EhRS89Z9CLzYcDKJA+fI5szwmn1awpS0ckpv/1IaZnuWCuMP3h44IfH
 2+T3NBeaSrCweE9sFSh1E7tVLdX3ohrJK9DpnRDZXCblo9JITtnwe/hDErFTkuEQwoIUP2BRK
 bNhDlfCfKw==
X-Spam-Status: No, score=-107.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Mon, 25 Jan 2021 18:57:34 -0000

On Jan 25 12:24, Ken Brown via Cygwin-patches wrote:
> Following POSIX, ensure that ctime is updated if chown succeeds,
> unless the new owner is specified as (uid_t)-1 and the new group is
> specified as (gid_t)-1.  Previously, ctime was unchanged whenever the
> owner and group were both unchanged.
> 
> Aside from POSIX compliance, this fix makes gnulib report that chown
> works on Cygwin.  This improves the efficiency of packages like GNU
> tar that use gnulib's chown module.  Previously such packages would
> use a gnulib replacement for chown on Cygwin.
> ---
>  winsup/cygwin/fhandler_disk_file.cc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
> index 07f9c513a..72d259579 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -863,6 +863,7 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
>    tmp_pathbuf tp;
>    aclent_t *aclp;
>    int nentries;
> +  bool noop = true;
>  
>    if (!pc.has_acls ())
>      {
> @@ -887,11 +888,18 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
>  				    aclp, MAX_ACL_ENTRIES)) < 0)
>      goto out;
>  
> +  /* According to POSIX, chown can be a no-op if uid is (uid_t)-1 and
> +     gid is (gid_t)-1.  Otherwise, even if uid and gid are unchanged,
> +     we must ensure that ctime is updated. */
>    if (uid == ILLEGAL_UID)
>      uid = old_uid;
> +  else
> +    noop = false;
>    if (gid == ILLEGAL_GID)
>      gid = old_gid;
> -  if (uid == old_uid && gid == old_gid)

Basically ok, but why not just

     if (uid == ILLEGAL_UID && gid == ILLEGAL_GID)

instead of the noop var?


Corinna
