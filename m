Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id B0A23385480E
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 12:16:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B0A23385480E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZTyo-1lS9Lo1eek-00WTyP for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021
 13:16:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E52DDA80D33; Tue, 26 Jan 2021 13:16:41 +0100 (CET)
Date: Tue, 26 Jan 2021 13:16:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: chown: make sure ctime gets updated when necessary
Message-ID: <20210126121641.GO4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210125172455.64675-1-kbrown@cornell.edu>
 <20210125185730.GF4393@calimero.vinschen.de>
 <c40f388a-7afd-a672-06e3-4c92edf4060c@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c40f388a-7afd-a672-06e3-4c92edf4060c@cornell.edu>
X-Provags-ID: V03:K1:+2c0kWltmnY3SilVyqfeTXatoC7btvkAGxETEdB0tt8OdurvQ0F
 bkyXSCSAkXIvLGKxRyw2do5sNcKkZUpo+zRF9ZjfgNqdY3lGtUNo7VNCGvQXz9+Csb/s58V
 jbpR5MRRf+I78j3BrkkzTM7bVenBUjWWq7RNf0ACbTzNnU6EUa2YsPrVd90gFh6ErB1yfzL
 RHzKxDFz7pD1b2TZlEXtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NAae+HApl3g=:bKPnzE8neVArQ9ZGhCaJRB
 OGmr6t5J1HmGxGstYJ0Uh4oV5B+8Jm7txzDiYjqajlHGEbSl+tDhPeM9VtWCjBxeyNyLU8TTi
 IB5mXqLfWMHkwxWkYXYTO5m4o4IT9RX0Cz2z+Kwkhl2Rw8fvmPySyE0k2unXV2FMXEfe+hxfH
 kM3fyXM/O3hcY2PPsSVMRSm2KG2WzF07AZ5t7U9WOyWBaRXMQ6MX6fzI3KEJeF0RPQrf3X05Y
 AfXSii7BcAoLaO9gjgaAFXICrlJ9EZY9yg2O85ONcNQi74DO/jvmLC87oWx8JIsB4h8zr0VW4
 KI/eZL0rkN5Cy+eKZDTx2r7OwtecEdvmG1mBs2VbMBN6JdACXZsuddCTRvx4xSUxc1Zzh5baV
 H9b4FYOgF9srX/hA2j6gwBpznVSQ2ag0y4WMt81n3O5N3KU7guLIUpl6WycL7Z+mTL+1gbNWc
 hek5mQdszw==
X-Spam-Status: No, score=-107.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 26 Jan 2021 12:16:45 -0000

On Jan 25 14:16, Ken Brown via Cygwin-patches wrote:
> On 1/25/2021 1:57 PM, Corinna Vinschen via Cygwin-patches wrote:
> > On Jan 25 12:24, Ken Brown via Cygwin-patches wrote:
> > > Following POSIX, ensure that ctime is updated if chown succeeds,
> > > unless the new owner is specified as (uid_t)-1 and the new group is
> > > specified as (gid_t)-1.  Previously, ctime was unchanged whenever the
> > > owner and group were both unchanged.
> > > 
> > > Aside from POSIX compliance, this fix makes gnulib report that chown
> > > works on Cygwin.  This improves the efficiency of packages like GNU
> > > tar that use gnulib's chown module.  Previously such packages would
> > > use a gnulib replacement for chown on Cygwin.
> > > ---
> > >   winsup/cygwin/fhandler_disk_file.cc | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
> > > index 07f9c513a..72d259579 100644
> > > --- a/winsup/cygwin/fhandler_disk_file.cc
> > > +++ b/winsup/cygwin/fhandler_disk_file.cc
> > > @@ -863,6 +863,7 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
> > >     tmp_pathbuf tp;
> > >     aclent_t *aclp;
> > >     int nentries;
> > > +  bool noop = true;
> > >     if (!pc.has_acls ())
> > >       {
> > > @@ -887,11 +888,18 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
> > >   				    aclp, MAX_ACL_ENTRIES)) < 0)
> > >       goto out;
> > > +  /* According to POSIX, chown can be a no-op if uid is (uid_t)-1 and
> > > +     gid is (gid_t)-1.  Otherwise, even if uid and gid are unchanged,
> > > +     we must ensure that ctime is updated. */
> > >     if (uid == ILLEGAL_UID)
> > >       uid = old_uid;
> > > +  else
> > > +    noop = false;
> > >     if (gid == ILLEGAL_GID)
> > >       gid = old_gid;
> > > -  if (uid == old_uid && gid == old_gid)
> > 
> > Basically ok, but why not just
> > 
> >       if (uid == ILLEGAL_UID && gid == ILLEGAL_GID)
> > 
> > instead of the noop var?
> 
> I went back and forth on that.  Following your suggestion, the code looks like this:
> 
>   if (uid == ILLEGAL_UID && gid == ILLEGAL_GID)
>     {
>       ret = 0;
>       goto out;
>     }
>   if (uid == ILLEGAL_UID)
>     uid = old_uid;
>   if (gid == ILLEGAL_GID)
>     gid = old_gid;
> 
> I was trying to avoid checking uid == ILLEGAL_UID and gid == ILLEGAL_GID
> twice.  But on second thought, it's probably silly to worry about that.  The
> code is cleaner without the noop variable.

Both is ok with me, whatever you think more spiffy here.


Thanks,
Corinna
