Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 138CC3858C3A
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 09:24:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 138CC3858C3A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTi9N-1nm68t385l-00U5ip for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022
 10:24:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 554DCA80CE4; Mon, 28 Feb 2022 10:24:18 +0100 (CET)
Date: Mon, 28 Feb 2022 10:24:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Provide virtual /dev/fd and /dev/{stdin, stdout,
 stderr} symlinks
Message-ID: <YhyUwucjllyFpkRy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1645450518.git.johannes.schindelin@gmx.de>
 <YhTYazKXC+2X2TbU@calimero.vinschen.de>
 <nycvar.QRO.7.76.6.2202251645090.11118@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2202251645090.11118@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:AVmDG/KMlkEGahYpggP6I+Z+91oMnanuKw60HASD5/C6bw0j5KS
 I2LaAXeAdZQnM8w5kKaIb1F22vU6MUAUJF1GDCmdOJoHxURXe1cTSNE8ha9QlCLFwxi64oa
 fidiAAyqkQ1xjZx9SUwX+apHUcCcEPvY6a50LBj1Oe+j2tmPns/an6UcXv+xIu1X9VPWA1X
 NzjgX/mTA3Ssxjac+zCQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0gODj46TKBg=:/KtE6pNOUuN9F1j7JfLHep
 ryhRtNd2c96z8iCR32kl43pvCnE5uIap6uYuno5XSz3RlpzlV3Qh01Xs9XsKb1t5Pvx2tRW5a
 3KwPvCBcdt9hyE+LLjDkQJLqDkCx1NUiOfBWYXMIFxTZVcIo33acku8AiNUGwTCbyAN8LK9bV
 T5ZB8NeCOPCI/xldGj3tYikPEYjulYmwK6CbBnaa2XAdB8fI/+euIsmqwE8DlDYW7kLvhMtJ/
 tAqZP0qOu0J1Epte4c8Bvop/U9+fStYx4jCwf1Gdt9VWCU9Ebg9f8qO1v65Pg1NCi8XB5CLwV
 lmWEWDkwmcPtpXpi8EyCy7aC6GvOveMAAVMPl+Qvg/jvsvbUvrGH+i87fS6MuIG57BoKxr/fg
 vThI/KXchM49NQbACtUZ8zXk2rBTcY1ztOjXK7RGGdhebTYvXxHUmbwmIi6pYurkBMGm9wwse
 IW/aYT0iMWKsS2H4tfUJBfr0DTqIkg+SfjtStpQVDeJOC4ZzHJK3HqWF5R0AvZlpNhl05VpVa
 0lLC20DGOe843u/YYuIt3gRP7sfktY4hnY3zMB7p/5yxXK5HPX1zim8dzv6wfMXsQ1YK0D/NI
 DFVMJSqSsz2dPB9YyQ9FQ9GSS2PQClzu2/wx+VIo8fFAZZ+DGGvezbQ6VBoDMGEkYSUzTQV/5
 zVPZiggb6sE56gvDIT5s0D7ho2/oAXkzr6h9Rdbw6EYoSJPHbFS3oI/rHszJxRUrDJC0DU0G9
 nircQIqk9t0fX8oX
X-Spam-Status: No, score=-96.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Mon, 28 Feb 2022 09:24:21 -0000

On Feb 25 16:46, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Tue, 22 Feb 2022, Corinna Vinschen wrote:
> 
> > On Feb 21 14:36, Johannes Schindelin wrote:
> > > These symbolic links are crucial e.g. to support process substitution (Bash's
> > > very nice `<(SOME-COMMAND)` feature).
> > >
> > > For various reasons, it is a bit cumbersome (or impossible) to generate these
> > > symbolic links in all circumstances where Git for Windows wants to use its
> > > close fork of the Cygwin runtime.
> > >
> > > Therefore, let's just handle these symbolic links as implicit, virtual ones.
> > >
> > > If there is appetite for it, I wonder whether we should do something similar
> > > for `/dev/shm` and `/dev/mqueue`? Are these even still used in Cygwin?
> >
> > "still used"?  These are the dirs to store POSIX semaphors, message
> > queues and shared mem objects.
> 
> Okay. I guess we do not really use them in Git for Windows ;-)

Probably not.  I'm not aware that git uses POSIX IPC objects.

> > These have to be real on-disk dirs.
> 
> Could I ask you to help me understand why? Do they have to be writable? Or
> do the things that are written into them have to be persisted between
> Cygwin sessions?

Cygwin uses ordinary on-disk files to emulate the objects, and
they have to persist over process exits.  Unfortunately I don't
see any other way to create persistent objects from user space.


Corinna
