Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 60D593938C10
 for <cygwin-patches@cygwin.com>; Wed, 24 Feb 2021 09:42:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 60D593938C10
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOzKm-1lTBeA3kJY-00PQDb for <cygwin-patches@cygwin.com>; Wed, 24 Feb 2021
 10:42:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5E0DAA80D49; Wed, 24 Feb 2021 10:42:42 +0100 (CET)
Date: Wed, 24 Feb 2021 10:42:42 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Fix facl on files opened with O_PATH
Message-ID: <YDYfkmha8sVqfpsX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210223224950.40895-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223224950.40895-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:db6/a8r7kqIrX5Py7RFE/j9lM+EQ193ARb+ADG/FUoth0JyOi7e
 4GUj7CUCJCJ7CGfkAx7YmWjsjcQsz0+OvNNkTJTVf3tHq0QzlFvTYsjtANBHf5ugyiYMZX2
 GapO5PaIkqmYi7a/Fw0yhaIR1UnskHPdOTTHw80HuseEYob8zEUD5fRJPV5HC/Zl6MJhO/f
 opzFY6UpD3nwuxVIvRxNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aFkQ4x58DmM=:ROdLNx58XZNU3UVwvJGSEI
 5S/jAk4xClz38FVvT+Yd/dBrs49Tnur5zP6kXPFMa4J/Ae0ey7mLi4BQOQOo0p/QgOCAwck0o
 Nh1V5S6wXjVsyM5TUznvjLYGH68Uip111B38bqawl8jiWlsp9nIbVykWUWZZB88yJK8vId3Mu
 uf5bPI4YPg6VUARYAPm1GoVApHza1ifa3sIU1LLsFqNpIoW0BdLn+CMlCGyUEGD+3HG/rST79
 ch2aEAkeoF7PIo7XBivobm0cLFG63MsLcsoyPV2tbH/N//BGUlNUe2Lp3h+ioi3zuUd09PHh7
 uSNJVBhCfKeZBkeyMP1lCc6jUzzCaFww6vho/GpUoFMHv0lRlmH8LaXzL1oCCwoxa/nas/g9a
 aUX/L0w2oXJiUpWjNUpRDMpVPSjVbaREz0hq9NgbCf8mEZnoowg1221iYZwPl9RuapHriRpfJ
 pUZbgZuPOQ==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 24 Feb 2021 09:42:48 -0000

On Feb 23 17:49, Ken Brown via Cygwin-patches wrote:
> I'm not sure if this patch is right.  Should facl fail on all commands
> or just on SETACL?  If the command is GETACL, for example, should this
> fail like fgetxattr(2) or should it succeed like fstat(2)?
> 
> Cygwin may be the only platform that supports both facl(2) and O_PATH,
> so I guess we're on our own here.

Not entirely.  facl is also the underlying function for the POSIX ACL
calls, deprecated but still supported by Linux.  I. e., on a file system
supporting ACLs (xfs, ext4, etc), this needs testing:

  int fd = open (..., O_PATH);
  if (fd < 0)
    perror ("open");
  else if (acl_get_fd (fd) != NULL)
    printf ("acl_get_fd works with O_PATH\n");
  else
    perror ("acl_get_fd");

I just did that and it turns out that the above code returns with

  acl_get_fd: Bad file descriptor

At first I was actually a bit surprised.  I thought fetching ACLs is
along the lines of fstat, but on second though it's not.  ACLs are
stored as extended attributes and given that fgetxattr is supposed to
fail with EBADF, it's logical that acl_get_fd fails with EBADF as well.
qed

So your patch looks good.


Thanks,
Corinna
