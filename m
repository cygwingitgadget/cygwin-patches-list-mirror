Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 5CBBD3861027
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 20:55:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5CBBD3861027
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5VPe-1lpmyt0AJu-016zYX for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 21:55:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8DC6DA82675; Mon,  8 Mar 2021 21:55:40 +0100 (CET)
Date: Mon, 8 Mar 2021 21:55:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
Message-ID: <YEaPTIQ2I1DgpPgt@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
 <YEX5FO0ISV06h9QY@calimero.vinschen.de>
 <b62c52a0-fee4-4cc4-bb57-e16169239d9a@SystematicSw.ab.ca>
 <87pn098s1j.fsf@Rainer.invalid>
 <70c973ec-f8c7-f5cc-1d38-f0306b8521c2@SystematicSw.ab.ca>
 <87lfax8nu3.fsf@Rainer.invalid>
 <b81497ce-72d0-f11e-a381-568aa407b98a@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b81497ce-72d0-f11e-a381-568aa407b98a@cornell.edu>
X-Provags-ID: V03:K1:JjbmJASR+numlGV9fzQb5NbsyHSLVch4gbU4Ee0R44+IV5uM0Uk
 utNelT0GukKHnrn5VPs+ZyLDe9Frx+qo6Q2fv0KNuglrx7n+45KpUSm3C7vplvafK9wUnmi
 iyBQJMNKimO3g4yYpu6rXU0trPYG5wqmq+zHxRAnWFfG72RzNG/nYxUShSNz8nFcKNKkEJL
 0p+ZinnqgBAEwB60/qjCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dZFZ/FATCSQ=:Z8Quxq/mAup0/CZq0GvT/Q
 iW2Lbi3OdJ5gIG5Wjy/Ff2r5k4puB7u6WnPxprbsvegr/t5iPf771V6GiGCR4AsOMGRg1qjGc
 eb0jVrMITyLZ2vrICpl+uEqJ+hZcjwaGhj1R08qmv7vL5l/jeByW/O35MZDYUymB1Bao/k+tO
 71Yz8kDTVvzAGOj7+CgyH15MaGf20fjdVf8c3Fk+pFvJPIan977dJ1pl4yDwQzZC6un+NKLPj
 Q2vOQ8X1PFsxqzRYOoqyqCh/1va5DF/qaeoyQZxcZ81Cxco7fMC7E+SUtG26Sopf2yqOwI7O2
 w8djaCZ7znW12pON7N70GuSu+/AYcYl4Yr42TOXxxcgjPlUh+fDovDHdCrMqff7DLm+g6gvev
 BjxCq/o/1l4g2Ag+f91wZnp2gunvCiHLJj23prX0+RyxX7gfF8ALd7EKANFkRFFpmWTKW8upQ
 o7fA/2TCaw==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 08 Mar 2021 20:55:43 -0000

On Mar  8 15:20, Ken Brown via Cygwin-patches wrote:
> On 3/8/2021 2:09 PM, Achim Gratz wrote:
> > Brian Inglis writes:
> > > It's normally a merge conflict which will not be satisfied by regular
> > > commands to restore the working files to upstream.
> > 
> > So you're pulling on an unclean work tree?  That's a no-no, either keep
> > your changes on a separate branch (that you can rebase or merge later)
> > or stash them away for the pull.
> > 
> > As Corinna said, if you're prepared to lose any local changes then
> > 
> > git reset --hard
> > 
> > will do that.  But you should be sure you really didn't want any of your
> > unfinished business around any more.
> 
> If the unfinished business consists of local commits that haven't yet been
> applied upstream, then I typically do the following:
> 
> git fetch  # Find out if upstream has changed since my last pull.  If so...
> git format-patch -n  # save n local commits
> git reset --hard origin/master
> git am 00*  # reapply my local commits

I'm doing this a bit differently:

  git fetch
  git rebase -i origin/master

I like git rebase, it's a very nifty tool, especially using the
interactive mode.


Corinna
