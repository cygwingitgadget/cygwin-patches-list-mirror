Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id BAFE83858C20
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 09:57:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BAFE83858C20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2m7O-1oKsE21MVQ-0139Qr for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022
 10:57:06 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C1FDDA80CE4; Mon, 28 Feb 2022 10:57:05 +0100 (CET)
Date: Mon, 28 Feb 2022 10:57:05 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Provide virtual /dev/fd and /dev/{stdin, stdout,
 stderr} symlinks
Message-ID: <YhyccZ1dGKVeRNdp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1645450518.git.johannes.schindelin@gmx.de>
 <YhTYazKXC+2X2TbU@calimero.vinschen.de>
 <nycvar.QRO.7.76.6.2202251645090.11118@tvgsbejvaqbjf.bet>
 <YhyUwucjllyFpkRy@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhyUwucjllyFpkRy@calimero.vinschen.de>
X-Provags-ID: V03:K1:Cr6h3sjeuzoJTMpFbhkj5PLZu5tC982Z+WsWvWAxTlgbbaOa/SD
 uRb3dUnt2GofWG8wtKjQckI/eTNwLFDz3AfwBcGqWFmCryMW45FebYfkhBqNeP5uIk3ShL4
 aR6xeBevSeqIrUfeawzuq16avyTFLyl1POb5FKzLs4nVkM5WU+NZqRZq8qoJbrkS8LxYZxY
 okgk6u5hywZ4/40I9+ZUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kw9lZE9iQ4w=:2HjJojvkrfBoRI9JuBLOjY
 YLwgbo/hhGLABna/b5TvMsSBOPQvuCitS06CohSvnamv1S5EG5jcgiye3UUdB6REpRMsGWPVt
 rAdWsr0viiuhJkPWO3DBR9gdDWS1qYGPkAV/XERqsUZV69XDm0RdsmPLMbmnnsTXcPyTRoPW1
 w8HP2FnxsdiaYA2Ac2XucmUv7d8kpT+aTe+4CkUOo67DQMp7W+jYQeX3kBdCB96E4YOO04Lb1
 k1UK9vfeaNbc4v9sTKLIcbb7y2tCJwWgWPM0E3buL77krzAljaCTMGV36xO/G7UFHSj4ipUvA
 Q85j266AyWFBBbcEfyx/o8TSj/uQUepfi1L+AZRPgd3b3xf0/XS1pLY9SSiMgCsA0VmfxZuke
 knriRpRBAfX391KdhL3vgrru9+pIxWw3AamkokFECKfkr7pqWkqeIxLIINSIxjb03L+Zqk+nk
 h6LbgpPONgpWjmRQBC22yoE3Q0iS7ioU2QL+wpzD3xkIJnX8zFB8cEeAd8s+YdJBPZSX/P/V6
 G2rhc3K/CMIyrlq3JW9MGP8/6Cpqn/1Dq7Ys9iWedmA+xlTglLCQJZyvLBHhihfsSMIZDCUFw
 xAzXIb1ol59d5qWGwSiKXiZofDY95yiH8nsZqe0IZ61JjOZv87FDtV1cB62QUtxKycO8lXke1
 9Dw3DZQol1AM3uFF1kkIuibveVHegd/wJasRpYYTY/SK8098HrdQv5P2TgIxinCGhX06+czAc
 GMKkE3SMloSnSndY
X-Spam-Status: No, score=-96.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 28 Feb 2022 09:57:09 -0000

On Feb 28 10:24, Corinna Vinschen wrote:
> On Feb 25 16:46, Johannes Schindelin wrote:
> > On Tue, 22 Feb 2022, Corinna Vinschen wrote:
> > > On Feb 21 14:36, Johannes Schindelin wrote:
> > > > If there is appetite for it, I wonder whether we should do something similar
> > > > for `/dev/shm` and `/dev/mqueue`? Are these even still used in Cygwin?
> > >
> > > "still used"?  These are the dirs to store POSIX semaphors, message
> > > queues and shared mem objects.
> > 
> > Okay. I guess we do not really use them in Git for Windows ;-)
> 
> Probably not.  I'm not aware that git uses POSIX IPC objects.
> 
> > > These have to be real on-disk dirs.
> > 
> > Could I ask you to help me understand why? Do they have to be writable? Or
> > do the things that are written into them have to be persisted between
> > Cygwin sessions?
> 
> Cygwin uses ordinary on-disk files to emulate the objects, and
> they have to persist over process exits.  Unfortunately I don't
> see any other way to create persistent objects from user space.

Btw., you don't have to create those dirs.  Only if you actually use
POSIX IPC calls, the directories are required.

In fact, the IPC objects are just mmaps (message queues, shared mem
objects), or the file is just used to store the values after closing
the object (semaphores).

With "persistent" I mean, "DLL lifetime persistent".  It's not required
that the objects are persistent until system shutdown, as it is now with
file-based objects.
It would be sufficient if the objects persist until the last Cygwin
process of a Cygwin process tree exits.  I'm open to ideas, but they
shouldn't further slow down the startup of a Cygwin process tree.


Corinna
